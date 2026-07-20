import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/domain/entities/exam_page.dart';
import 'package:easyexam/domain/repositories/exam_repository.dart';
import 'package:easyexam/domain/usecases/exam/get_exams_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExamRepository extends Mock implements ExamRepository {}

void main() {
  late GetExamsUseCase useCase;
  late MockExamRepository mockRepository;

  setUp(() {
    mockRepository = MockExamRepository();
    useCase = GetExamsUseCase(mockRepository);
  });

  final tExamPage = ExamPage(
    exams: [],
    hasMore: false,
    nextCursor: null,
  );

  test('should get list of exams from repository', () async {
    // arrange
    when(() => mockRepository.getExams(
      cursor: any(named: 'cursor'),
      limit: any(named: 'limit'),
    )).thenAnswer((_) async => Right(tExamPage));

    // act
    final result = await useCase(const GetExamsParams());

    // assert
    expect(result, Right(tExamPage));
    verify(() => mockRepository.getExams(
      cursor: null,
      limit: 20,
    ));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when get exams fails', () async {
    // arrange
    const tFailure = ServerFailure('Failed to get exams');
    when(() => mockRepository.getExams(
      cursor: any(named: 'cursor'),
      limit: any(named: 'limit'),
    )).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await useCase(const GetExamsParams());

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.getExams(
      cursor: null,
      limit: 20,
    ));
    verifyNoMoreInteractions(mockRepository);
  });
}
