import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class TriageEndpoint extends Endpoint {
  Future<TriageEvent> analyzeTelemetry(
    Session session, {
    required String patientId,
    required int heartRate,
    required int spo2,
    required int respiratoryRate,
    required double temperature,
    required String signalQuality,
  }) async {
    String decision = 'SAFE';
    String reason = 'Telemetry passed deterministic safety checks.';

    // NEVER-GUESS SAFETY GATE
    //
    // If telemetry quality is uncertain, the system does not invent
    // a clinical conclusion. It blocks automated progression.
    if (signalQuality.toLowerCase() != 'good') {
      decision = 'SAFETY_BLOCKED';
      reason = 'Signal quality is insufficient for automated progression.';
    } else if (spo2 < 90) {
      decision = 'SAFETY_BLOCKED';
      reason = 'Low SpO2 detected. Human clinical review required.';
    } else if (heartRate > 140 || heartRate < 40) {
      decision = 'SAFETY_BLOCKED';
      reason = 'Heart-rate value crossed the configured safety boundary.';
    } else if (respiratoryRate > 30 || respiratoryRate < 8) {
      decision = 'SAFETY_BLOCKED';
      reason = 'Respiratory-rate value crossed the configured safety boundary.';
    } else if (temperature > 40 || temperature < 35) {
      decision = 'SAFETY_BLOCKED';
      reason = 'Temperature value crossed the configured safety boundary.';
    }

    final event = TriageEvent(
      patientId: patientId,
      heartRate: heartRate,
      spo2: spo2,
      respiratoryRate: respiratoryRate,
      temperature: temperature,
      signalQuality: signalQuality,
      decision: decision,
      reason: reason,
      createdAt: DateTime.now().toUtc(),
    );

    await TriageEvent.db.insertRow(session, event);

    return event;
  }
}
