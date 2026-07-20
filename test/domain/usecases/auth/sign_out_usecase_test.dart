import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/domain/repositories/auth_repository.dart';
import 'package:easyexam/domain/usecases/auth/sign_out_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignOutUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignOutUseCase(mockRepository);
  });

  test('should sign out successfully', () async {
    // arrange
    when(() => mockRepository.signOut())
        .thenAnswer((_) async => const Right(null));

    // act
    final result = await useCase(const NoParams());

    // assert
    expect(result, const Right(null));
    verify(() => mockRepository.signOut());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when sign out fails', () async {
    // arrange
    const tFailure = ServerFailure(message: 'Sign out failed');
    when(() => mockRepository.signOut())
        .thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await useCase(const NoParams());

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.signOut());
    verifyNoMoreInteractions(mockRepository);
  });
}
