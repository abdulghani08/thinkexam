import 'package:easyexam/domain/entities/teacher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Teacher Entity', () {
    test('should create teacher with required fields', () {
      const teacher = Teacher(
        id: 'teacher-1',
        fullName: 'John Doe',
        email: 'john@example.com',
      );

      expect(teacher.id, 'teacher-1');
      expect(teacher.fullName, 'John Doe');
      expect(teacher.email, 'john@example.com');
      expect(teacher.role, 'ADMIN');
      expect(teacher.isActive, isTrue);
    });

    test('should create teacher with all fields', () {
      final now = DateTime.now();
      const teacher = Teacher(
        id: 'teacher-1',
        fullName: 'John Doe',
        email: 'john@example.com',
        photoUrl: 'https://example.com/photo.jpg',
        role: 'ADMIN',
        createdAt: null,
        updatedAt: null,
        isActive: true,
      );

      expect(teacher.id, 'teacher-1');
      expect(teacher.fullName, 'John Doe');
      expect(teacher.email, 'john@example.com');
      expect(teacher.photoUrl, 'https://example.com/photo.jpg');
      expect(teacher.role, 'ADMIN');
      expect(teacher.isActive, isTrue);
    });

    test('should copy teacher with new values', () {
      const teacher = Teacher(
        id: 'teacher-1',
        fullName: 'John Doe',
        email: 'john@example.com',
      );

      final updated = teacher.copyWith(
        fullName: 'Jane Doe',
        isActive: false,
      );

      expect(updated.id, 'teacher-1');
      expect(updated.fullName, 'Jane Doe');
      expect(updated.email, 'john@example.com');
      expect(updated.isActive, isFalse);
    });

    test('should preserve original when copying with null values', () {
      const teacher = Teacher(
        id: 'teacher-1',
        fullName: 'John Doe',
        email: 'john@example.com',
        isActive: true,
      );

      final copied = teacher.copyWith();

      expect(copied.id, teacher.id);
      expect(copied.fullName, teacher.fullName);
      expect(copied.email, teacher.email);
      expect(copied.isActive, teacher.isActive);
    });

    test('should implement equality based on props', () {
      const teacher1 = Teacher(
        id: 'teacher-1',
        fullName: 'John Doe',
        email: 'john@example.com',
      );

      const teacher2 = Teacher(
        id: 'teacher-1',
        fullName: 'John Doe',
        email: 'john@example.com',
      );

      const teacher3 = Teacher(
        id: 'teacher-2',
        fullName: 'John Doe',
        email: 'john@example.com',
      );

      expect(teacher1, equals(teacher2));
      expect(teacher1, isNot(equals(teacher3)));
    });

    test('should handle inactive teacher', () {
      const teacher = Teacher(
        id: 'teacher-1',
        fullName: 'John Doe',
        email: 'john@example.com',
        isActive: false,
      );

      expect(teacher.isActive, isFalse);
    });

    test('should handle custom role', () {
      const teacher = Teacher(
        id: 'teacher-1',
        fullName: 'John Doe',
        email: 'john@example.com',
        role: 'SUPER_ADMIN',
      );

      expect(teacher.role, 'SUPER_ADMIN');
    });
  });
}
