import 'package:easyexam/domain/entities/student.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Student Entity', () {
    test('should create student with required fields', () {
      const student = Student(
        id: 'student-1',
        fullName: 'Jane Smith',
        email: 'jane@example.com',
        classId: 'class-1',
      );

      expect(student.id, 'student-1');
      expect(student.fullName, 'Jane Smith');
      expect(student.email, 'jane@example.com');
      expect(student.classId, 'class-1');
      expect(student.isActive, isTrue);
    });

    test('should create student with all fields', () {
      const student = Student(
        id: 'student-1',
        fullName: 'Jane Smith',
        email: 'jane@example.com',
        studentNumber: 'STD-001',
        classId: 'class-1',
        photoUrl: 'https://example.com/photo.jpg',
        isActive: true,
      );

      expect(student.id, 'student-1');
      expect(student.fullName, 'Jane Smith');
      expect(student.email, 'jane@example.com');
      expect(student.studentNumber, 'STD-001');
      expect(student.classId, 'class-1');
      expect(student.photoUrl, 'https://example.com/photo.jpg');
      expect(student.isActive, isTrue);
    });

    test('should copy student with new values', () {
      const student = Student(
        id: 'student-1',
        fullName: 'Jane Smith',
        email: 'jane@example.com',
        classId: 'class-1',
      );

      final updated = student.copyWith(
        fullName: 'Jane Doe',
        classId: 'class-2',
        isActive: false,
      );

      expect(updated.id, 'student-1');
      expect(updated.fullName, 'Jane Doe');
      expect(updated.email, 'jane@example.com');
      expect(updated.classId, 'class-2');
      expect(updated.isActive, isFalse);
    });

    test('should preserve original when copying with null values', () {
      const student = Student(
        id: 'student-1',
        fullName: 'Jane Smith',
        email: 'jane@example.com',
        classId: 'class-1',
        isActive: true,
      );

      final copied = student.copyWith();

      expect(copied.id, student.id);
      expect(copied.fullName, student.fullName);
      expect(copied.email, student.email);
      expect(copied.classId, student.classId);
      expect(copied.isActive, student.isActive);
    });

    test('should implement equality based on props', () {
      const student1 = Student(
        id: 'student-1',
        fullName: 'Jane Smith',
        email: 'jane@example.com',
        classId: 'class-1',
      );

      const student2 = Student(
        id: 'student-1',
        fullName: 'Jane Smith',
        email: 'jane@example.com',
        classId: 'class-1',
      );

      const student3 = Student(
        id: 'student-2',
        fullName: 'Jane Smith',
        email: 'jane@example.com',
        classId: 'class-1',
      );

      expect(student1, equals(student2));
      expect(student1, isNot(equals(student3)));
    });

    test('should handle inactive student', () {
      const student = Student(
        id: 'student-1',
        fullName: 'Jane Smith',
        email: 'jane@example.com',
        classId: 'class-1',
        isActive: false,
      );

      expect(student.isActive, isFalse);
    });

    test('should handle student number', () {
      const student = Student(
        id: 'student-1',
        fullName: 'Jane Smith',
        email: 'jane@example.com',
        classId: 'class-1',
        studentNumber: 'NIS-12345',
      );

      expect(student.studentNumber, 'NIS-12345');
    });
  });
}
