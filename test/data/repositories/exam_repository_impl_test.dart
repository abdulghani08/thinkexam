import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/data/repositories/exam_repository_impl.dart';
import 'package:easyexam/domain/entities/exam.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExamDataSource extends Mock {
  Future<Either<Failure, Exam>> createExam(Exam exam);
  Future<Either<Failure, Exam>> updateExam(Exam exam);
  Future<Either<Failure, void>> deleteExam(String id);
  Future<Either<Failure, Exam>> getExamById(String id);
  Future<Either<Failure, List<Exam>>> getExams();
  Future<Either<Failure, List<Exam>>> searchExams(String query);
}

void main() {
  late ExamRepositoryImpl examRepositoryImpl;
  late MockExamDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockExamDataSource();
    examRepositoryImpl = ExamRepositoryImpl(
      dataSource: mockDataSource,
    );
  });

  group('ExamRepositoryImpl', () {
    final testExam = Exam(
      id: 'exam1',
      title: 'Test Exam',
      subjectId: 'subject1',
      teacherId: 'teacher1',
      classIds: ['class1'],
      durationMinutes: 60,
      passingGrade: 70,
      shuffleQuestions: false,
      shuffleOptions: false,
      status: ExamStatus.published,
      createdAt: DateTime.now(),
    );

    test('should call createExam from data source', () async {
      when(() => mockDataSource.createExam(any()))
          .thenAnswer((_) async => Right(testExam));

      final result = await examRepositoryImpl.createExam(testExam);

      expect(result, Right(testExam));
      verify(() => mockDataSource.createExam(testExam)).called(1);
    });

    test('should return failure when createExam fails', () async {
      when(() => mockDataSource.createExam(any()))
          .thenAnswer((_) async => const Left(ServerFailure('Creation failed')));

      final result = await examRepositoryImpl.createExam(testExam);

      expect(result, const Left(ServerFailure('Creation failed')));
    });

    test('should call updateExam from data source', () async {
      when(() => mockDataSource.updateExam(any()))
          .thenAnswer((_) async => Right(testExam));

      final result = await examRepositoryImpl.updateExam(testExam);

      expect(result, Right(testExam));
      verify(() => mockDataSource.updateExam(testExam)).called(1);
    });

    test('should call deleteExam from data source', () async {
      when(() => mockDataSource.deleteExam(any()))
          .thenAnswer((_) async => const Right(null));

      final result = await examRepositoryImpl.deleteExam('exam1');

      expect(result, const Right(null));
      verify(() => mockDataSource.deleteExam('exam1')).called(1);
    });

    test('should call getExamById from data source', () async {
      when(() => mockDataSource.getExamById(any()))
          .thenAnswer((_) async => Right(testExam));

      final result = await examRepositoryImpl.getExamById('exam1');

      expect(result, Right(testExam));
      verify(() => mockDataSource.getExamById('exam1')).called(1);
    });

    test('should call getExams from data source', () async {
      when(() => mockDataSource.getExams())
          .thenAnswer((_) async => Right([testExam]));

      final result = await examRepositoryImpl.getExams();

      expect(result, Right([testExam]));
      verify(() => mockDataSource.getExams()).called(1);
    });

    test('should call searchExams from data source', () async {
      when(() => mockDataSource.searchExams(any()))
          .thenAnswer((_) async => Right([testExam]));

      final result = await examRepositoryImpl.searchExams('Test');

      expect(result, Right([testExam]));
      verify(() => mockDataSource.searchExams('Test')).called(1);
    });
  });
}
