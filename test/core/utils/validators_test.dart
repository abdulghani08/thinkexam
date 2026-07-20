import 'package:easyexam/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    group('validateEmail', () {
      test('should return error when email is null', () {
        final result = Validators.validateEmail(null);
        expect(result, 'Email is required');
      });

      test('should return error when email is empty', () {
        final result = Validators.validateEmail('');
        expect(result, 'Email is required');
      });

      test('should return error when email is invalid', () {
        final result = Validators.validateEmail('invalid-email');
        expect(result, 'Please enter a valid email');
      });

      test('should return null when email is valid', () {
        final result = Validators.validateEmail('test@example.com');
        expect(result, isNull);
      });

      test('should accept valid email with subdomain', () {
        final result = Validators.validateEmail('test@mail.example.com');
        expect(result, isNull);
      });
    });

    group('validatePassword', () {
      test('should return error when password is null', () {
        final result = Validators.validatePassword(null);
        expect(result, 'Password is required');
      });

      test('should return error when password is empty', () {
        final result = Validators.validatePassword('');
        expect(result, 'Password is required');
      });

      test('should return error when password is too short', () {
        final result = Validators.validatePassword('12345');
        expect(result, 'Password must be at least 6 characters');
      });

      test('should return null when password is valid', () {
        final result = Validators.validatePassword('123456');
        expect(result, isNull);
      });
    });

    group('validateRequired', () {
      test('should return error when value is null', () {
        final result = Validators.validateRequired(null);
        expect(result, 'This field is required');
      });

      test('should return error when value is empty', () {
        final result = Validators.validateRequired('');
        expect(result, 'This field is required');
      });

      test('should return null when value is present', () {
        final result = Validators.validateRequired('value');
        expect(result, isNull);
      });

      test('should use custom field name', () {
        final result = Validators.validateRequired(null, fieldName: 'Name');
        expect(result, 'Name is required');
      });
    });

    group('validateNumber', () {
      test('should return error when value is null', () {
        final result = Validators.validateNumber(null);
        expect(result, 'This field is required');
      });

      test('should return error when value is empty', () {
        final result = Validators.validateNumber('');
        expect(result, 'This field is required');
      });

      test('should return error when value is not a number', () {
        final result = Validators.validateNumber('abc');
        expect(result, 'Please enter a valid number');
      });

      test('should return null when value is a valid number', () {
        final result = Validators.validateNumber('123');
        expect(result, isNull);
      });

      test('should accept zero', () {
        final result = Validators.validateNumber('0');
        expect(result, isNull);
      });
    });

    group('validatePositiveNumber', () {
      test('should return error when value is not a number', () {
        final result = Validators.validatePositiveNumber('abc');
        expect(result, 'Please enter a valid number');
      });

      test('should return error when value is zero', () {
        final result = Validators.validatePositiveNumber('0');
        expect(result, 'Please enter a positive number');
      });

      test('should return error when value is negative', () {
        final result = Validators.validatePositiveNumber('-5');
        expect(result, 'Please enter a positive number');
      });

      test('should return null when value is positive', () {
        final result = Validators.validatePositiveNumber('5');
        expect(result, isNull);
      });
    });

    group('validateMinDuration', () {
      test('should return error when value is not a number', () {
        final result = Validators.validateMinDuration('abc');
        expect(result, 'Please enter a valid number');
      });

      test('should return error when value is less than minimum', () {
        final result = Validators.validateMinDuration('3', minMinutes: 5);
        expect(result, 'Duration must be at least 5 minutes');
      });

      test('should return null when value meets minimum', () {
        final result = Validators.validateMinDuration('5', minMinutes: 5);
        expect(result, isNull);
      });

      test('should return null when value exceeds minimum', () {
        final result = Validators.validateMinDuration('10', minMinutes: 5);
        expect(result, isNull);
      });
    });

    group('validateSubjectCode', () {
      test('should return error when value is null', () {
        final result = Validators.validateSubjectCode(null);
        expect(result, 'Subject code is required');
      });

      test('should return error when value is empty', () {
        final result = Validators.validateSubjectCode('');
        expect(result, 'Subject code is required');
      });

      test('should return error when code is too short', () {
        final result = Validators.validateSubjectCode('A');
        expect(result, 'Use 2-20 letters, numbers, dash, or underscore');
      });

      test('should return error when code is too long', () {
        final result = Validators.validateSubjectCode('A' * 21);
        expect(result, 'Use 2-20 letters, numbers, dash, or underscore');
      });

      test('should return error when code has invalid characters', () {
        final result = Validators.validateSubjectCode('A@B');
        expect(result, 'Use 2-20 letters, numbers, dash, or underscore');
      });

      test('should return null when code is valid with letters', () {
        final result = Validators.validateSubjectCode('MATH');
        expect(result, isNull);
      });

      test('should return null when code is valid with numbers', () {
        final result = Validators.validateSubjectCode('MATH101');
        expect(result, isNull);
      });

      test('should return null when code is valid with dash', () {
        final result = Validators.validateSubjectCode('MATH-101');
        expect(result, isNull);
      });

      test('should return null when code is valid with underscore', () {
        final result = Validators.validateSubjectCode('MATH_101');
        expect(result, isNull);
      });
    });
  });
}
