import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/exam_answer.dart';

part 'exam_answer_model.freezed.dart';
part 'exam_answer_model.g.dart';

@freezed
class ExamAnswerModel with _$ExamAnswerModel {
  const ExamAnswerModel._();

  const factory ExamAnswerModel({
    required String id,
    required String sessionId,
    required String questionId,
    String? selectedAnswer,
    bool? isCorrect,
    DateTime? answeredAt,
  }) = _ExamAnswerModel;

  factory ExamAnswerModel.fromFirestore(
    Map<String, dynamic> data,
    String id,
  ) {
    return ExamAnswerModel(
      id: id,
      sessionId: data['sessionId'] as String? ?? '',
      questionId: data['questionId'] as String? ?? '',
      selectedAnswer: data['selectedAnswer'] as String?,
      isCorrect: data['isCorrect'] as bool?,
      answeredAt: data['answeredAt'] != null
          ? (data['answeredAt'] as dynamic).toDate()
          : null,
    );
  }

  factory ExamAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$ExamAnswerModelFromJson(json);

  ExamAnswer toEntity() {
    return ExamAnswer(
      id: id,
      sessionId: sessionId,
      questionId: questionId,
      selectedAnswer: selectedAnswer,
      isCorrect: isCorrect,
      answeredAt: answeredAt,
    );
  }

  Map<String, dynamic> toCreateMap() {
    return {
      'sessionId': sessionId,
      'questionId': questionId,
      'selectedAnswer': selectedAnswer,
      'isCorrect': isCorrect,
      'answeredAt': answeredAt ?? FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      if (selectedAnswer != null) 'selectedAnswer': selectedAnswer,
      if (isCorrect != null) 'isCorrect': isCorrect,
      'answeredAt': answeredAt ?? FieldValue.serverTimestamp(),
    };
  }
}
