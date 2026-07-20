import 'package:easyexam/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Failure Classes', () {
    test('ServerFailure should create with message', () {
      const failure = ServerFailure('Server error');
      expect(failure.message, 'Server error');
      expect(failure.code, isNull);
    });

    test('ServerFailure should create with message and code', () {
      const failure = ServerFailure('Server error', code: '500');
      expect(failure.message, 'Server error');
      expect(failure.code, '500');
    });

    test('NetworkFailure should create with message', () {
      const failure = NetworkFailure('No internet');
      expect(failure.message, 'No internet');
    });

    test('CacheFailure should create with message', () {
      const failure = CacheFailure('Cache error');
      expect(failure.message, 'Cache error');
    });

    test('AuthFailure should create with message', () {
      const failure = AuthFailure('Auth failed');
      expect(failure.message, 'Auth failed');
    });

    test('ValidationFailure should create with message', () {
      const failure = ValidationFailure('Invalid input');
      expect(failure.message, 'Invalid input');
    });

    test('PermissionFailure should create with message', () {
      const failure = PermissionFailure('Permission denied');
      expect(failure.message, 'Permission denied');
    });

    test('NotFoundFailure should create with message', () {
      const failure = NotFoundFailure('Not found');
      expect(failure.message, 'Not found');
    });

    test('ConflictFailure should create with message', () {
      const failure = ConflictFailure('Conflict');
      expect(failure.message, 'Conflict');
    });

    test('TimeoutFailure should create with message', () {
      const failure = TimeoutFailure('Timeout');
      expect(failure.message, 'Timeout');
    });

    test('UnknownFailure should create with message', () {
      const failure = UnknownFailure('Unknown error');
      expect(failure.message, 'Unknown error');
    });

    test('Failures should implement equality based on props', () {
      const failure1 = ServerFailure('Error', code: '500');
      const failure2 = ServerFailure('Error', code: '500');
      const failure3 = ServerFailure('Error', code: '404');

      expect(failure1, equals(failure2));
      expect(failure1, isNot(equals(failure3)));
    });
  });
}
