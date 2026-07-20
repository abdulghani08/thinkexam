import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/data/repositories/auth_repository_impl.dart';
import 'package:easyexam/domain/entities/auth_user.dart';
import 'package:easyexam/domain/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authRepositoryImpl = AuthRepositoryImpl(
      dataSource: mockAuthRepository as dynamic,
    );
  });

  group('AuthRepositoryImpl', () {
    test('should call signInWithGoogle from repository', () async {
      const testUser = AuthUser(
        id: 'user1',
        email: 'test@example.com',
        displayName: 'Test User',
        role: 'STUDENT',
      );

      when(() => mockAuthRepository.signInWithGoogle())
          .thenAnswer((_) async => const Right(testUser));

      final result = await authRepositoryImpl.signInWithGoogle();

      expect(result, const Right(testUser));
      verify(() => mockAuthRepository.signInWithGoogle()).called(1);
    });

    test('should return failure when signInWithGoogle fails', () async {
      when(() => mockAuthRepository.signInWithGoogle())
          .thenAnswer((_) async => const Left(AuthFailure('Sign in failed')));

      final result = await authRepositoryImpl.signInWithGoogle();

      expect(result, const Left(AuthFailure('Sign in failed')));
    });

    test('should call signOut from repository', () async {
      when(() => mockAuthRepository.signOut())
          .thenAnswer((_) async => const Right(null));

      final result = await authRepositoryImpl.signOut();

      expect(result, const Right(null));
      verify(() => mockAuthRepository.signOut()).called(1);
    });

    test('should call getCurrentUser from repository', () async {
      const testUser = AuthUser(
        id: 'user1',
        email: 'test@example.com',
        displayName: 'Test User',
        role: 'STUDENT',
      );

      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => const Right(testUser));

      final result = await authRepositoryImpl.getCurrentUser();

      expect(result, const Right(testUser));
      verify(() => mockAuthRepository.getCurrentUser()).called(1);
    });
  });
}
