import 'package:easyexam/domain/entities/exam_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExamResult Entity', () {
    test('should create exam result with required fields', () {
      const result = ExamResult(
        id: 'result-1',
        sessionId: 'session-1',
        studentId: 'student-1',
        examId: 'exam-1',
        totalScore: 85.0,
        totalCorrect: 17,
        totalWrong: 3,
      );

      expect(result.id, 'result-1');
      expect(result.sessionId, 'session-1');
      expect(result.studentId, 'student-1');
      expect(result.examId, 'exam-1');
      expect(result.totalScore, 85.0);
      expect(result.totalCorrect, 17);
      expect(result.totalWrong, 3);
    });

    test('should create exam result with all fields', () {
      final now = DateTime.now();
      const result = ExamResult(
        id: 'result-1',
        sessionId: 'session-1',
        studentId: 'student-1',
        examId: 'exam-1',
        totalScore: 85.0,
        totalCorrect: 17,
        totalWrong: 3,
        submittedAt: null,
      );

      expect(result.id, 'result-1');
      expect(result.totalScore, 85.0);
      expect(result.totalCorrect, 17);
      expect(result.totalWrong, 3);
    });

    test('should copy exam result with new values', () {
      const result = ExamResult(
        id: 'result-1',
        sessionId: 'session-1',
        studentId: 'student-1',
        examId: 'exam-1',
        totalScore: 85.0,
        totalCorrect: 17,
        totalWrong: 3,
      );

      final updated = result.copyWith(
        totalScore: 90.0,
        totalCorrect: 18,
        totalWrong: 2,
      );

      expect(updated.id, 'result-1');
      expect(updated.totalScore, 90.0);
      expect(updated.totalCorrect, 18);
      expect(updated.totalWrong, 2);
    });

    test('should implement equality based on props', () {
      const result1 = ExamResult(
        id: 'result-1',
        sessionId: 'session-1',
        studentId: 'student-1',
        examId: 'exam-1',
        totalScore: 85.0,
        totalCorrect: 17,
        totalWrong: 3,
      );

      const result2 = ExamResult(
        id: 'result-1',
        sessionId: 'session-1',
        studentId: 'student-1',
        examId: 'exam-1',
        totalScore: 85.0,
        totalCorrect: 17,
        totalWrong: 3,
      );

      const result3 = ExamResult(
        id: 'result-2',
        sessionId: 'session-1',
        studentId: 'student-1',
        examId: 'exam-1',
        totalScore: 85.0,
        totalCorrect: 17,
        totalWrong: 3,
      );

      expect(result1, equals(result2));
      expect(result1, isNot(equals(result3)));
    });

    test('should calculate percentage correctly', () {
      const result = ExamResult(
        id: 'result-1',
        sessionId: 'session-1',
        studentId: 'student-1',
        examId: 'exam-1',
        totalScore: 85.0,
        totalCorrect: 17,
        totalWrong: 3,
      );

      final totalQuestions = result.totalCorrect + result.totalWrong;
      final percentage = (result.totalCorrect / totalQuestions) * 100;
      
      expect(percentage, 85.0);
    });

    test('should handle perfect score', () {
      const result = ExamResult(
        id: 'result-1',
        sessionId: 'session-1',
        studentId: 'student-1',
        examId: 'exam-1',
        totalScore: 100.0,
        totalCorrect: 20,
        totalWrong: 0,
      );

      expect(result.totalScore, 100.0);
      expect(result.totalCorrect, 20);
      expect(result.totalWrong, 0);
    });

    test('should handle zero score', () {
      const result = ExamResult(
        id: 'result-1',
        sessionId: 'session-1',
        studentId: 'student-1',
        examId: 'exam-1',
        totalScore: 0.0,
        totalCorrect: 0,
        totalWrong: 20,
      );

      expect(result.totalScore, 0.0);
      expect(result.totalCorrect, 0);
      expect(result.totalWrong, 20);
    });
  });
}
