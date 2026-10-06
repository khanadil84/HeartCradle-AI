import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class SyncEndpoint extends Endpoint {
  Future<TriageEvent> syncLocalEvent(
    Session session, {
    required String eventId,
    required String patientId,
    required int heartRate,
    required int spo2,
    required int respiratoryRate,
    required double temperature,
    required String signalQuality,
    required String decision,
    required String reason,
    required DateTime createdAt,
  }) async {
    // IDEMPOTENCY CHECK:
    // If this local event was already synchronized, return
    // the existing server record instead of creating a duplicate.
    final existing = await TriageEvent.db.findFirstRow(
      session,
      where: (t) => t.eventId.equals(eventId),
    );

    if (existing != null) {
      return existing;
    }

    final event = TriageEvent(
      eventId: eventId,
      patientId: patientId,
      heartRate: heartRate,
      spo2: spo2,
      respiratoryRate: respiratoryRate,
      temperature: temperature,
      signalQuality: signalQuality,
      decision: decision,
      reason: reason,
      createdAt: createdAt.toUtc(),
    );

    await TriageEvent.db.insertRow(session, event);

    return event;
  }
}
