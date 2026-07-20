import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/domain/entities/class.dart';
import 'package:easyexam/domain/repositories/class_repository.dart';
import 'package:easyexam/domain/usecases/class/get_classes_usecase.dart';
import 'package:easyexam/domain/usecases/base_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockClassRepository extends Mock implements ClassRepository {}

void main() {
  late GetClassesUseCase getClassesUseCase;
  late MockClassRepository mockClassRepository;

  setUp(() {
    mockClassRepository = MockClassRepository();
    getClassesUseCase = GetClassesUseCase(mockClassRepository);
  });

  group('GetClassesUseCase', () {
    final testClasses = [
      Class(
        id: 'class1',
        name: '5A',
        grade: 5,
        academicYear: '2024-2025',
        teacherId: 'teacher1',
        createdAt: DateTime.now(),
      ),
      Class(
        id: 'class2',
        name: '5B',
        grade: 5,
        academicYear: '2024-2025',
        teacherId: 'teacher2',
        createdAt: DateTime.now(),
      ),
    ];

    test('should call getClasses from repository', () async {
      when(() => mockClassRepository.getClasses())
          .thenAnswer((_) async => Right(testClasses));

      final result = await getClassesUseCase(const NoParams());

      expect(result, Right(testClasses));
      verify(() => mockClassRepository.getClasses()).called(1);
    });

    test('should return failure when getClasses fails', () async {
      when(() => mockClassRepository.getClasses())
          .thenAnswer((_) async => const Left(ServerFailure('Failed to fetch')));

      final result = await getClassesUseCase(const NoParams());

      expect(result, const Left(ServerFailure('Failed to fetch')));
    });
  });
}
