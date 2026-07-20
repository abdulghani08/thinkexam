import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/domain/entities/subject_page.dart';
import 'package:easyexam/domain/repositories/subject_repository.dart';
import 'package:easyexam/domain/usecases/subject/get_subjects_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSubjectRepository extends Mock implements SubjectRepository {}

void main() {
  late GetSubjectsUseCase getSubjectsUseCase;
  late MockSubjectRepository mockSubjectRepository;

  setUp(() {
    mockSubjectRepository = MockSubjectRepository();
    getSubjectsUseCase = GetSubjectsUseCase(mockSubjectRepository);
  });

  group('GetSubjectsUseCase', () {
    final testSubjectPage = SubjectPage(
      subjects: [],
      hasMore: false,
      nextCursor: null,
    );

    test('should call getSubjects from repository', () async {
      when(() => mockSubjectRepository.getSubjects(
        cursor: any(named: 'cursor'),
        limit: any(named: 'limit'),
      )).thenAnswer((_) async => Right(testSubjectPage));

      final result = await getSubjectsUseCase(const GetSubjectsParams());

      expect(result, Right(testSubjectPage));
      verify(() => mockSubjectRepository.getSubjects(
        cursor: null,
        limit: 20,
      )).called(1);
    });

    test('should call getSubjects with custom params', () async {
      when(() => mockSubjectRepository.getSubjects(
        cursor: any(named: 'cursor'),
        limit: any(named: 'limit'),
      )).thenAnswer((_) async => Right(testSubjectPage));

      final result = await getSubjectsUseCase(const GetSubjectsParams(
        cursor: 'cursor123',
        limit: 10,
      ));

      expect(result, Right(testSubjectPage));
      verify(() => mockSubjectRepository.getSubjects(
        cursor: 'cursor123',
        limit: 10,
      )).called(1);
    });

    test('should return failure when getSubjects fails', () async {
      when(() => mockSubjectRepository.getSubjects(
        cursor: any(named: 'cursor'),
        limit: any(named: 'limit'),
      )).thenAnswer((_) async => const Left(ServerFailure('Failed to fetch')));

      final result = await getSubjectsUseCase(const GetSubjectsParams());

      expect(result, const Left(ServerFailure('Failed to fetch')));
    });
  });
}
