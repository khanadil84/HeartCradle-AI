import 'package:flutter/material.dart';

import 'client.dart';
import 'dashboard.dart';
import 'autonomy/autonomous_pipeline.dart';
import 'autonomy/chaos_engine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeClient();

  runApp(
    const HeartCradleApp(),
  );
}

class HeartCradleApp extends StatelessWidget {
  const HeartCradleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeartCradle AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1769E0),
          brightness: Brightness.dark,
        ),
      ),
      home: HeartCradleScreen(
        onAnalyze: _analyzeTelemetry,
      ),
    );
  }
}

Future<Map<String, String>> _analyzeTelemetry(
  ChaosScenario scenario,
  void Function(String missionId)? onMissionCreated,
  bool simulateSyncFailure,
) async {
  const patientId = 'SIM-PATIENT-001';

  const chaosEngine = ChaosEngine();
  final telemetry = chaosEngine.generate(scenario);

  final pipeline = AutonomousPipeline();

  final result = await pipeline.run(
    patientId: patientId,
    simulateSyncFailure: simulateSyncFailure,
    heartRate: telemetry.heartRate,
    spo2: telemetry.spo2,
    respiratoryRate: telemetry.respiratoryRate,
    temperature: telemetry.temperature,
    signalQuality: telemetry.signalQuality,
    onMissionCreated: onMissionCreated,
  );

  final trace = result.transitions
      .map(
        (transition) =>
            '${transition.event} | '
            '${transition.from.name.toUpperCase()} -> '
            '${transition.to.name.toUpperCase()}',
      )
      .join('\n');

  return {
    'missionId': result.mission.id,
    'missionStatus': result.mission.status.name.toUpperCase(),
    'missionCompletedSteps': result.mission.completedSteps.toString(),
    'missionTotalSteps': result.mission.totalSteps.toString(),
    'missionCurrentStep': result.mission.currentStep,
    'decision': result.safety.decision,
    'reason': result.safety.reason,
    'workflow': 'HEARTCRADLE_AUTONOMOUS_TRIAGE',
    'triageSeverity': result.triage.severity,
    'signalCount': result.triage.signals.length.toString(),
    'trace': trace,
    'finalState': result.finalState.name.toUpperCase(),
    'syncStatus': result.sync.status.name.toUpperCase(),
    'syncMessage': result.sync.message,
    'syncedCount': result.sync.syncedCount.toString(),
    'remainingCount': result.sync.remainingCount.toString(),
    'recoveryAttempts': result.recoveryAttempts.toString(),
    'recoveryMessage': result.recoveryMessage,
    'scenario': scenario.name.toUpperCase(),
    'scenarioDescription': telemetry.description,
    'telemetryHeartRate': telemetry.heartRate.toString(),
    'telemetrySpo2': telemetry.spo2.toString(),
    'telemetryRespiratoryRate': telemetry.respiratoryRate.toString(),
    'telemetryTemperature': telemetry.temperature.toString(),
    'telemetrySignalQuality': telemetry.signalQuality,
  };
}













