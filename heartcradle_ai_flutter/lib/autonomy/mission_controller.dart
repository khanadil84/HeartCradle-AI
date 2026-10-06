import '../client.dart';
import 'autonomous_mission.dart';
import 'autonomous_state_machine.dart';

class AutonomousMissionController {
  final AutonomousStateMachine stateMachine;

  final String missionId;
  final String patientId;
  final DateTime startedAt;

  static const int totalSteps = 9;

  AutonomousMissionController({
    required this.patientId,
    AutonomousStateMachine? stateMachine,
  })  : stateMachine = stateMachine ?? AutonomousStateMachine(),
        missionId = 'HC-${DateTime.now().microsecondsSinceEpoch}',
        startedAt = DateTime.now().toUtc();

  AutonomousState get state => stateMachine.state;

  List<AutonomousTransition> get transitions => stateMachine.history;

  Future<bool> advance(
    AutonomousState next,
    String event,
  ) async {
    final transitioned = stateMachine.transition(next, event);

    if (!transitioned) {
      return false;
    }

    final transition = stateMachine.history.last;

    try {
      await client.audit.recordEvent(
        eventId:
            '$missionId-${transition.timestamp.microsecondsSinceEpoch}',
        missionId: missionId,
        event: transition.event,
        fromState: transition.from.name.toUpperCase(),
        toState: transition.to.name.toUpperCase(),
        createdAt: transition.timestamp,
      );
    } catch (_) {
      // The local state transition remains authoritative.
      // Audit persistence can recover later without blocking the mission.
    }

    return true;
  }

  MissionStatus get status {
    switch (stateMachine.state) {
      case AutonomousState.completed:
        return MissionStatus.completed;

      case AutonomousState.failed:
        return MissionStatus.failed;

      case AutonomousState.safetyBlocked:
      case AutonomousState.safetyHalted:
        return MissionStatus.blocked;

      case AutonomousState.recovering:
        return MissionStatus.recovering;

      case AutonomousState.idle:
        return MissionStatus.idle;

      default:
        return MissionStatus.running;
    }
  }

  AutonomousMission snapshot() {
    return AutonomousMission(
      id: missionId,
      patientId: patientId,
      startedAt: startedAt,
      status: status,
      completedSteps: status == MissionStatus.completed
          ? totalSteps
          : (transitions.length > totalSteps ? totalSteps : transitions.length),
      totalSteps: totalSteps,
      currentStep: state.name.toUpperCase(),
    );
  }
}

