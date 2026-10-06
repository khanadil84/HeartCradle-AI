import 'dart:async';

import 'package:flutter/material.dart';

import 'autonomy/chaos_engine.dart';
import 'client.dart';
import 'autonomy/autonomous_mission.dart';
import 'local_event_ledger.dart';
import 'services/mission_audit_stream_service.dart';
import 'package:heartcradle_ai_client/heartcradle_ai_client.dart';

class HeartCradleScreen extends StatefulWidget {
  const HeartCradleScreen({
    super.key,
    required this.onAnalyze,
  });

  final Future<Map<String, String>> Function(
    ChaosScenario scenario,
    void Function(String missionId) onMissionCreated,
    bool simulateSyncFailure,
  ) onAnalyze;

  @override
  State<HeartCradleScreen> createState() => _HeartCradleScreenState();
}

class _HeartCradleScreenState extends State<HeartCradleScreen> {
  final LocalEventLedger _ledger = LocalEventLedger();
  final MissionAuditStreamService _auditStream = MissionAuditStreamService();
  StreamSubscription<AuditEvent>? _auditSubscription;

  bool loading = false;
  String decision = 'READY';
  String reason = 'Waiting for simulated telemetry.';
  String status = 'SYSTEM READY';

  int telemetryHeartRate = 118;
  int telemetrySpo2 = 84;
  int telemetryRespiratoryRate = 24;
  double telemetryTemperature = 37.1;
  String telemetrySignalQuality = 'good';
  String telemetryDescription = 'Simulated low oxygen saturation signal.';

  int localEventCount = 0;
  int pendingEventCount = 0;
  int syncedEventCount = 0;
  List<Map<String, dynamic>> recentEvents = [];

  List<String> executionTrace = [];
  final List<AuditEvent> liveAuditEvents = [];
  String finalState = 'IDLE';
  String automationPath = 'READY';
  String syncStatus = 'READY';
  String syncMessage = 'No synchronization result yet.';

  String recoveryStatus = 'NOT REQUIRED';
  int recoveryAttempts = 0;
  String recoveryMessage = 'No recovery action required.';
  String recoveryLiveEvent = 'RECOVERY_IDLE';

  AutonomousMission? mission;
  String missionStatus = 'IDLE';
  int missionCompletedSteps = 0;
  int missionTotalSteps = 9;
  String missionCurrentStep = 'IDLE';

  ChaosScenario selectedScenario = ChaosScenario.lowSpo2;
  List<Mission> missionHistory = [];
  List<AuditEvent> selectedMissionHistory = [];
  Mission? selectedHistoryMission;
  bool missionHistoryLoading = false;
  bool missionReplayLoading = false;

  @override
  void initState() {
    super.initState();
    _loadLedgerState();
    _loadMissionHistory();
  }

