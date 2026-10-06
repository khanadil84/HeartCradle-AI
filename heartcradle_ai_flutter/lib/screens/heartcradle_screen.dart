import 'package:flutter/material.dart';

import '../client.dart';

class HeartCradleScreen extends StatefulWidget {
  const HeartCradleScreen({super.key});

  @override
  State<HeartCradleScreen> createState() => _HeartCradleScreenState();
}

class _HeartCradleScreenState extends State<HeartCradleScreen> {
  bool _analyzing = false;
  String? _decision;
  String? _reason;

  // Simulated telemetry for the hackathon demo.
  final String _patientId = 'SIM-PATIENT-001';
  final int _heartRate = 142;
  final int _spo2 = 84;
  final int _respiratoryRate = 31;
  final double _temperature = 39.2;
  final String _signalQuality = 'good';

  Future<void> _analyzeTelemetry() async {
    setState(() {
      _analyzing = true;
      _decision = null;
      _reason = null;
    });

    try {
      final result = await client.triage.analyzeTelemetry(
        patientId: _patientId,
        heartRate: _heartRate,
        spo2: _spo2,
        respiratoryRate: _respiratoryRate,
        temperature: _temperature,
        signalQuality: _signalQuality,
      );

      if (!mounted) return;

      setState(() {
        _decision = result.decision;
        _reason = result.reason;
        _analyzing = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _decision = 'CONNECTION_ERROR';
        _reason = 'Unable to reach the HeartCradle Serverpod backend.';
        _analyzing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBlocked = _decision == 'SAFETY_BLOCKED';

    return Scaffold(
      backgroundColor: const Color(0xFF07111F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1728),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.favorite_rounded, color: Color(0xFFFF5C7A)),
            SizedBox(width: 10),
            Text(
              'HEARTCRADLE AI',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF123B2A),
              border: Border.all(color: const Color(0xFF2FD67A)),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 8,
                  color: Color(0xFF2FD67A),
                ),
                SizedBox(width: 6),
                Text(
                  'SERVERPOD ONLINE',
                  style: TextStyle(
                    color: Color(0xFF8EF0B5),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Emergency Operations Console',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Offline-first simulated telemetry • Never-Guess Safety Gate',
                  style: TextStyle(
                    color: Color(0xFF8FA4BD),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 24),

                _sectionTitle(
                  'SIMULATED PATIENT TELEMETRY',
                  Icons.monitor_heart_outlined,
                ),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _metricCard(
                      'HEART RATE',
                      '$_heartRate',
                      'BPM',
                      Icons.favorite,
                    ),
                    _metricCard(
                      'SpO2',
                      '$_spo2',
                      '%',
                      Icons.air,
                    ),
                    _metricCard(
                      'RESPIRATION',
                      '$_respiratoryRate',
                      '/min',
                      Icons.waves,
                    ),
                    _metricCard(
                      'TEMPERATURE',
                      _temperature.toStringAsFixed(1),
                      '°C',
                      Icons.thermostat,
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C1B2E),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFF1D344E),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.sensors,
                        color: Color(0xFF55B7FF),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'SIGNAL QUALITY',
                        style: TextStyle(
                          color: Color(0xFF8FA4BD),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _signalQuality.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF5FE29A),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                _sectionTitle(
                  'TRIAGE COMMANDER',
                  Icons.account_tree_outlined,
                ),
                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C1B2E),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFF1D344E),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.shield_outlined,
                        size: 44,
                        color: Color(0xFF55B7FF),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'NEVER-GUESS SAFETY GATE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Telemetry is evaluated by the Serverpod backend '
                        'before an automated workflow can continue.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF8FA4BD),
                        ),
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed:
                              _analyzing ? null : _analyzeTelemetry,
                          icon: _analyzing
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.bolt),
                          label: Text(
                            _analyzing
                                ? 'ANALYZING...'
                                : 'ANALYZE TELEMETRY',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1769E0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (_decision != null) ...[
                  const SizedBox(height: 24),
                  _resultCard(
                    decision: _decision!,
                    reason: _reason ?? '',
                    blocked: isBlocked,
                  ),
                ],

                const SizedBox(height: 24),

                const Text(
                  'SIMULATION MODE • NOT FOR REAL-WORLD CLINICAL USE',
                  style: TextStyle(
                    color: Color(0xFF5D7188),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF55B7FF), size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFB8C9DC),
            fontWeight: FontWeight.w800,
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _metricCard(
    String title,
    String value,
    String unit,
    IconData icon,
  ) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1B2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1D344E)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF55B7FF), size: 20),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF7188A1),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  unit,
                  style: const TextStyle(
                    color: Color(0xFF7188A1),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _resultCard({
    required String decision,
    required String reason,
    required bool blocked,
  }) {
    final isError = decision == 'CONNECTION_ERROR';

    final icon = blocked
        ? Icons.gpp_maybe_outlined
        : isError
            ? Icons.cloud_off_outlined
            : Icons.verified_outlined;

    final title = blocked
        ? 'SAFETY BLOCKED'
        : isError
            ? 'BACKEND UNAVAILABLE'
            : 'SAFE TO PROCEED';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: blocked
            ? const Color(0xFF321522)
            : const Color(0xFF102A20),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: blocked
              ? const Color(0xFFFF5277)
              : const Color(0xFF36D98A),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: blocked
                    ? const Color(0xFFFF5277)
                    : const Color(0xFF36D98A),
                size: 30,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: blocked
                      ? const Color(0xFFFF7895)
                      : const Color(0xFF63E6A4),
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            reason,
            style: const TextStyle(
              color: Color(0xFFD3DFEC),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Decision returned by Serverpod TriageEndpoint • '
            'Event persisted to PostgreSQL',
            style: const TextStyle(
              color: Color(0xFF7890A8),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
