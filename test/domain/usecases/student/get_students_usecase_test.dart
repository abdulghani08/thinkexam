import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/domain/entities/student_page.dart';
import 'package:easyexam/domain/repositories/student_repository.dart';
import 'package:easyexam/domain/usecases/student/get_students_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStudentRepository extends Mock implements StudentRepository {}

void main() {
  late GetStudentsUseCase getStudentsUseCase;
  late MockStudentRepository mockStudentRepository;

  setUp(() {
    mockStudentRepository = MockStudentRepository();
    getStudentsUseCase = GetStudentsUseCase(mockStudentRepository);
  });

  group('GetStudentsUseCase', () {
    final testStudentPage = StudentPage(
      students: [],
      hasMore: false,
      nextCursor: null,
    );

    test('should call getStudents from repository', () async {
      when(() => mockStudentRepository.getStudents(
        cursor: any(named: 'cursor'),
        limit: any(named: 'limit'),
        classId: any(named: 'classId'),
      )).thenAnswer((_) async => Right(testStudentPage));

      final result = await getStudentsUseCase(const GetStudentsParams());

      expect(result, Right(testStudentPage));
      verify(() => mockStudentRepository.getStudents(
        cursor: null,
        limit: 20,
        classId: null,
      )).called(1);
    });

    test('should call getStudents with custom params', () async {
      when(() => mockStudentRepository.getStudents(
        cursor: any(named: 'cursor'),
        limit: any(named: 'limit'),
        classId: any(named: 'classId'),
      )).thenAnswer((_) async => Right(testStudentPage));

      final result = await getStudentsUseCase(const GetStudentsParams(
        cursor: 'cursor123',
        limit: 10,
        classId: 'class1',
      ));

      expect(result, Right(testStudentPage));
      verify(() => mockStudentRepository.getStudents(
        cursor: 'cursor123',
        limit: 10,
        classId: 'class1',
      )).called(1);
    });

    test('should return failure when getStudents fails', () async {
      when(() => mockStudentRepository.getStudents(
        cursor: any(named: 'cursor'),
        limit: any(named: 'limit'),
        classId: any(named: 'classId'),
      )).thenAnswer((_) async => const Left(ServerFailure('Failed to fetch')));

      final result = await getStudentsUseCase(const GetStudentsParams());

      expect(result, const Left(ServerFailure('Failed to fetch')));
    });
  });
}
