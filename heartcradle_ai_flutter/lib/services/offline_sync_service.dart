import '../client.dart';
import '../local_event_ledger.dart';

enum SyncStatus {
  synced,
  pending,
  failed,
}

class SyncResult {
  final SyncStatus status;
  final int syncedCount;
  final int remainingCount;
  final String message;

  const SyncResult({
    required this.status,
    required this.syncedCount,
    required this.remainingCount,
    required this.message,
  });
}

class OfflineSyncService {
  final LocalEventLedger ledger;

  OfflineSyncService({
    LocalEventLedger? ledger,
  }) : ledger = ledger ?? LocalEventLedger();

  Future<SyncResult> syncPendingEvents() async {
    final pending = await ledger.pendingEvents();

    if (pending.isEmpty) {
      return const SyncResult(
        status: SyncStatus.synced,
        syncedCount: 0,
        remainingCount: 0,
        message: 'No pending events.',
      );
    }

    var syncedCount = 0;

    for (final event in pending) {
      try {
        await client.sync.syncLocalEvent(
          eventId: event['id'] as String,
          patientId: event['patientId'] as String,
          heartRate: event['heartRate'] as int,
          spo2: event['spo2'] as int,
          respiratoryRate: event['respiratoryRate'] as int,
          temperature: (event['temperature'] as num).toDouble(),
          signalQuality: event['signalQuality'] as String,
          decision: event['decision'] as String,
          reason: event['reason'] as String,
          createdAt: DateTime.parse(event['createdAt'] as String),
        );

        await ledger.markSynced(event['id'] as String);
        syncedCount++;
      } catch (_) {
        break;
      }
    }

    final remaining = await ledger.pendingCount();

    if (remaining == 0) {
      return SyncResult(
        status: SyncStatus.synced,
        syncedCount: syncedCount,
        remainingCount: 0,
        message: 'All pending events synchronized.',
      );
    }

    if (syncedCount > 0) {
      return SyncResult(
        status: SyncStatus.pending,
        syncedCount: syncedCount,
        remainingCount: remaining,
        message: '$remaining event(s) remain pending.',
      );
    }

    return SyncResult(
      status: SyncStatus.failed,
      syncedCount: 0,
      remainingCount: remaining,
      message: 'Serverpod unavailable. Events remain LOCAL_ONLY.',
    );
  }
}
