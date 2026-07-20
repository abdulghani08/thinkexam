import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/domain/entities/auth_user.dart';
import 'package:easyexam/domain/repositories/auth_repository.dart';
import 'package:easyexam/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late GetCurrentUser	UseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = GetCurrentUserUseCase(mockRepository);
  });

  const tAuthUser = AuthUser(
    uid: '123',
    email: 'test@example.com',
    displayName: 'Test User',
  );

  test('should get current user from repository', () async {
    // arrange
    when(() => mockRepository.getCurrentUser())
        .thenAnswer((_) async => const Right(tAuthUser));

    // act
    final result = await useCase(const NoParams());

    // assert
    expect(result, const Right(tAuthUser));
    verify(() => mockRepository.getCurrentUser());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when no user is logged in', () async {
    // arrange
    const tFailure = ServerFailure(message: 'No user logged in');
    when(() => mockRepository.getCurrentUser())
        .thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await useCase(const NoParams());

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.getCurrentUser());
    verifyNoMoreInteractions(mockRepository);
  });
}
