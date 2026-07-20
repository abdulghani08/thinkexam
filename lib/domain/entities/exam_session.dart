import 'base_entity.dart';

enum ExamSessionStatus { ready, running, completed, abandoned }

class ExamSession extends BaseEntity {
  final String id;
  final String examId;
  final String studentId;
  final ExamSessionStatus status;
  final DateTime? startTime;
  final DateTime? endTime;
  final int remainingTime;
  final int violationCount;
  final String? deviceId;

  const ExamSession({
    required this.id,
    required this.examId,
    required this.studentId,
    this.status = ExamSessionStatus.ready,
    this.startTime,
    this.endTime,
    required this.remainingTime,
    this.violationCount = 0,
    this.deviceId,
  });

  @override
  List<Object?> get props => [
        id,
        examId,
        studentId,
        status,
        startTime,
        endTime,
        remainingTime,
        violationCount,
        deviceId,
      ];

  ExamSession copyWith({
    String? id,
    String? examId,
    String? studentId,
    ExamSessionStatus? status,
    DateTime? startTime,
    DateTime? endTime,
    int? remainingTime,
    int? violationCount,
    String? deviceId,
  }) =>
      ExamSession(
        id: id ?? this.id,
        examId: examId ?? this.examId,
        studentId: studentId ?? this.studentId,
        status: status ?? this.status,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        remainingTime: remainingTime ?? this.remainingTime,
        violationCount: violationCount ?? this.violationCount,
        deviceId: deviceId ?? this.deviceId,
      );
}
