import 'package:easyexam/domain/entities/subject.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Subject Entity', () {
    test('should create subject with required fields', () {
      const subject = Subject(
        id: 'subject-1',
        subjectName: 'Mathematics',
      );

      expect(subject.id, 'subject-1');
      expect(subject.subjectName, 'Mathematics');
    });

    test('should create subject with all fields', () {
      const subject = Subject(
        id: 'subject-1',
        subjectName: 'Mathematics',
        description: 'Math for elementary school',
      );

      expect(subject.id, 'subject-1');
      expect(subject.subjectName, 'Mathematics');
      expect(subject.description, 'Math for elementary school');
    });

    test('should copy subject with new values', () {
      const subject = Subject(
        id: 'subject-1',
        subjectName: 'Mathematics',
      );

      final updated = subject.copyWith(
        subjectName: 'Science',
        description: 'General science',
      );

      expect(updated.id, 'subject-1');
      expect(updated.subjectName, 'Science');
      expect(updated.description, 'General science');
    });

    test('should implement equality based on props', () {
      const subject1 = Subject(
        id: 'subject-1',
        subjectName: 'Mathematics',
      );

      const subject2 = Subject(
        id: 'subject-1',
        subjectName: 'Mathematics',
      );

      const subject3 = Subject(
        id: 'subject-2',
        subjectName: 'Mathematics',
      );

      expect(subject1, equals(subject2));
      expect(subject1, isNot(equals(subject3)));
    });

    test('should handle subject with description', () {
      const subject = Subject(
        id: 'subject-1',
        subjectName: 'Mathematics',
        description: 'Covers arithmetic, algebra, and geometry',
      );

      expect(subject.description, 'Covers arithmetic, algebra, and geometry');
    });
  });
}
