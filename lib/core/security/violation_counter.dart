import 'package:flutter/foundation.dart';
import 'session_guard.dart';

class ViolationCounter extends ChangeNotifier {
  final SessionGuard _sessionGuard;
  final int maxViolations;
  final List<int> _warningThresholds;

  ViolationCounter({
    required SessionGuard sessionGuard,
    this.maxViolations = 3,
    List<int>? warningThresholds,
  })  : _sessionGuard = sessionGuard,
        _warningThresholds = warningThresholds ?? [1, 2];

  int get currentCount => _sessionGuard.violationCount;
  int get maxCount => maxViolations;
  bool get hasExceeded => currentCount >= maxViolations;
  bool get shouldWarn => _warningThresholds.contains(currentCount);
  int get remainingViolations => maxViolations - currentCount;

  String getWarningMessage() {
    if (!shouldWarn) return '';
    
    final remaining = maxViolations - currentCount;
    if (remaining == 1) {
      return 'Warning: This is your last warning. One more violation will auto-submit your exam.';
    }
    return 'Warning: You have $remaining violations remaining before auto-submit.';
  }

  void reset() {
    _sessionGuard.clearViolations();
    notifyListeners();
  }
}
