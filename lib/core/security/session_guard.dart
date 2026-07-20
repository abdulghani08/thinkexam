import 'package:flutter/foundation.dart';
import 'lifecycle_monitor.dart';

enum GuardViolationType {
  appMinimized,
  appSwitched,
  screenOff,
  unknown,
}

class GuardViolation {
  final GuardViolationType type;
  final DateTime timestamp;
  final String? description;

  GuardViolation({
    required this.type,
    required this.timestamp,
    this.description,
  });
}

class SessionGuard extends ChangeNotifier {
  final LifecycleMonitor _lifecycleMonitor;
  final int maxViolations;
  final int maxBackgroundTimeSeconds;

  final List<GuardViolation> _violations = [];
  bool _isActive = false;
  bool _isLocked = false;

  SessionGuard({
    required LifecycleMonitor lifecycleMonitor,
    this.maxViolations = 3,
    this.maxBackgroundTimeSeconds = 30,
  }) : _lifecycleMonitor = lifecycleMonitor {
    _lifecycleMonitor.addListener(_onLifecycleChanged);
  }

  List<GuardViolation> get violations => List.unmodifiable(_violations);
  int get violationCount => _violations.length;
  bool get isActive => _isActive;
  bool get isLocked => _isLocked;
  bool get hasExceededViolations => _violations.length >= maxViolations;

  void activate() {
    _isActive = true;
    _isLocked = false;
    _violations.clear();
    notifyListeners();
  }

  void deactivate() {
    _isActive = false;
    notifyListeners();
  }

  void lock() {
    _isLocked = true;
    notifyListeners();
  }

  void unlock() {
    _isLocked = false;
    notifyListeners();
  }

  void _onLifecycleChanged() {
    if (!_isActive || _isLocked) return;

    final state = _lifecycleMonitor.currentState;
    if (state == LifecycleState.paused || state == LifecycleState.inactive) {
      _recordViolation(GuardViolationType.appMinimized);
    }
  }

  void _recordViolation(GuardViolationType type, {String? description}) {
    final violation = GuardViolation(
      type: type,
      timestamp: DateTime.now(),
      description: description,
    );
    _violations.add(violation);
    notifyListeners();

    if (hasExceededViolations) {
      lock();
    }
  }

  void recordScreenOff() {
    if (!_isActive || _isLocked) return;
    _recordViolation(GuardViolationType.screenOff);
  }

  void recordAppSwitch() {
    if (!_isActive || _isLocked) return;
    _recordViolation(GuardViolationType.appSwitched);
  }

  Duration getTimeInBackground() {
    return _lifecycleMonitor.getTimeInBackground() ?? Duration.zero;
  }

  bool hasExceededBackgroundTime() {
    final timeInBackground = getTimeInBackground();
    return timeInBackground.inSeconds >= maxBackgroundTimeSeconds;
  }

  void clearViolations() {
    _violations.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _lifecycleMonitor.removeListener(_onLifecycleChanged);
    super.dispose();
  }
}
