import 'dart:async';

import 'package:heartcradle_ai_client/heartcradle_ai_client.dart';

import '../client.dart';

class MissionAuditStreamService {
  Stream<AuditEvent> watch(String missionId) {
    return client.audit.watchMission(
      missionId: missionId,
    );
  }

  StreamSubscription<AuditEvent> listen(
    String missionId, {
    required void Function(AuditEvent event) onEvent,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    return watch(missionId).listen(
      onEvent,
      onError: onError,
    );
  }
}