  Future<void> _loadMissionHistory() async {
    if (!mounted) return;

    setState(() {
      missionHistoryLoading = true;
    });

    try {
      final missions = await client.mission.getRecentMissions(limit: 20);

      if (!mounted) return;

      setState(() {
        missionHistory = missions;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        syncMessage = 'Mission history error: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          missionHistoryLoading = false;
        });
      }
    }
  }

  Future<void> _loadMissionReplay(Mission selectedMission) async {
    if (!mounted) return;

    setState(() {
      missionReplayLoading = true;
      selectedHistoryMission = selectedMission;
      selectedMissionHistory = [];
    });

    try {
      final events = await client.mission.getMissionHistory(
        missionId: selectedMission.missionId ?? '',
      );

      if (!mounted) return;

      setState(() {
        selectedMissionHistory = events;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        syncMessage = 'Mission replay error: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          missionReplayLoading = false;
        });
      }
    }
  }
  Future<void> _loadLedgerState() async {
    final count = await _ledger.count();
    final pending = await _ledger.pendingCount();
    final events = await _ledger.readAll();

    if (!mounted) return;

    setState(() {
      localEventCount = count;
      pendingEventCount = pending;
      syncedEventCount = count - pending;
      recentEvents = events.take(8).toList();
    });
  }

  void _startAuditStream(String missionId) {
    _auditSubscription?.cancel();
    liveAuditEvents.clear();

    _auditSubscription = _auditStream.listen(
      missionId,
      onEvent: (event) {
        if (!mounted) return;

        setState(() {
          liveAuditEvents.add(event);
          executionTrace.add(
            ' |  -> ',
          );
          missionCurrentStep = event.toState;

          if (event.toState == 'RECOVERING' ||
              event.event.contains('RECOVERY') ||
              event.event.contains('SYNC_VERIFICATION_FAILED')) {
            recoveryLiveEvent = event.event;
          }
        });
      },
      onError: (error, stackTrace) {
        if (!mounted) return;
        setState(() {
          syncMessage = 'Audit stream error: $error';
        });
      },
    );
  }

  Future<void> analyze() async {
    setState(() {
      loading = true;
      decision = 'PROCESSING';
      reason = 'Running local safety gate and synchronization...';
      status = 'ANALYZING';
      recoveryStatus = 'STANDBY';
      recoveryAttempts = 0;
      recoveryMessage = 'Waiting for synchronization result.';
      recoveryLiveEvent = 'RECOVERY_IDLE';
    });

    try {
      final result = await widget.onAnalyze(
        selectedScenario,
        _startAuditStream,
        selectedScenario == ChaosScenario.serverpodUnavailable,
      );


      await _loadLedgerState();

      if (!mounted) return;

      missionStatus = result['missionStatus'] ?? 'IDLE';
      missionCompletedSteps = int.tryParse(result['missionCompletedSteps'] ?? '') ?? 0;
      missionTotalSteps = int.tryParse(result['missionTotalSteps'] ?? '') ?? 9;
      missionCurrentStep = result['missionCurrentStep'] ?? 'UNKNOWN';

      final parsedRecoveryAttempts =
          int.tryParse(result['recoveryAttempts'] ?? '') ?? 0;
      final parsedRecoveryMessage =
          result['recoveryMessage'] ?? 'No recovery message.';

      final recoveryFailed =
          result['finalState'] == 'FAILED' &&
          parsedRecoveryAttempts > 0;

      final recoverySucceeded =
          parsedRecoveryAttempts > 0 &&
          result['finalState'] == 'COMPLETED';

      setState(() {
        decision = result['decision'] ?? 'UNKNOWN';
        reason = result['reason'] ?? 'No explanation returned.';
        status = decision == 'SAFETY_BLOCKED'
            ? 'HUMAN REVIEW REQUIRED'
            : 'SAFETY CHECK PASSED';

        executionTrace = (result['trace'] ?? '')
            .split('\n')
            .where((step) => step.trim().isNotEmpty)
            .toList();

        telemetryHeartRate =
            int.tryParse(result['telemetryHeartRate'] ?? '') ??
            telemetryHeartRate;

        telemetrySpo2 =
            int.tryParse(result['telemetrySpo2'] ?? '') ??
            telemetrySpo2;

        telemetryRespiratoryRate =
            int.tryParse(result['telemetryRespiratoryRate'] ?? '') ??
            telemetryRespiratoryRate;

        telemetryTemperature =
            double.tryParse(result['telemetryTemperature'] ?? '') ??
            telemetryTemperature;

        telemetrySignalQuality =
            result['telemetrySignalQuality'] ?? telemetrySignalQuality;

        telemetryDescription =
            result['scenarioDescription'] ?? telemetryDescription;

        finalState = result['finalState'] ?? 'UNKNOWN';

        automationPath =
            result['decision'] == 'SAFETY_BLOCKED'
                ? 'SAFETY HALTED'
                : 'AUTOMATED PATH ACTIVE';

        syncStatus = result['syncStatus'] ?? 'UNKNOWN';
        syncMessage =
            result['syncMessage'] ?? 'No synchronization message.';

        recoveryAttempts = parsedRecoveryAttempts;
        recoveryMessage = parsedRecoveryMessage;

        if (recoveryFailed) {
          recoveryStatus = 'FAILED';
        } else if (recoverySucceeded) {
          recoveryStatus = 'RECOVERED';
        } else {
          recoveryStatus = 'NOT REQUIRED';
        }
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        decision = 'SYSTEM_ERROR';
        reason = e.toString();
        status = 'SYSTEM ERROR';
        recoveryStatus = 'ERROR';
        recoveryMessage = 'Recovery status unavailable.';
      });
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  void dispose() {
    _auditSubscription?.cancel();
    super.dispose();
  }

  Widget _statusDot(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 7),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final blocked = decision == 'SAFETY_BLOCKED';

    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1420),
        title: const Text(
          'HEARTCRADLE AI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'SERVERPOD CORE',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                'SIMULATION MODE',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1050),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Emergency Operations Console',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Offline-first, safety-gated, autonomous operations powered by Serverpod',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1420),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF1D2A3A)),
                  ),
                  child: Row(
                    children: [
                      _statusDot('SERVERPOD CORE', Colors.lightBlueAccent),
                      const SizedBox(width: 18),
                      _statusDot('SIMULATION', Colors.amber),
                      const SizedBox(width: 18),
                      _statusDot('OFFLINE-FIRST', Colors.greenAccent),
                      const SizedBox(width: 18),
                      _statusDot('MISSION READY', Colors.greenAccent),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _panel(
                  'SYSTEM STATE',
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _statusCard(
                              icon: Icons.storage_rounded,
                              title: 'LOCAL EVENT LEDGER',
                              value:
                                  '$localEventCount EVENT${localEventCount == 1 ? '' : 'S'}',
                              subtitle: 'Persisted on device',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _statusCard(
                              icon: Icons.cloud_done_rounded,
                              title: 'SERVERPOD CORE',
                              value: 'SYNC ENGINE',
                              subtitle: pendingEventCount == 0
                                  ? 'All local events synchronized'
                                  : '$pendingEventCount event${pendingEventCount == 1 ? '' : 's'} pending',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _miniState(
                              label: 'SYNCED',
                              value: '$syncedEventCount',
                              icon: Icons.cloud_done_outlined,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _miniState(
                              label: 'PENDING',
                              value: '$pendingEventCount',
                              icon: Icons.cloud_upload_outlined,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _miniState(
                              label: 'LOCAL',
                              value: '$localEventCount',
                              icon: Icons.memory_outlined,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _panel(
                  'CHAOS SIMULATION',
                  Row(
                    children: [
                      const Icon(
                        Icons.science_outlined,
                        color: Colors.amber,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<ChaosScenario>(
                            value: selectedScenario,
                            isExpanded: true,
                            dropdownColor: const Color(0xFF111B2A),
                            items: ChaosScenario.values.map((scenario) {
                              return DropdownMenuItem<ChaosScenario>(
                                value: scenario,
                                child: Text(
                                  _scenarioLabel(scenario),
                                  style: const TextStyle(fontSize: 13),
                                ),
                              );
                            }).toList(),
                            onChanged: loading
                                ? null
                                : (scenario) {
                                    if (scenario == null) return;

                                    setState(() {
                                      selectedScenario = scenario;
                                    });
                                  },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _panel(
                  'LIVE SIMULATED TELEMETRY',
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _metric(
                        'HEART RATE',
                        telemetryHeartRate.toString(),
                        'BPM',
                      ),
                      _metric(
                        'SpO2',
                        telemetrySpo2.toString(),
                        '%',
                      ),
                      _metric(
                        'RESPIRATORY',
                        telemetryRespiratoryRate.toString(),
                        'BREATH/MIN',
                      ),
                      _metric(
                        'TEMPERATURE',
                        telemetryTemperature.toStringAsFixed(1),
                        '\u00B0C',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _panel(
                  'AUTONOMOUS MISSION',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _metric(
                              'STATUS',
                              missionStatus,
                              '',
                            ),
                          ),
                          Expanded(
                            child: _metric(
                              'STEP',
                              '$missionCompletedSteps/$missionTotalSteps',
                              '',
                            ),
                          ),
                          Expanded(
                            child: _metric(
                              'CURRENT',
                              missionCurrentStep,
                              '',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: missionTotalSteps == 0
                              ? 0
                              : (missionCompletedSteps / missionTotalSteps)
                                  .clamp(0.0, 1.0),
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'MISSION PROGRESS',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            '${missionTotalSteps == 0 ? 0 : (($missionCompletedSteps / $missionTotalSteps) * 100).round()}%',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Autonomous workflow: ingest -> triage -> safety gate -> '
                        'orchestration -> persistence -> sync -> verification',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _panel(
                  'NEVER-GUESS SAFETY GATE',
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: blocked
                          ? const Color(0xFF281117)
                          : const Color(0xFF101A2A),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color:
                            blocked ? Colors.redAccent : Colors.blueAccent,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          decision,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: blocked
                                ? Colors.redAccent
                                : Colors.lightBlueAccent,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          reason,
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          status,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),                const SizedBox(height: 20),
                _panel(
                  'AUTONOMOUS EXECUTION TRACE',
                  _executionTracePanel(),
                ),
                const SizedBox(height: 20),
                _panel(
                  'RECOVERY STATUS',
                  _recoveryPanel(),
                ),
                const SizedBox(height: 20),
                _panel(
                  'MISSION HISTORY / REPLAY',
                  _missionHistoryPanel(),
                ),
                const SizedBox(height: 20),                _panel(
                  'EVENT TIMELINE',
                  recentEvents.isEmpty
                      ? Text(
                          'No events recorded yet.',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                        )
                      : Column(
                          children: recentEvents
                              .map((event) => _eventTile(event))
                              .toList(),
                        ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton.icon(
                    onPressed: loading ? null : analyze,
                    icon: loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.shield_outlined),
                    label: Text(
                      loading
                          ? 'ANALYZING TELEMETRY...'
                          : 'RUN SAFETY-GATED TRIAGE',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                'SIM-PATIENT-001',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _scenarioLabel(ChaosScenario scenario) {
    switch (scenario) {
      case ChaosScenario.normal:
        return 'NORMAL';
      case ChaosScenario.unreliableSignal:
        return 'UNRELIABLE SIGNAL';
      case ChaosScenario.lowSpo2:
        return 'LOW SPO2';
      case ChaosScenario.conflictingTelemetry:
        return 'CONFLICTING TELEMETRY';
      case ChaosScenario.missingSensor:
        return 'MISSING SENSOR';
      case ChaosScenario.serverpodUnavailable:
        return 'SERVERPOD UNAVAILABLE';
    }
  }

  Widget _missionHistoryPanel() {
    if (missionHistoryLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (missionHistory.isEmpty) {
      return Text(
        'No completed missions available yet.',
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 13,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...missionHistory.map(
          (item) => Card(
            color: const Color(0xFF0A111D),
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(
                item.missionId ?? 'UNKNOWN MISSION',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              subtitle: Text(
                '${item.status} • ${item.completedSteps}/${item.totalSteps} steps',
              ),
              trailing: FilledButton.tonal(
                onPressed: missionReplayLoading
                    ? null
                    : () => _loadMissionReplay(item),
                child: const Text('REPLAY'),
              ),
            ),
          ),
        ),
        if (selectedHistoryMission != null) ...[
          const SizedBox(height: 14),
          Text(
            'REPLAY: ${selectedHistoryMission!.missionId}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          if (missionReplayLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            )
          else if (selectedMissionHistory.isEmpty)
            Text(
              'No audit events found for this mission.',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13,
              ),
            )
          else
            Column(
              children: selectedMissionHistory.map(
                (event) => ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                  ),
                  title: Text(
                    event.event,
                    style: const TextStyle(fontSize: 12),
                  ),
                  subtitle: Text(
                    '${event.fromState} ? ${event.toState}',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 11,
                    ),
                  ),
                ),
              ).toList(),
            ),
        ],
      ],
    );
  }
  Widget _executionTracePanel() {
    if (executionTrace.isEmpty) {
      return Text(
        'No autonomous execution recorded yet.',
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 13,
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _traceSummary(
                'FINAL STATE',
                finalState,
                Icons.account_tree_outlined,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _traceSummary(
                'AUTOMATION PATH',
                automationPath,
                automationPath == 'SAFETY HALTED'
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _traceSummary(
                'SYNC',
                syncStatus,
                Icons.cloud_sync_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF0A111D),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF1B2638),
            ),
          ),
          child: Column(
            children: executionTrace.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;

              final blocked = step.contains('SAFETY_BLOCKED');
              final recovering = step.contains('RECOVERING');

              final icon = blocked
                  ? Icons.warning_amber_rounded
                  : recovering
                      ? Icons.sync_problem_rounded
                      : Icons.check_circle_outline;

              final iconColor = blocked
                  ? Colors.redAccent
                  : recovering
                      ? Colors.amber
                      : Colors.lightBlueAccent;

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == executionTrace.length - 1 ? 0 : 9,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      size: 18,
                      color: iconColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        step,
                        style: TextStyle(
                          color: blocked
                              ? Colors.redAccent
                              : Colors.grey.shade300,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            syncMessage,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _recoveryPanel() {
    final isFailed = recoveryStatus == 'FAILED';
    final isRecovered = recoveryStatus == 'RECOVERED';
    final isStandby = recoveryStatus == 'STANDBY';

    final icon = isFailed
        ? Icons.error_outline
        : isRecovered
            ? Icons.verified_outlined
            : isStandby
                ? Icons.sync_outlined
                : Icons.shield_outlined;

    final iconColor = isFailed
        ? Colors.redAccent
        : isRecovered
            ? Colors.lightBlueAccent
            : isStandby
                ? Colors.amber
                : Colors.grey;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0A111D),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isFailed
              ? Colors.redAccent
              : isRecovered
                  ? Colors.lightBlueAccent
                  : const Color(0xFF1B2638),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 28,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recoveryStatus,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  recoveryAttempts == 0
                      ? 'No synchronization recovery required.'
                      : '$recoveryAttempts recovery attempt${recoveryAttempts == 1 ? '' : 's'} executed.',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  recoveryMessage,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _traceSummary(
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF111B2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1B2638),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 19,
            color: Colors.lightBlueAccent,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventTile(Map<String, dynamic> event) {
    final synced = event['syncState'] == 'SYNCED';
    final decision = event['decision']?.toString() ?? 'UNKNOWN';
    final eventId = event['id']?.toString() ?? '-';
    final spo2 = event['spo2']?.toString() ?? '-';
    final heartRate = event['heartRate']?.toString() ?? '-';
    final createdAt = event['createdAt']?.toString() ?? '';

    String timeText = createdAt;

    try {
      final date = DateTime.parse(createdAt).toLocal();
      timeText =
          '${date.hour.toString().padLeft(2, '0')}:'
          '${date.minute.toString().padLeft(2, '0')}:'
          '${date.second.toString().padLeft(2, '0')}';
    } catch (_) {}

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF111B2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: synced
              ? const Color(0xFF1B2638)
              : Colors.amber.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            synced
                ? Icons.cloud_done_outlined
                : Icons.cloud_upload_outlined,
            color: synced ? Colors.lightBlueAccent : Colors.amber,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'TRIAGE_ANALYSIS',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    Text(
                      timeText,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  decision,
                  style: TextStyle(
                    color: decision == 'SAFETY_BLOCKED'
                        ? Colors.redAccent
                        : Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'SpO2 $spo2%  |  HR $heartRate bpm',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  synced ? 'SYNCED' : 'LOCAL_ONLY',
                  style: TextStyle(
                    color: synced ? Colors.lightBlueAccent : Colors.amber,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Event ID: $eventId',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111B2A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1B2638)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.lightBlueAccent,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniState({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0A111D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1B2638)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.lightBlueAccent,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _panel(String title, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1420),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF1B2638)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _metric(String title, String value, String unit) {
    return Container(
      width: 190,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF111B2A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
































