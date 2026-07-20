import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/question_option.dart';
import '../mappers/question_option_mapper.dart';

part 'question_model.freezed.dart';
part 'question_model.g.dart';

/// Firestore representation of a [Question].
@freezed
class QuestionModel with _$QuestionModel {
  const QuestionModel._();

  const factory QuestionModel({
    required String id,
    required String examId,
    required String questionText,
    String? questionImage,
    required String questionType,
    @JsonKey(ignore: true) @Default([]) List<QuestionOption> options,
    @Default([]) List<String> correctAnswers,
    String? explanation,
    @Default(1) int score,
    @Default(0) int order,
    @Default(true) bool isRequired,
  }) = _QuestionModel;

  factory QuestionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    final options = QuestionOptionMapper.fromFirestoreList(
      data['options'] as List<dynamic>?,
    );

    return QuestionModel(
      id: doc.id,
      examId: data['examId'] as String? ?? '',
      questionText: data['questionText'] as String? ?? '',
      questionImage: data['questionImage'] as String?,
      questionType: data['questionType'] as String? ?? 'single_choice',
      options: options,
      correctAnswers:
          (data['correctAnswers'] as List<dynamic>?)?.cast<String>() ?? [],
      explanation: data['explanation'] as String?,
      score: data['score'] as int? ?? 1,
      order: data['order'] as int? ?? 0,
      isRequired: data['isRequired'] as bool? ?? true,
    );
  }

  factory QuestionModel.fromEntity(Question question) => QuestionModel(
    id: question.id,
    examId: question.examId,
    questionText: question.questionText,
    questionImage: question.questionImage,
    questionType: question.questionType,
    options: question.options,
    correctAnswers: question.correctAnswers,
    explanation: question.explanation,
    score: question.score,
    order: question.order,
    isRequired: question.isRequired,
  );

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Question toEntity() => Question(
    id: id,
    examId: examId,
    questionText: questionText,
    questionImage: questionImage,
    questionType: questionType,
    options: options,
    correctAnswers: correctAnswers,
    explanation: explanation,
    score: score,
    order: order,
    isRequired: isRequired,
  );

  Map<String, dynamic> toCreateMap() => {
    'examId': examId,
    'questionText': questionText,
    'questionImage': questionImage,
    'questionType': questionType,
    'options': QuestionOptionMapper.toFirestoreList(options),
    'correctAnswers': correctAnswers,
    'explanation': explanation,
    'score': score,
    'order': order,
    'isRequired': isRequired,
  };

  Map<String, dynamic> toUpdateMap() => {
    'questionText': questionText,
    'questionImage': questionImage,
    'questionType': questionType,
    'options': QuestionOptionMapper.toFirestoreList(options),
    'correctAnswers': correctAnswers,
    'explanation': explanation,
    'score': score,
    'order': order,
    'isRequired': isRequired,
  };
}
