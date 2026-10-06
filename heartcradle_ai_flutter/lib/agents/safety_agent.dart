import 'triage_agent.dart';

class SafetyDecision {
  final String agent;
  final String decision;
  final String reason;

  const SafetyDecision({
    required this.agent,
    required this.decision,
    required this.reason,
  });
}

class SafetyAgent {
  const SafetyAgent();

  SafetyDecision evaluate(TriageAssessment assessment) {
    if (assessment.signals.isEmpty) {
      return const SafetyDecision(
        agent: 'SAFETY_AGENT',
        decision: 'SAFE',
        reason: 'No configured safety-boundary signals detected.',
      );
    }

    final primarySignal = assessment.signals.first;

    switch (primarySignal) {
      case 'CONFLICTING_TELEMETRY':
        return const SafetyDecision(
          agent: 'SAFETY_AGENT',
          decision: 'SAFETY_BLOCKED',
          reason: 'Conflicting telemetry requires human clinical review.',
        );

      case 'LOW_SPO2':
        return const SafetyDecision(
          agent: 'SAFETY_AGENT',
          decision: 'SAFETY_BLOCKED',
          reason: 'Low SpO2 detected. Human clinical review required.',
        );

      case 'HEART_RATE_BOUNDARY':
        return const SafetyDecision(
          agent: 'SAFETY_AGENT',
          decision: 'SAFETY_BLOCKED',
          reason: 'Heart-rate value crossed the configured safety boundary.',
        );

      case 'RESPIRATORY_RATE_BOUNDARY':
        return const SafetyDecision(
          agent: 'SAFETY_AGENT',
          decision: 'SAFETY_BLOCKED',
          reason:
              'Respiratory-rate value crossed the configured safety boundary.',
        );

      case 'TEMPERATURE_BOUNDARY':
        return const SafetyDecision(
          agent: 'SAFETY_AGENT',
          decision: 'SAFETY_BLOCKED',
          reason: 'Temperature value crossed the configured safety boundary.',
        );

      case 'SIGNAL_QUALITY_UNRELIABLE':
        return const SafetyDecision(
          agent: 'SAFETY_AGENT',
          decision: 'SAFETY_BLOCKED',
          reason:
              'Signal quality is insufficient for automated progression.',
        );

      default:
        return const SafetyDecision(
          agent: 'SAFETY_AGENT',
          decision: 'SAFETY_BLOCKED',
          reason: 'Unrecognized telemetry signal requires human review.',
        );
    }
  }
}
