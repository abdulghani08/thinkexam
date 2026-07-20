import 'package:flutter/foundation.dart';
import 'lifecycle_monitor.dart';
import 'session_guard.dart';
import 'audit_log.dart';

class RecoveryValidator extends ChangeNotifier {
  final LifecycleMonitor _lifecycleMonitor;
  final SessionGuard _sessionGuard;
  final AuditLog _auditLog;
  String _sessionId;
  String _studentId;

  RecoveryValidator({
    required LifecycleMonitor lifecycleMonitor,
    required SessionGuard sessionGuard,
    required AuditLog auditLog,
    required String sessionId,
    required String studentId,
  })  : _lifecycleMonitor = lifecycleMonitor,
        _sessionGuard = sessionGuard,
        _auditLog = auditLog,
        _sessionId = sessionId,
        _studentId = studentId;

  void setSessionId(String sessionId) {
    _sessionId = sessionId;
  }

  void setStudentId(String studentId) {
    _studentId = studentId;
  }

  bool validateSessionRecovery() {
    if (_sessionGuard.isLocked) {
      _auditLog.log(
        sessionId: _sessionId,
        studentId: _studentId,
        eventType: AuditEventType.violationRecorded,
        metadata: {'reason': 'Session locked due to violations'},
      );
      return false;
    }

    final timeInBackground = _lifecycleMonitor.getTimeInBackground();
    if (timeInBackground != null && timeInBackground.inSeconds > 60) {
      _auditLog.log(
        sessionId: _sessionId,
        studentId: _studentId,
        eventType: AuditEventType.violationRecorded,
        metadata: {
          'reason': 'Exceeded background time',
          'duration': timeInBackground.inSeconds,
        },
      );
      return false;
    }

    return true;
  }

  bool canResumeExam() {
    return validateSessionRecovery() && !_sessionGuard.hasExceededViolations;
  }

  void logRecoveryAttempt() {
    _auditLog.log(
      sessionId: _sessionId,
      studentId: _studentId,
      eventType: AuditEventType.sessionUpdated,
      metadata: {'action': 'recovery_attempt'},
    );
  }
}
