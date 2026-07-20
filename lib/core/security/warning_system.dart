import 'package:flutter/foundation.dart';
import 'violation_counter.dart';

enum WarningLevel { info, warning, critical }

class Warning {
  final String id;
  final String message;
  final WarningLevel level;
  final DateTime timestamp;
  bool isAcknowledged;

  Warning({
    required this.id,
    required this.message,
    required this.level,
    required this.timestamp,
    this.isAcknowledged = false,
  });

  void acknowledge() {
    isAcknowledged = true;
  }
}

class WarningSystem extends ChangeNotifier {
  final ViolationCounter _violationCounter;
  final List<Warning> _warnings = [];

  WarningSystem({required ViolationCounter violationCounter})
      : _violationCounter = violationCounter {
    _violationCounter.addListener(_onViolationChanged);
  }

  List<Warning> get warnings => List.unmodifiable(_warnings);
  List<Warning> get unacknowledgedWarnings =>
      _warnings.where((w) => !w.isAcknowledged).toList();
  bool get hasUnacknowledgedWarnings => unacknowledgedWarnings.isNotEmpty;

  void _onViolationChanged() {
    if (_violationCounter.shouldWarn) {
      _addWarning(
        message: _violationCounter.getWarningMessage(),
        level: _violationCounter.remainingViolations == 1
            ? WarningLevel.critical
            : WarningLevel.warning,
      );
    }

    if (_violationCounter.hasExceeded) {
      _addWarning(
        message: 'Maximum violations exceeded. Exam will be auto-submitted.',
        level: WarningLevel.critical,
      );
    }
  }

  void _addWarning({required String message, required WarningLevel level}) {
    final warning = Warning(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: message,
      level: level,
      timestamp: DateTime.now(),
    );
    _warnings.add(warning);
    notifyListeners();
  }

  void acknowledgeWarning(String warningId) {
    final warning = _warnings.firstWhere((w) => w.id == warningId);
    warning.acknowledge();
    notifyListeners();
  }

  void acknowledgeAll() {
    for (var warning in _warnings) {
      warning.acknowledge();
    }
    notifyListeners();
  }

  void clear() {
    _warnings.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _violationCounter.removeListener(_onViolationChanged);
    super.dispose();
  }
}
