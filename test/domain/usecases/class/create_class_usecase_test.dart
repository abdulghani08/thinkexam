import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/domain/entities/class.dart';
import 'package:easyexam/domain/repositories/class_repository.dart';
import 'package:easyexam/domain/usecases/class/create_class_usecase.dart';
import 'package:easyexam/domain/usecases/base_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockClassRepository extends Mock implements ClassRepository {}

void main() {
  late CreateClassUseCase createClassUseCase;
  late MockClassRepository mockClassRepository;

  setUp(() {
    mockClassRepository = MockClassRepository();
    createClassUseCase = CreateClassUseCase(mockClassRepository);
  });

  group('CreateClassUseCase', () {
    final testClass = Class(
      id: 'class1',
      name: '5A',
      grade: 5,
      academicYear: '2024-2025',
      teacherId: 'teacher1',
      createdAt: DateTime.now(),
    );

    test('should call createClass from repository', () async {
      when(() => mockClassRepository.createClass(any()))
          .thenAnswer((_) async => Right(testClass));

      final result = await createClassUseCase(const NoParams());

      expect(result, Right(testClass));
      verify(() => mockClassRepository.createClass(any())).called(1);
    });

    test('should return failure when createClass fails', () async {
      when(() => mockClassRepository.createClass(any()))
          .thenAnswer((_) async => const Left(ServerFailure('Creation failed')));

      final result = await createClassUseCase(const NoParams());

      expect(result, const Left(ServerFailure('Creation failed')));
    });
  });
}
