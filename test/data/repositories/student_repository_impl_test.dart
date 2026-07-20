import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/data/repositories/student_repository_impl.dart';
import 'package:easyexam/domain/entities/student.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStudentDataSource extends Mock {
  Future<Either<Failure, Student>> createStudent(Student student);
  Future<Either<Failure, Student>> updateStudent(Student student);
  Future<Either<Failure, void>> deleteStudent(String id);
  Future<Either<Failure, Student>> getStudentById(String id);
  Future<Either<Failure, List<Student>>> getStudents();
  Future<Either<Failure, List<Student>>> getStudentsByClass(String classId);
  Future<Either<Failure, List<Student>>> searchStudents(String query);
}

void main() {
  late StudentRepositoryImpl studentRepositoryImpl;
  late MockStudentDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockStudentDataSource();
    studentRepositoryImpl = StudentRepositoryImpl(
      dataSource: mockDataSource,
    );
  });

  group('StudentRepositoryImpl', () {
    final testStudent = Student(
      id: 'student1',
      fullName: 'John Doe',
      email: 'john@example.com',
      classId: 'class1',
      status: 'active',
      createdAt: DateTime.now(),
    );

    test('should call createStudent from data source', () async {
      when(() => mockDataSource.createStudent(any()))
          .thenAnswer((_) async => Right(testStudent));

      final result = await studentRepositoryImpl.createStudent(testStudent);

      expect(result, Right(testStudent));
      verify(() => mockDataSource.createStudent(testStudent)).called(1);
    });

    test('should return failure when createStudent fails', () async {
      when(() => mockDataSource.createStudent(any()))
          .thenAnswer((_) async => const Left(ServerFailure('Creation failed')));

      final result = await studentRepositoryImpl.createStudent(testStudent);

      expect(result, const Left(ServerFailure('Creation failed')));
    });

    test('should call updateStudent from data source', () async {
      when(() => mockDataSource.updateStudent(any()))
          .thenAnswer((_) async => Right(testStudent));

      final result = await studentRepositoryImpl.updateStudent(testStudent);

      expect(result, Right(testStudent));
      verify(() => mockDataSource.updateStudent(testStudent)).called(1);
    });

    test('should call deleteStudent from data source', () async {
      when(() => mockDataSource.deleteStudent(any()))
          .thenAnswer((_) async => const Right(null));

      final result = await studentRepositoryImpl.deleteStudent('student1');

      expect(result, const Right(null));
      verify(() => mockDataSource.deleteStudent('student1')).called(1);
    });

    test('should call getStudentById from data source', () async {
      when(() => mockDataSource.getStudentById(any()))
          .thenAnswer((_) async => Right(testStudent));

      final result = await studentRepositoryImpl.getStudentById('student1');

      expect(result, Right(testStudent));
      verify(() => mockDataSource.getStudentById('student1')).called(1);
    });

    test('should call getStudents from data source', () async {
      when(() => mockDataSource.getStudents())
          .thenAnswer((_) async => Right([testStudent]));

      final result = await studentRepositoryImpl.getStudents();

      expect(result, Right([testStudent]));
      verify(() => mockDataSource.getStudents()).called(1);
    });

    test('should call getStudentsByClass from data source', () async {
      when(() => mockDataSource.getStudentsByClass(any()))
          .thenAnswer((_) async => Right([testStudent]));

      final result = await studentRepositoryImpl.getStudentsByClass('class1');

      expect(result, Right([testStudent]));
      verify(() => mockDataSource.getStudentsByClass('class1')).called(1);
    });

    test('should call searchStudents from data source', () async {
      when(() => mockDataSource.searchStudents(any()))
          .thenAnswer((_) async => Right([testStudent]));

      final result = await studentRepositoryImpl.searchStudents('John');

      expect(result, Right([testStudent]));
      verify(() => mockDataSource.searchStudents('John')).called(1);
    });
  });
}
