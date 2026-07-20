import 'package:easyexam/domain/entities/exam.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Exam Entity', () {
    test('should create exam with required fields', () {
      const exam = Exam(
        id: 'exam-1',
        title: 'Math Test',
        subjectId: 'subject-1',
        durationMinutes: 60,
        createdBy: 'teacher-1',
      );

      expect(exam.id, 'exam-1');
      expect(exam.title, 'Math Test');
      expect(exam.subjectId, 'subject-1');
      expect(exam.durationMinutes, 60);
      expect(exam.status, 'draft');
      expect(exam.randomQuestion, isFalse);
      expect(exam.randomOption, isFalse);
      expect(exam.showResult, isTrue);
    });

    test('should create exam with all fields', () {
      final now = DateTime.now();
      const exam = Exam(
        id: 'exam-1',
        title: 'Math Test',
        description: 'Chapter 1-5',
        subjectId: 'subject-1',
        allowedClassIds: ['class-1', 'class-2'],
        durationMinutes: 60,
        startTime: null,
        endTime: null,
        status: 'published',
        randomQuestion: true,
        randomOption: true,
        showResult: false,
        passingGrade: 70,
        createdBy: 'teacher-1',
      );

      expect(exam.id, 'exam-1');
      expect(exam.title, 'Math Test');
      expect(exam.description, 'Chapter 1-5');
      expect(exam.subjectId, 'subject-1');
      expect(exam.allowedClassIds, ['class-1', 'class-2']);
      expect(exam.durationMinutes, 60);
      expect(exam.status, 'published');
      expect(exam.randomQuestion, isTrue);
      expect(exam.randomOption, isTrue);
      expect(exam.showResult, isFalse);
      expect(exam.passingGrade, 70);
    });

    test('should copy exam with new values', () {
      const exam = Exam(
        id: 'exam-1',
        title: 'Math Test',
        subjectId: 'subject-1',
        durationMinutes: 60,
        createdBy: 'teacher-1',
      );

      final updated = exam.copyWith(
        title: 'Science Test',
        status: 'published',
        durationMinutes: 90,
      );

      expect(updated.id, 'exam-1');
      expect(updated.title, 'Science Test');
      expect(updated.subjectId, 'subject-1');
      expect(updated.status, 'published');
      expect(updated.durationMinutes, 90);
    });

    test('should preserve original when copying with null values', () {
      const exam = Exam(
        id: 'exam-1',
        title: 'Math Test',
        subjectId: 'subject-1',
        durationMinutes: 60,
        createdBy: 'teacher-1',
      );

      final copied = exam.copyWith();

      expect(copied.id, exam.id);
      expect(copied.title, exam.title);
      expect(copied.subjectId, exam.subjectId);
      expect(copied.durationMinutes, exam.durationMinutes);
    });

    test('should implement equality based on props', () {
      const exam1 = Exam(
        id: 'exam-1',
        title: 'Math Test',
        subjectId: 'subject-1',
        durationMinutes: 60,
        createdBy: 'teacher-1',
      );

      const exam2 = Exam(
        id: 'exam-1',
        title: 'Math Test',
        subjectId: 'subject-1',
        durationMinutes: 60,
        createdBy: 'teacher-1',
      );

      const exam3 = Exam(
        id: 'exam-2',
        title: 'Math Test',
        subjectId: 'subject-1',
        durationMinutes: 60,
        createdBy: 'teacher-1',
      );

      expect(exam1, equals(exam2));
      expect(exam1, isNot(equals(exam3)));
    });

    test('should handle different exam statuses', () {
      const draft = Exam(
        id: 'exam-1',
        title: 'Math Test',
        subjectId: 'subject-1',
        durationMinutes: 60,
        createdBy: 'teacher-1',
        status: 'draft',
      );

      const published = Exam(
        id: 'exam-2',
        title: 'Math Test',
        subjectId: 'subject-1',
        durationMinutes: 60,
        createdBy: 'teacher-1',
        status: 'published',
      );

      const closed = Exam(
        id: 'exam-3',
        title: 'Math Test',
        subjectId: 'subject-1',
        durationMinutes: 60,
        createdBy: 'teacher-1',
        status: 'closed',
      );

      expect(draft.status, 'draft');
      expect(published.status, 'published');
      expect(closed.status, 'closed');
    });

    test('should handle randomization settings', () {
      const exam = Exam(
        id: 'exam-1',
        title: 'Math Test',
        subjectId: 'subject-1',
        durationMinutes: 60,
        createdBy: 'teacher-1',
        randomQuestion: true,
        randomOption: true,
      );

      expect(exam.randomQuestion, isTrue);
      expect(exam.randomOption, isTrue);
    });

    test('should handle passing grade', () {
      const exam = Exam(
        id: 'exam-1',
        title: 'Math Test',
        subjectId: 'subject-1',
        durationMinutes: 60,
        createdBy: 'teacher-1',
        passingGrade: 75,
      );

      expect(exam.passingGrade, 75);
    });
  });
}
