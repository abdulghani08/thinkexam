import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/domain/entities/auth_user.dart';
import 'package:easyexam/domain/repositories/auth_repository.dart';
import 'package:easyexam/domain/usecases/auth/sign_in_with_google_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignInWithGoogleUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignInWithGoogleUseCase(mockRepository);
  });

  const tAuthUser = AuthUser(
    id: '123',
    email: 'test@example.com',
    displayName: 'Test User',
  );

  test('should get AuthUser from the repository', () async {
    // arrange
    when(() => mockRepository.signInWithGoogle())
        .thenAnswer((_) async => const Right(tAuthUser));

    // act
    final result = await useCase(const NoParams());

    // assert
    expect(result, const Right(tAuthUser));
    verify(() => mockRepository.signInWithGoogle());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return ServerFailure when repository fails', () async {
    // arrange
    const tFailure = ServerFailure(message: 'Server error');
    when(() => mockRepository.signInWithGoogle())
        .thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await useCase(const NoParams());

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.signInWithGoogle());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return NetworkFailure when network error occurs', () async {
    // arrange
    const tFailure = NetworkFailure(message: 'No internet connection');
    when(() => mockRepository.signInWithGoogle())
        .thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await useCase(const NoParams());

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.signInWithGoogle());
    verifyNoMoreInteractions(mockRepository);
  });
}
