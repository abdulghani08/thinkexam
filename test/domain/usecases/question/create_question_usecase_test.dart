import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/domain/entities/question.dart';
import 'package:easyexam/domain/entities/question_option.dart';
import 'package:easyexam/domain/repositories/question_repository.dart';
import 'package:easyexam/domain/usecases/question/create_question_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockQuestionRepository extends Mock implements QuestionRepository {}

void main() {
  late CreateQuestionUseCase useCase;
  late MockQuestionRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(const Question(
      id: '',
      examId: '',
      questionText: '',
      questionType: 'multiple_choice',
    ));
  });

  setUp(() {
    mockRepository = MockQuestionRepository();
    useCase = CreateQuestionUseCase(mockRepository);
  });

  const tQuestion = Question(
    id: 'question-1',
    examId: 'exam-1',
    questionText: 'What is 2 + 2?',
    questionType: 'multiple_choice',
    options: [
      QuestionOption(id: '1', text: '3'),
      QuestionOption(id: '2', text: '4'),
      QuestionOption(id: '3', text: '5'),
      QuestionOption(id: '4', text: '6'),
    ],
    correctAnswers: ['4'],
    score: 1,
  );

  test('should create question successfully', () async {
    // arrange
    when(() => mockRepository.createQuestion(any()))
        .thenAnswer((_) async => const Right(tQuestion));

    // act
    final result = await useCase(tQuestion);

    // assert
    expect(result, const Right(tQuestion));
    verify(() => mockRepository.createQuestion(tQuestion));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when create question fails', () async {
    // arrange
    const tFailure = ServerFailure('Failed to create question');
    when(() => mockRepository.createQuestion(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await useCase(tQuestion);

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.createQuestion(tQuestion));
    verifyNoMoreInteractions(mockRepository);
  });
}
