import 'package:flutter/foundation.dart';
import 'session_guard.dart';
import 'violation_counter.dart';
import 'audit_log.dart';

class AutoSubmitHandler extends ChangeNotifier {
  final SessionGuard _sessionGuard;
  final ViolationCounter _violationCounter;
  final AuditLog _auditLog;
  String _sessionId;
  String _studentId;

  bool _autoSubmitTriggered = false;
  String? _autoSubmitReason;

  AutoSubmitHandler({
    required SessionGuard sessionGuard,
    required ViolationCounter violationCounter,
    required AuditLog auditLog,
    required String sessionId,
    required String studentId,
  })  : _sessionGuard = sessionGuard,
        _violationCounter = violationCounter,
        _auditLog = auditLog,
        _sessionId = sessionId,
        _studentId = studentId {
    _sessionGuard.addListener(_onGuardChanged);
    _violationCounter.addListener(_onViolationChanged);
  }

  bool get autoSubmitTriggered => _autoSubmitTriggered;
  String? get autoSubmitReason => _autoSubmitReason;

  void setSessionId(String sessionId) {
    _sessionId = sessionId;
  }

  void setStudentId(String studentId) {
    _studentId = studentId;
  }

  void _onGuardChanged() {
    if (_sessionGuard.hasExceededViolations) {
      _triggerAutoSubmit('Maximum violations exceeded');
    }
  }

  void _onViolationChanged() {
    if (_violationCounter.hasExceeded) {
      _triggerAutoSubmit('Maximum violations exceeded');
    }
  }

  void _triggerAutoSubmit(String reason) {
    if (_autoSubmitTriggered) return;

    _autoSubmitTriggered = true;
    _autoSubmitReason = reason;
    
    _auditLog.log(
      sessionId: _sessionId,
      studentId: _studentId,
      eventType: AuditEventType.autoSubmitTriggered,
      metadata: {'reason': reason},
    );

    notifyListeners();
  }

  void reset() {
    _autoSubmitTriggered = false;
    _autoSubmitReason = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _sessionGuard.removeListener(_onGuardChanged);
    _violationCounter.removeListener(_onViolationChanged);
    super.dispose();
  }
}
