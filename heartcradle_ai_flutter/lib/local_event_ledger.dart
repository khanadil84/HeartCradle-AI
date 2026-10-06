import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalEventLedger {
  static const _key = 'heartcradle_event_ledger';

  Future<String> append({
    required String patientId,
    required String eventType,
    required int heartRate,
    required int spo2,
    required int respiratoryRate,
    required double temperature,
    required String signalQuality,
    required String decision,
    required String reason,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final existing = prefs.getStringList(_key) ?? [];

    final id = DateTime.now().microsecondsSinceEpoch.toString();

    final event = {
      'id': id,
      'patientId': patientId,
      'eventType': eventType,
      'heartRate': heartRate,
      'spo2': spo2,
      'respiratoryRate': respiratoryRate,
      'temperature': temperature,
      'signalQuality': signalQuality,
      'decision': decision,
      'reason': reason,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
      'syncState': 'LOCAL_ONLY',
    };

    existing.add(jsonEncode(event));

    await prefs.setStringList(_key, existing);

    return id;
  }

  Future<List<Map<String, dynamic>>> readAll() async {
    final prefs = await SharedPreferences.getInstance();

    final existing = prefs.getStringList(_key) ?? [];

    return existing
        .map((value) => jsonDecode(value) as Map<String, dynamic>)
        .toList()
        .reversed
        .toList();
  }

  Future<int> count() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_key) ?? []).length;
  }

  Future<int> pendingCount() async {
    final events = await readAll();

    return events
        .where((event) => event['syncState'] == 'LOCAL_ONLY')
        .length;
  }

  Future<List<Map<String, dynamic>>> pendingEvents() async {
    final events = await readAll();

    return events
        .where((event) => event['syncState'] == 'LOCAL_ONLY')
        .toList();
  }

  Future<void> markSynced(String id) async {
    final prefs = await SharedPreferences.getInstance();

    final existing = prefs.getStringList(_key) ?? [];
    final updated = <String>[];

    for (final value in existing) {
      final event = jsonDecode(value) as Map<String, dynamic>;

      if (event['id'] == id) {
        event['syncState'] = 'SYNCED';
        event['syncedAt'] = DateTime.now().toUtc().toIso8601String();
      }

      updated.add(jsonEncode(event));
    }

    await prefs.setStringList(_key, updated);
  }
}
