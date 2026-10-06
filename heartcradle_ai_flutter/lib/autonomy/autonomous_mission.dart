enum MissionStatus {
  idle,
  running,
  blocked,
  recovering,
  completed,
  failed,
}

class AutonomousMission {
  final String id;
  final String patientId;
  final DateTime startedAt;
  final MissionStatus status;
  final int completedSteps;
  final int totalSteps;
  final String currentStep;

  const AutonomousMission({
    required this.id,
    required this.patientId,
    required this.startedAt,
    required this.status,
    required this.completedSteps,
    required this.totalSteps,
    required this.currentStep,
  });

  double get progress =>
      totalSteps == 0 ? 0 : completedSteps / totalSteps;
}
