import 'safety_agent.dart';
import 'triage_agent.dart';

class OrchestrationResult {
  final String workflow;
  final TriageAssessment triage;
  final SafetyDecision safety;
  final List<String> executionTrace;

  const OrchestrationResult({
    required this.workflow,
    required this.triage,
    required this.safety,
    required this.executionTrace,
  });
}

class HeartCradleOrchestrator {
  final TriageAgent triageAgent;
  final SafetyAgent safetyAgent;

  const HeartCradleOrchestrator({
    this.triageAgent = const TriageAgent(),
    this.safetyAgent = const SafetyAgent(),
  });

  OrchestrationResult run({
    required int heartRate,
    required int spo2,
    required int respiratoryRate,
    required double temperature,
    required String signalQuality,
  }) {
    final trace = <String>[
      'ORCHESTRATOR_STARTED',
    ];

    final triage = triageAgent.assess(
      heartRate: heartRate,
      spo2: spo2,
      respiratoryRate: respiratoryRate,
      temperature: temperature,
      signalQuality: signalQuality,
    );

    trace.add('TRIAGE_AGENT_COMPLETED');

    final safety = safetyAgent.evaluate(triage);

    trace.add('SAFETY_AGENT_COMPLETED');

    if (safety.decision == 'SAFETY_BLOCKED') {
      trace.add('SAFETY_BLOCKED');
      trace.add('HUMAN_REVIEW_REQUIRED');
    } else {
      trace.add('SAFETY_GATE_PASSED');
    }

    trace.add('ORCHESTRATOR_DECISION_READY');

    return OrchestrationResult(
      workflow: 'HEARTCRADLE_AUTONOMOUS_TRIAGE',
      triage: triage,
      safety: safety,
      executionTrace: trace,
    );
  }
}
