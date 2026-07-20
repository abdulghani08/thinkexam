import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/domain/entities/exam.dart';
import 'package:easyexam/domain/repositories/exam_repository.dart';
import 'package:easyexam/domain/usecases/exam/create_exam_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExamRepository extends Mock implements ExamRepository {}

void main() {
  late CreateExamUseCase useCase;
  late MockExamRepository mockRepository;

  setUp(() {
    mockRepository = MockExamRepository();
    useCase = CreateExamUseCase(mockRepository);
  });

  const tExam = Exam(
    id: 'exam-1',
    title: 'Math Test',
    subjectId: 'subject-1',
    durationMinutes: 60,
    createdBy: 'teacher-1',
    status: 'draft',
  );

  test('should create exam successfully', () async {
    // arrange
    when(() => mockRepository.createExam(any()))
        .thenAnswer((_) async => const Right(tExam));

    // act
    final result = await useCase(tExam);

    // assert
    expect(result, const Right(tExam));
    verify(() => mockRepository.createExam(tExam));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when create exam fails', () async {
    // arrange
    const tFailure = ServerFailure(message: 'Failed to create exam');
    when(() => mockRepository.createExam(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await useCase(tExam);

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.createExam(tExam));
    verifyNoMoreInteractions(mockRepository);
  });
}
