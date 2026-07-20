import 'package:easyexam/domain/entities/exam_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExamSession Entity', () {
    test('should create exam session with required fields', () {
      const session = ExamSession(
        id: 'session-1',
        examId: 'exam-1',
        studentId: 'student-1',
        status: 'ready',
      );

      expect(session.id, 'session-1');
      expect(session.examId, 'exam-1');
      expect(session.studentId, 'student-1');
      expect(session.status, 'ready');
    });

    test('should create exam session with all fields', () {
      final now = DateTime.now();
      const session = ExamSession(
        id: 'session-1',
        examId: 'exam-1',
        studentId: 'student-1',
        status: 'running',
        startTime: null,
        endTime: null,
        remainingTime: 1800,
        violationCount: 0,
        deviceId: 'device-123',
      );

      expect(session.id, 'session-1');
      expect(session.status, 'running');
      expect(session.remainingTime, 1800);
      expect(session.violationCount, 0);
      expect(session.deviceId, 'device-123');
    });

    test('should copy exam session with new values', () {
      const session = ExamSession(
        id: 'session-1',
        examId: 'exam-1',
        studentId: 'student-1',
        status: 'ready',
      );

      final updated = session.copyWith(
        status: 'running',
        remainingTime: 1700,
        violationCount: 1,
      );

      expect(updated.id, 'session-1');
      expect(updated.status, 'running');
      expect(updated.remainingTime, 1700);
      expect(updated.violationCount, 1);
    });

    test('should implement equality based on props', () {
      const session1 = ExamSession(
        id: 'session-1',
        examId: 'exam-1',
        studentId: 'student-1',
        status: 'ready',
      );

      const session2 = ExamSession(
        id: 'session-1',
        examId: 'exam-1',
        studentId: 'student-1',
        status: 'ready',
      );

      const session3 = ExamSession(
        id: 'session-2',
        examId: 'exam-1',
        studentId: 'student-1',
        status: 'ready',
      );

      expect(session1, equals(session2));
      expect(session1, isNot(equals(session3)));
    });

    test('should handle different session statuses', () {
      const ready = ExamSession(
        id: 'session-1',
        examId: 'exam-1',
        studentId: 'student-1',
        status: 'ready',
      );

      const running = ExamSession(
        id: 'session-2',
        examId: 'exam-1',
        studentId: 'student-1',
        status: 'running',
      );

      const completed = ExamSession(
        id: 'session-3',
        examId: 'exam-1',
        studentId: 'student-1',
        status: 'completed',
      );

      expect(ready.status, 'ready');
      expect(running.status, 'running');
      expect(completed.status, 'completed');
    });

    test('should handle violation count', () {
      const session = ExamSession(
        id: 'session-1',
        examId: 'exam-1',
        studentId: 'student-1',
        status: 'running',
        violationCount: 3,
      );

      expect(session.violationCount, 3);
    });

    test('should handle remaining time', () {
      const session = ExamSession(
        id: 'session-1',
        examId: 'exam-1',
        studentId: 'student-1',
        status: 'running',
        remainingTime: 900,
      );

      expect(session.remainingTime, 900);
    });
  });
}
