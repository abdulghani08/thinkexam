import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/domain/entities/subject.dart';
import 'package:easyexam/domain/repositories/subject_repository.dart';
import 'package:easyexam/domain/usecases/subject/create_subject_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSubjectRepository extends Mock implements SubjectRepository {}

void main() {
  late CreateSubjectUseCase createSubjectUseCase;
  late MockSubjectRepository mockSubjectRepository;

  setUpAll(() {
    registerFallbackValue(const Subject(
      id: '',
      subjectName: '',
      subjectCode: '',
    ));
  });

  setUp(() {
    mockSubjectRepository = MockSubjectRepository();
    createSubjectUseCase = CreateSubjectUseCase(mockSubjectRepository);
  });

  group('CreateSubjectUseCase', () {
    final testSubject = Subject(
      id: 'subject1',
      subjectName: 'Mathematics',
      subjectCode: 'MATH',
      description: 'Mathematics subject',
      createdAt: DateTime.now(),
    );

    test('should call createSubject from repository', () async {
      when(() => mockSubjectRepository.createSubject(any()))
          .thenAnswer((_) async => Right(testSubject));

      final result = await createSubjectUseCase(testSubject);

      expect(result, Right(testSubject));
      verify(() => mockSubjectRepository.createSubject(testSubject)).called(1);
    });

    test('should return failure when createSubject fails', () async {
      when(() => mockSubjectRepository.createSubject(any()))
          .thenAnswer((_) async => const Left(ServerFailure('Creation failed')));

      final result = await createSubjectUseCase(testSubject);

      expect(result, const Left(ServerFailure('Creation failed')));
    });
  });
}
