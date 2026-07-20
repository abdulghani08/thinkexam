import 'package:flutter/foundation.dart';

enum AuditEventType {
  examStarted,
  examSubmitted,
  questionAnswered,
  violationRecorded,
  warningIssued,
  autoSubmitTriggered,
  sessionCreated,
  sessionUpdated,
}

class AuditLogEntry {
  final String id;
  final String sessionId;
  final String studentId;
  final AuditEventType eventType;
  final Map<String, dynamic>? metadata;
  final DateTime timestamp;

  AuditLogEntry({
    required this.id,
    required this.sessionId,
    required this.studentId,
    required this.eventType,
    this.metadata,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionId,
      'studentId': studentId,
      'eventType': eventType.name,
      'metadata': metadata,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory AuditLogEntry.fromMap(Map<String, dynamic> map) {
    return AuditLogEntry(
      id: map['id'] as String,
      sessionId: map['sessionId'] as String,
      studentId: map['studentId'] as String,
      eventType: AuditEventType.values.firstWhere(
        (e) => e.name == map['eventType'],
        orElse: () => AuditEventType.sessionCreated,
      ),
      metadata: map['metadata'] as Map<String, dynamic>?,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }
}

class AuditLog extends ChangeNotifier {
  final List<AuditLogEntry> _logs = [];

  List<AuditLogEntry> get logs => List.unmodifiable(_logs);

  void log({
    required String sessionId,
    required String studentId,
    required AuditEventType eventType,
    Map<String, dynamic>? metadata,
  }) {
    final entry = AuditLogEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sessionId: sessionId,
      studentId: studentId,
      eventType: eventType,
      metadata: metadata,
      timestamp: DateTime.now(),
    );
    _logs.add(entry);
    notifyListeners();
  }

  List<AuditLogEntry> getLogsBySession(String sessionId) {
    return _logs.where((log) => log.sessionId == sessionId).toList();
  }

  List<AuditLogEntry> getLogsByStudent(String studentId) {
    return _logs.where((log) => log.studentId == studentId).toList();
  }

  List<AuditLogEntry> getLogsByEventType(AuditEventType eventType) {
    return _logs.where((log) => log.eventType == eventType).toList();
  }

  void clear() {
    _logs.clear();
    notifyListeners();
  }
}
