enum ChaosScenario {
  normal,
  unreliableSignal,
  lowSpo2,
  conflictingTelemetry,
  missingSensor,
  serverpodUnavailable,
}

class ChaosTelemetry {
  final ChaosScenario scenario;
  final int heartRate;
  final int spo2;
  final int respiratoryRate;
  final double temperature;
  final String signalQuality;
  final String description;

  const ChaosTelemetry({
    required this.scenario,
    required this.heartRate,
    required this.spo2,
    required this.respiratoryRate,
    required this.temperature,
    required this.signalQuality,
    required this.description,
  });
}

class ChaosEngine {
  const ChaosEngine();

  ChaosTelemetry generate(ChaosScenario scenario) {
    switch (scenario) {
      case ChaosScenario.normal:
        return const ChaosTelemetry(
          scenario: ChaosScenario.normal,
          heartRate: 82,
          spo2: 98,
          respiratoryRate: 16,
          temperature: 36.8,
          signalQuality: 'good',
          description: 'Nominal simulated telemetry.',
        );

      case ChaosScenario.unreliableSignal:
        return const ChaosTelemetry(
          scenario: ChaosScenario.unreliableSignal,
          heartRate: 142,
          spo2: 84,
          respiratoryRate: 31,
          temperature: 39.2,
          signalQuality: 'poor',
          description:
              'Telemetry contains abnormal values with unreliable signal quality.',
        );

      case ChaosScenario.lowSpo2:
        return const ChaosTelemetry(
          scenario: ChaosScenario.lowSpo2,
          heartRate: 118,
          spo2: 84,
          respiratoryRate: 24,
          temperature: 37.1,
          signalQuality: 'good',
          description: 'Simulated low oxygen saturation signal.',
        );

      case ChaosScenario.conflictingTelemetry:
        return const ChaosTelemetry(
          scenario: ChaosScenario.conflictingTelemetry,
          heartRate: 142,
          spo2: 98,
          respiratoryRate: 8,
          temperature: 36.8,
          signalQuality: 'conflicting',
          description:
              'Simulated telemetry with internally unreliable sensor quality.',
        );

      case ChaosScenario.serverpodUnavailable:
        return const ChaosTelemetry(
          scenario: ChaosScenario.serverpodUnavailable,
          heartRate: 82,
          spo2: 98,
          respiratoryRate: 16,
          temperature: 36.8,
          signalQuality: 'good',
          description: 'Nominal simulated telemetry with a controlled Serverpod outage.',
        );

      case ChaosScenario.missingSensor:
        return const ChaosTelemetry(
          scenario: ChaosScenario.missingSensor,
          heartRate: 0,
          spo2: 0,
          respiratoryRate: 0,
          temperature: 0,
          signalQuality: 'missing',
          description: 'Simulated missing-sensor condition.',
        );
    }
  }
}




