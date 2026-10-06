enum AutonomousState {
  idle,
  ingesting,
  analyzing,
  safetyEvaluating,
  safetyBlocked,
  safetyHalted,
  executing,
  persisting,
  synchronizing,
  verifying,
  recovering,
  completed,
  failed,
}

class AutonomousTransition {
  final AutonomousState from;
  final AutonomousState to;
  final String event;
  final DateTime timestamp;

  AutonomousTransition({
    required this.from,
    required this.to,
    required this.event,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now().toUtc();
}

class AutonomousStateMachine {
  AutonomousState _state = AutonomousState.idle;

  final List<AutonomousTransition> _history = [];

  AutonomousState get state => _state;

  List<AutonomousTransition> get history =>
      List.unmodifiable(_history);

  bool transition(
    AutonomousState next,
    String event,
  ) {
    if (!_isAllowed(_state, next)) {
      return false;
    }

    final transition = AutonomousTransition(
      from: _state,
      to: next,
      event: event,
    );

    _history.add(transition);
    _state = next;

    return true;
  }

  bool _isAllowed(
    AutonomousState from,
    AutonomousState to,
  ) {
    switch (from) {
      case AutonomousState.idle:
        return to == AutonomousState.ingesting;

      case AutonomousState.ingesting:
        return to == AutonomousState.analyzing ||
            to == AutonomousState.failed;

      case AutonomousState.analyzing:
        return to == AutonomousState.safetyEvaluating ||
            to == AutonomousState.failed;

      case AutonomousState.safetyEvaluating:
        return to == AutonomousState.safetyBlocked ||
            to == AutonomousState.executing ||
            to == AutonomousState.failed;

      case AutonomousState.safetyBlocked:
        return to == AutonomousState.safetyHalted ||
            to == AutonomousState.recovering;

      case AutonomousState.safetyHalted:
        return to == AutonomousState.persisting;

      case AutonomousState.executing:
        return to == AutonomousState.persisting ||
            to == AutonomousState.failed;

      case AutonomousState.persisting:
        return to == AutonomousState.synchronizing ||
            to == AutonomousState.completed;

      case AutonomousState.synchronizing:
        return to == AutonomousState.verifying ||
            to == AutonomousState.recovering;

      case AutonomousState.verifying:
        return to == AutonomousState.completed ||
            to == AutonomousState.recovering;

      case AutonomousState.recovering:
        return to == AutonomousState.synchronizing ||
            to == AutonomousState.persisting ||
            to == AutonomousState.failed;

      case AutonomousState.completed:
        return false;

      case AutonomousState.failed:
        return to == AutonomousState.recovering;
    }
  }

  void reset() {
    _state = AutonomousState.idle;
    _history.clear();
  }
}
