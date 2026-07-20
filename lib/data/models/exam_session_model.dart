import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/exam_session.dart';

part 'exam_session_model.freezed.dart';
part 'exam_session_model.g.dart';

@freezed
class ExamSessionModel with _$ExamSessionModel {
  const ExamSessionModel._();

  const factory ExamSessionModel({
    required String id,
    required String examId,
    required String studentId,
    required String status,
    DateTime? startTime,
    DateTime? endTime,
    required int remainingTime,
    @Default(0) int violationCount,
    String? deviceId,
  }) = _ExamSessionModel;

  factory ExamSessionModel.fromFirestore(
    Map<String, dynamic> data,
    String id,
  ) {
    return ExamSessionModel(
      id: id,
      examId: data['examId'] as String? ?? '',
      studentId: data['studentId'] as String? ?? '',
      status: data['status'] as String? ?? 'ready',
      startTime: data['startTime'] != null
          ? (data['startTime'] as dynamic).toDate()
          : null,
      endTime: data['endTime'] != null
          ? (data['endTime'] as dynamic).toDate()
          : null,
      remainingTime: data['remainingTime'] as int? ?? 0,
      violationCount: data['violationCount'] as int? ?? 0,
      deviceId: data['deviceId'] as String?,
    );
  }

  factory ExamSessionModel.fromJson(Map<String, dynamic> json) =>
      _$ExamSessionModelFromJson(json);

  ExamSession toEntity() {
    return ExamSession(
      id: id,
      examId: examId,
      studentId: studentId,
      status: _parseStatus(status),
      startTime: startTime,
      endTime: endTime,
      remainingTime: remainingTime,
      violationCount: violationCount,
      deviceId: deviceId,
    );
  }

  ExamSessionStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'ready':
        return ExamSessionStatus.ready;
      case 'running':
        return ExamSessionStatus.running;
      case 'completed':
        return ExamSessionStatus.completed;
      case 'abandoned':
        return ExamSessionStatus.abandoned;
      default:
        return ExamSessionStatus.ready;
    }
  }

  Map<String, dynamic> toCreateMap() {
    return {
      'examId': examId,
      'studentId': studentId,
      'status': status,
      'remainingTime': remainingTime,
      'violationCount': violationCount,
      'deviceId': deviceId,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      if (status.isNotEmpty) 'status': status,
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      'remainingTime': remainingTime,
      'violationCount': violationCount,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
