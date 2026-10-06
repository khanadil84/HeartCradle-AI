class TriageAssessment {
  final String agent;
  final String severity;
  final List<String> signals;
  final String recommendation;

  const TriageAssessment({
    required this.agent,
    required this.severity,
    required this.signals,
    required this.recommendation,
  });
}

class TriageAgent {
  const TriageAgent();

  TriageAssessment assess({
    required int heartRate,
    required int spo2,
    required int respiratoryRate,
    required double temperature,
    required String signalQuality,
  }) {
    final signals = <String>[];

    // Data-integrity checks take priority over physiological thresholds.
    // Never interpret missing/unreliable telemetry as a real patient value.
    final normalizedSignal = signalQuality.toLowerCase();

    if (normalizedSignal == 'conflicting') {
      signals.add('CONFLICTING_TELEMETRY');
    } else if (normalizedSignal != 'good') {
      signals.add('SIGNAL_QUALITY_UNRELIABLE');
    } else {
      if (spo2 < 90) {
        signals.add('LOW_SPO2');
      }

      if (heartRate > 140 || heartRate < 40) {
        signals.add('HEART_RATE_BOUNDARY');
      }

      if (respiratoryRate > 30 || respiratoryRate < 8) {
        signals.add('RESPIRATORY_RATE_BOUNDARY');
      }

      if (temperature > 40 || temperature < 35) {
        signals.add('TEMPERATURE_BOUNDARY');
      }
    }

    final severity = signals.isEmpty ? 'NORMAL' : 'HIGH_ATTENTION';

    return TriageAssessment(
      agent: 'TRIAGE_AGENT',
      severity: severity,
      signals: signals,
      recommendation: signals.isEmpty
          ? 'Telemetry does not contain configured anomaly signals.'
          : 'Anomaly signals detected. Forward to deterministic safety evaluation.',
    );
  }
}
