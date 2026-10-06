import '../services/offline_sync_service.dart';

class RecoveryResult {
  final bool recovered;
  final int attempts;
  final SyncResult sync;
  final String message;

  const RecoveryResult({
    required this.recovered,
    required this.attempts,
    required this.sync,
    required this.message,
  });
}

class RecoveryEngine {
  final OfflineSyncService syncService;

  const RecoveryEngine({
    required this.syncService,
  });

  Future<RecoveryResult> recover({
    int maxAttempts = 3,
    Duration retryDelay = const Duration(seconds: 2),
  }) async {
    SyncResult latest = const SyncResult(
      status: SyncStatus.failed,
      syncedCount: 0,
      remainingCount: 0,
      message: 'Recovery has not started.',
    );

    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      latest = await syncService.syncPendingEvents();

      if (latest.status == SyncStatus.synced) {
        return RecoveryResult(
          recovered: true,
          attempts: attempt,
          sync: latest,
          message: 'Synchronization recovered on attempt $attempt.',
        );
      }

      if (attempt < maxAttempts) {
        await Future<void>.delayed(retryDelay);
      }
    }

    return RecoveryResult(
      recovered: false,
      attempts: maxAttempts,
      sync: latest,
      message:
          'Recovery exhausted after $maxAttempts attempts. '
          'Pending events remain safely stored locally.',
    );
  }
}
