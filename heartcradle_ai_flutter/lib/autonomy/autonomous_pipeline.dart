import '../agents/safety_agent.dart';
import '../client.dart';
import '../agents/triage_agent.dart';
import '../agents/orchestrator.dart';
import '../local_event_ledger.dart';
import '../services/offline_sync_service.dart';
import 'autonomous_state_machine.dart';
import 'mission_controller.dart';
import 'autonomous_mission.dart';
import 'recovery_engine.dart';

class AutonomousPipelineResult {
  final String missionId;
  final AutonomousMission mission;
  final String patientId;
  final TriageAssessment triage;
  final SafetyDecision safety;
  final SyncResult sync;
  final AutonomousState finalState;
  final List<AutonomousTransition> transitions;
  final int recoveryAttempts;
  final String recoveryMessage;

  const AutonomousPipelineResult({
    required this.missionId,
    required this.mission,
    required this.patientId,
    required this.triage,
    required this.safety,
    required this.sync,
    required this.finalState,
    required this.transitions,
    required this.recoveryAttempts,
    required this.recoveryMessage,
  });
}

class AutonomousPipeline {
  final TriageAgent triageAgent;
  final SafetyAgent safetyAgent;
  final HeartCradleOrchestrator orchestrator;
  final LocalEventLedger ledger;
  final OfflineSyncService syncService;
  late final RecoveryEngine recoveryEngine;

  AutonomousPipeline({
    this.triageAgent = const TriageAgent(),
    this.safetyAgent = const SafetyAgent(),
    HeartCradleOrchestrator? orchestrator,
    LocalEventLedger? ledger,
    OfflineSyncService? syncService,
  })  : ledger = ledger ?? LocalEventLedger(),
        syncService = syncService ?? OfflineSyncService(),
        orchestrator = orchestrator ?? HeartCradleOrchestrator(
          triageAgent: triageAgent,
          safetyAgent: safetyAgent,
        ) {
    recoveryEngine = RecoveryEngine(
      syncService: this.syncService,
    );
  }

  Future<AutonomousPipelineResult> run({
    void Function(String missionId)? onMissionCreated,
    bool simulateSyncFailure = false,
    required String patientId,
    required int heartRate,
    required int spo2,
    required int respiratoryRate,
    required double temperature,
    required String signalQuality,
  }) async {
    final controller = AutonomousMissionController(
      patientId: patientId,
    );

    await client.mission.startMission(
      missionId: controller.missionId,
      patientId: patientId,
      totalSteps: AutonomousMissionController.totalSteps,
    );

    onMissionCreated?.call(controller.missionId);

    var recoveryAttempts = 0;
    var recoveryMessage = 'Recovery not required.';

    // 1. INGEST
    await controller.advance(
      AutonomousState.ingesting,
      'TELEMETRY_RECEIVED',
    );

    // 2. TRIAGE AGENT
    await controller.advance(
      AutonomousState.analyzing,
      'START_ANALYSIS',
    );

    final orchestration = orchestrator.run(
      heartRate: heartRate,
      spo2: spo2,
      respiratoryRate: respiratoryRate,
      temperature: temperature,
      signalQuality: signalQuality,
    );

    final triage = orchestration.triage;
    final safety = orchestration.safety;

    // 3. SAFETY AGENT
    await controller.advance(
      AutonomousState.safetyEvaluating,
      'START_SAFETY_EVALUATION',
    );

    if (safety.decision == 'SAFETY_BLOCKED') {
      await controller.advance(
        AutonomousState.safetyBlocked,
        'SAFETY_GATE_BLOCKED',
      );

      await controller.advance(
        AutonomousState.safetyHalted,
        'AUTOMATED_PATH_HALTED',
      );
    } else {
      await controller.advance(
        AutonomousState.executing,
        'SAFETY_GATE_PASSED',
      );
    }

    // 4. LOCAL PERSISTENCE
    await controller.advance(
      AutonomousState.persisting,
      'EVENT_READY_FOR_PERSISTENCE',
    );

    await ledger.append(
      patientId: patientId,
      eventType: 'TRIAGE_ANALYSIS',
      heartRate: heartRate,
      spo2: spo2,
      respiratoryRate: respiratoryRate,
      temperature: temperature,
      signalQuality: signalQuality,
      decision: safety.decision,
      reason: safety.reason,
    );

    // 5. SERVERPOD SYNCHRONIZATION
    await controller.advance(
      AutonomousState.synchronizing,
      'LOCAL_EVENT_PERSISTED',
    );

    var sync = simulateSyncFailure
        ? const SyncResult(
            status: SyncStatus.failed,
            syncedCount: 0,
            remainingCount: 1,
            message: 'Chaos mode: simulated Serverpod synchronization failure.',
          )
        : await syncService.syncPendingEvents();

    // 6. RECOVERY
    if (sync.status != SyncStatus.synced) {
      await controller.advance(
        AutonomousState.recovering,
        'SYNC_NOT_COMPLETE',
      );

      final recovery = await recoveryEngine.recover();

      recoveryAttempts = recovery.attempts;
      recoveryMessage = recovery.message;
      sync = recovery.sync;

      if (!recovery.recovered) {
        await controller.advance(
          AutonomousState.failed,
          'RECOVERY_EXHAUSTED',
        );
      } else {
        await controller.advance(
          AutonomousState.synchronizing,
          'RECOVERY_RETRY_SUCCEEDED',
        );

        await controller.advance(
          AutonomousState.verifying,
          'SYNC_COMPLETED_AFTER_RECOVERY',
        );

        final remaining = await ledger.pendingCount();

        if (remaining == 0) {
          await controller.advance(
            AutonomousState.completed,
            'SYNC_VERIFIED_AFTER_RECOVERY',
          );
        } else {
          await controller.advance(
            AutonomousState.recovering,
            'SYNC_VERIFICATION_FAILED',
          );
        }
      }
    } else {
      // 7. VERIFY SYNCHRONIZATION
      await controller.advance(
        AutonomousState.verifying,
        'SYNC_COMPLETED',
      );

      final remaining = await ledger.pendingCount();

      if (remaining == 0) {
        await controller.advance(
          AutonomousState.completed,
          'SYNC_VERIFIED',
        );
      } else {
        await controller.advance(
          AutonomousState.recovering,
          'SYNC_VERIFICATION_FAILED',
        );
      }
    }

    final mission = controller.snapshot();

    return AutonomousPipelineResult(
      missionId: mission.id,
      mission: mission,
      patientId: patientId,
      triage: triage,
      safety: safety,
      sync: sync,
      finalState: controller.state,
      transitions: controller.transitions,
      recoveryAttempts: recoveryAttempts,
      recoveryMessage: recoveryMessage,
    );
  }
}










