import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class AuditEndpoint extends Endpoint {
  Future<AuditEvent> recordEvent(
    Session session, {
    required String eventId,
    required String missionId,
    required String event,
    required String fromState,
    required String toState,
    required DateTime createdAt,
  }) async {
    final existing = await AuditEvent.db.findFirstRow(
      session,
      where: (a) => a.eventId.equals(eventId),
    );

    if (existing != null) {
      return existing;
    }

    final auditEvent = AuditEvent(
      eventId: eventId,
      missionId: missionId,
      event: event,
      fromState: fromState,
      toState: toState,
      createdAt: createdAt.toUtc(),
    );

    await AuditEvent.db.insertRow(session, auditEvent);

    await session.messages.postMessage(
      'mission_audit_$missionId',
      auditEvent,
    );

    return auditEvent;
  }

  Stream<AuditEvent> watchMission(
    Session session, {
    required String missionId,
  }) async* {
    yield* session.messages.createStream<AuditEvent>(
      'mission_audit_$missionId',
    );
  }
}
