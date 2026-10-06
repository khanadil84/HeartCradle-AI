import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class MissionEndpoint extends Endpoint {
  Future<Mission> startMission(
    Session session, {
    required String missionId,
    required String patientId,
    required int totalSteps,
  }) async {
    final existing = await Mission.db.findFirstRow(
      session,
      where: (m) => m.missionId.equals(missionId),
    );

    if (existing != null) {
      return existing;
    }

    final mission = Mission(
      missionId: missionId,
      patientId: patientId,
      status: 'RUNNING',
      completedSteps: 0,
      totalSteps: totalSteps,
      currentStep: 'IDLE',
      startedAt: DateTime.now().toUtc(),
      completedAt: null,
      lastEvent: 'MISSION_STARTED',
    );

    await Mission.db.insertRow(session, mission);

    return mission;
  }

  Future<Mission> updateMission(
    Session session, {
    required String missionId,
    required String status,
    required int completedSteps,
    required String currentStep,
    required String lastEvent,
    DateTime? completedAt,
  }) async {
    final mission = await Mission.db.findFirstRow(
      session,
      where: (m) => m.missionId.equals(missionId),
    );

    if (mission == null) {
      throw Exception('Mission not found: $missionId');
    }

    mission.status = status;
    mission.completedSteps = completedSteps;
    mission.currentStep = currentStep;
    mission.lastEvent = lastEvent;
    mission.completedAt = completedAt?.toUtc();

    await Mission.db.updateRow(session, mission);

    return mission;
  }

  Future<List<Mission>> getRecentMissions(
    Session session, {
    int limit = 20,
  }) async {
    return Mission.db.find(
      session,
      orderBy: (m) => m.startedAt.desc(),
      limit: limit.clamp(1, 50),
    );
  }

  Future<Mission?> getMission(
    Session session, {
    required String missionId,
  }) async {
    return Mission.db.findFirstRow(
      session,
      where: (m) => m.missionId.equals(missionId),
    );
  }

  Future<List<AuditEvent>> getMissionHistory(
    Session session, {
    required String missionId,
  }) async {
    return AuditEvent.db.find(
      session,
      where: (event) => event.missionId.equals(missionId),
      orderBy: (event) => event.createdAt,
    );
  }
}
