import 'package:easyexam/core/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Exception Classes', () {
    test('ServerException should create with message', () {
      const exception = ServerException('Server error');
      expect(exception.message, 'Server error');
      expect(exception.code, isNull);
      expect(exception.toString(), 'Server error');
    });

    test('ServerException should create with message and code', () {
      const exception = ServerException('Server error', code: '500');
      expect(exception.message, 'Server error');
      expect(exception.code, '500');
    });

    test('NetworkException should create with message', () {
      const exception = NetworkException('No internet');
      expect(exception.message, 'No internet');
    });

    test('CacheException should create with message', () {
      const exception = CacheException('Cache error');
      expect(exception.message, 'Cache error');
    });

    test('AuthException should create with message', () {
      const exception = AuthException('Auth failed');
      expect(exception.message, 'Auth failed');
    });

    test('ValidationException should create with message', () {
      const exception = ValidationException('Invalid input');
      expect(exception.message, 'Invalid input');
    });

    test('PermissionException should create with message', () {
      const exception = PermissionException('Permission denied');
      expect(exception.message, 'Permission denied');
    });

    test('NotFoundException should create with message', () {
      const exception = NotFoundException('Not found');
      expect(exception.message, 'Not found');
    });

    test('ConflictException should create with message', () {
      const exception = ConflictException('Conflict');
      expect(exception.message, 'Conflict');
    });

    test('TimeoutException should create with message', () {
      const exception = TimeoutException('Timeout');
      expect(exception.message, 'Timeout');
    });

    test('UnknownException should create with message', () {
      const exception = UnknownException('Unknown error');
      expect(exception.message, 'Unknown error');
    });

    test('Exceptions should implement toString', () {
      const exception = ServerException('Test error');
      expect(exception.toString(), 'Test error');
    });
  });
}
