import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/domain/entities/student.dart';
import 'package:easyexam/domain/repositories/student_repository.dart';
import 'package:easyexam/domain/usecases/student/create_student_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStudentRepository extends Mock implements StudentRepository {}

void main() {
  late CreateStudentUseCase useCase;
  late MockStudentRepository mockRepository;

  setUp(() {
    mockRepository = MockStudentRepository();
    useCase = CreateStudentUseCase(mockRepository);
  });

  const tStudent = Student(
    id: 'student-1',
    fullName: 'Jane Smith',
    email: 'jane@example.com',
    classId: 'class-1',
  );

  test('should create student successfully', () async {
    // arrange
    when(() => mockRepository.createStudent(any()))
        .thenAnswer((_) async => const Right(tStudent));

    // act
    final result = await useCase(tStudent);

    // assert
    expect(result, const Right(tStudent));
    verify(() => mockRepository.createStudent(tStudent));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when create student fails', () async {
    // arrange
    const tFailure = ServerFailure(message: 'Failed to create student');
    when(() => mockRepository.createStudent(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await useCase(tStudent);

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.createStudent(tStudent));
    verifyNoMoreInteractions(mockRepository);
  });
}
