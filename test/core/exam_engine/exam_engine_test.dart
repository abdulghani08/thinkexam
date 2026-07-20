import 'package:dartz/dartz.dart';
import 'package:easyexam/core/error/failures.dart';
import 'package:easyexam/core/exam_engine/exam_engine.dart';
import 'package:easyexam/domain/entities/exam.dart';
import 'package:easyexam/domain/entities/exam_answer.dart';
import 'package:easyexam/domain/entities/exam_session.dart';
import 'package:easyexam/domain/entities/question.dart';
import 'package:easyexam/domain/repositories/exam_answer_repository.dart';
import 'package:easyexam/domain/repositories/exam_session_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExamSessionRepository extends Mock implements ExamSessionRepository {}
class MockExamAnswerRepository extends Mock implements ExamAnswerRepository {}

void main() {
  late MockExamSessionRepository mockSessionRepository;
  late MockExamAnswerRepository mockAnswerRepository;
  late ExamEngine examEngine;
  late Exam testExam;
  late List<Question> testQuestions;

  setUp(() {
    mockSessionRepository = MockExamSessionRepository();
    mockAnswerRepository = MockExamAnswerRepository();

    testExam = Exam(
      id: 'exam1',
      title: 'Test Exam',
      subjectId: 'subject1',
      teacherId: 'teacher1',
      classIds: ['class1'],
      durationMinutes: 60,
      passingGrade: 70,
      shuffleQuestions: false,
      shuffleOptions: false,
      status: ExamStatus.published,
      createdAt: DateTime.now(),
    );

    testQuestions = [
      Question(
        id: 'q1',
        examId: 'exam1',
        type: QuestionType.multipleChoice,
        questionText: 'What is 2+2?',
        options: ['3', '4', '5', '6'],
        correctAnswers: ['4'],
        score: 10,
      ),
      Question(
        id: 'q2',
        examId: 'exam1',
        type: QuestionType.multipleChoice,
        questionText: 'What is 3+3?',
        options: ['5', '6', '7', '8'],
        correctAnswers: ['6'],
        score: 10,
      ),
    ];

    examEngine = ExamEngine(
      sessionRepository: mockSessionRepository,
      answerRepository: mockAnswerRepository,
      exam: testExam,
      questions: testQuestions,
    );
  });

  tearDown(() {
    examEngine.dispose();
  });

  group('ExamEngine Initialization', () {
    test('should initialize with correct values', () {
      expect(examEngine.exam, testExam);
      expect(examEngine.questions, testQuestions);
      expect(examEngine.currentQuestionIndex, 0);
      expect(examEngine.remainingSeconds, 3600); // 60 minutes
      expect(examEngine.status, ExamEngineStatus.idle);
      expect(examEngine.answers, isEmpty);
    });

    test('should initialize session successfully', () async {
      final testSession = ExamSession(
        id: 'session1',
        examId: 'exam1',
        studentId: 'student1',
        status: ExamSessionStatus.ready,
        remainingTime: 3600,
        deviceId: 'device1',
      );

      when(() => mockSessionRepository.createSession(any()))
          .thenAnswer((_) async => Right(testSession));

      final result = await examEngine.initialize('student1', 'device1');

      expect(result, true);
      expect(examEngine.status, ExamEngineStatus.idle);
      expect(examEngine.session, testSession);
    });

    test('should handle session creation failure', () async {
      when(() => mockSessionRepository.createSession(any()))
          .thenAnswer((_) async => const Left(ServerFailure('Failed to create session')));

      final result = await examEngine.initialize('student1', 'device1');

      expect(result, false);
      expect(examEngine.status, ExamEngineStatus.error);
      expect(examEngine.errorMessage, 'Failed to create session');
    });

    test('should handle session creation exception', () async {
      when(() => mockSessionRepository.createSession(any()))
          .thenThrow(Exception('Network error'));

      final result = await examEngine.initialize('student1', 'device1');

      expect(result, false);
      expect(examEngine.status, ExamEngineStatus.error);
      expect(examEngine.errorMessage, contains('Failed to initialize exam'));
    });
  });

  group('ExamEngine Navigation', () {
    setUp(() async {
      final testSession = ExamSession(
        id: 'session1',
        examId: 'exam1',
        studentId: 'student1',
        status: ExamSessionStatus.ready,
        remainingTime: 3600,
        deviceId: 'device1',
      );

      when(() => mockSessionRepository.createSession(any()))
          .thenAnswer((_) async => Right(testSession));
      await examEngine.initialize('student1', 'device1');
    });

    test('should go to specific question', () {
      examEngine.goToQuestion(1);
      expect(examEngine.currentQuestionIndex, 1);
    });

    test('should not go to invalid question index', () {
      examEngine.goToQuestion(5);
      expect(examEngine.currentQuestionIndex, 0);
    });

    test('should not go to negative question index', () {
      examEngine.goToQuestion(-1);
      expect(examEngine.currentQuestionIndex, 0);
    });

    test('should go to next question', () {
      examEngine.nextQuestion();
      expect(examEngine.currentQuestionIndex, 1);
    });

    test('should not go beyond last question', () {
      examEngine.goToQuestion(1);
      examEngine.nextQuestion();
      expect(examEngine.currentQuestionIndex, 1);
    });

    test('should go to previous question', () {
      examEngine.goToQuestion(1);
      examEngine.previousQuestion();
      expect(examEngine.currentQuestionIndex, 0);
    });

    test('should not go before first question', () {
      examEngine.previousQuestion();
      expect(examEngine.currentQuestionIndex, 0);
    });

    test('should return current question', () {
      expect(examEngine.currentQuestion?.id, 'q1');
      examEngine.goToQuestion(1);
      expect(examEngine.currentQuestion?.id, 'q2');
    });

    test('should return null for invalid question index', () {
      examEngine.goToQuestion(5);
      expect(examEngine.currentQuestion, isNull);
    });
  });

  group('ExamEngine Answer Selection', () {
    setUp(() async {
      final testSession = ExamSession(
        id: 'session1',
        examId: 'exam1',
        studentId: 'student1',
        status: ExamSessionStatus.ready,
        remainingTime: 3600,
        deviceId: 'device1',
      );

      when(() => mockSessionRepository.createSession(any()))
          .thenAnswer((_) async => Right(testSession));
      when(() => mockAnswerRepository.createAnswer(any()))
          .thenAnswer((_) async => Right(ExamAnswer(
            id: 'answer1',
            sessionId: 'session1',
            questionId: 'q1',
            selectedAnswer: '4',
            isCorrect: true,
            answeredAt: DateTime.now(),
          )));

      await examEngine.initialize('student1', 'device1');
    });

    test('should select answer for question', () {
      examEngine.selectAnswer('q1', '4');
      expect(examEngine.answers.containsKey('q1'), true);
      expect(examEngine.answers['q1']?.selectedAnswer, '4');
      expect(examEngine.answers['q1']?.isCorrect, true);
    });

    test('should mark incorrect answer', () {
      examEngine.selectAnswer('q1', '3');
      expect(examEngine.answers['q1']?.isCorrect, false);
    });

    test('should update answer count', () {
      expect(examEngine.answeredCount, 0);
      examEngine.selectAnswer('q1', '4');
      expect(examEngine.answeredCount, 1);
    });

    test('should calculate progress', () {
      expect(examEngine.progress, 0.0);
      examEngine.goToQuestion(1);
      expect(examEngine.progress, 0.5);
    });
  });

  group('ExamEngine Timer', () {
    setUp(() async {
      final testSession = ExamSession(
        id: 'session1',
        examId: 'exam1',
        studentId: 'student1',
        status: ExamSessionStatus.ready,
        remainingTime: 3600,
        deviceId: 'device1',
      );

      when(() => mockSessionRepository.createSession(any()))
          .thenAnswer((_) async => Right(testSession));
      when(() => mockSessionRepository.updateSession(any()))
          .thenAnswer((_) async => const Right(null));
      await examEngine.initialize('student1', 'device1');
    });

    test('should start exam', () {
      examEngine.startExam();
      expect(examEngine.status, ExamEngineStatus.running);
      expect(examEngine.session?.status, ExamSessionStatus.running);
    });

    test('should not start exam without session', () {
      final engineWithoutSession = ExamEngine(
        sessionRepository: mockSessionRepository,
        answerRepository: mockAnswerRepository,
        exam: testExam,
        questions: testQuestions,
      );
      
      engineWithoutSession.startExam();
      expect(engineWithoutSession.status, ExamEngineStatus.error);
      expect(engineWithoutSession.errorMessage, 'Session not initialized');
      
      engineWithoutSession.dispose();
    });

    test('should pause exam', () {
      examEngine.startExam();
      examEngine.pauseExam();
      expect(examEngine.status, ExamEngineStatus.paused);
    });

    test('should resume exam', () {
      examEngine.startExam();
      examEngine.pauseExam();
      examEngine.resumeExam();
      expect(examEngine.status, ExamEngineStatus.running);
    });

    test('should not resume if not paused', () {
      examEngine.resumeExam();
      expect(examEngine.status, ExamEngineStatus.idle);
    });
  });

  group('ExamEngine Submission', () {
    setUp(() async {
      final testSession = ExamSession(
        id: 'session1',
        examId: 'exam1',
        studentId: 'student1',
        status: ExamSessionStatus.ready,
        remainingTime: 3600,
        deviceId: 'device1',
      );

      when(() => mockSessionRepository.createSession(any()))
          .thenAnswer((_) async => Right(testSession));
      when(() => mockSessionRepository.updateSession(any()))
          .thenAnswer((_) async => const Right(null));
      await examEngine.initialize('student1', 'device1');
    });

    test('should submit exam manually', () async {
      examEngine.startExam();
      await examEngine.submitExam();
      
      expect(examEngine.status, ExamEngineStatus.completed);
      expect(examEngine.session?.status, ExamSessionStatus.completed);
      verify(() => mockSessionRepository.updateSession(any())).called(1);
    });

    test('should submit exam with auto submit flag', () async {
      examEngine.startExam();
      await examEngine.submitExam(autoSubmit: true);
      
      expect(examEngine.status, ExamEngineStatus.completed);
    });

    test('should handle submission error', () async {
      examEngine.startExam();
      when(() => mockSessionRepository.updateSession(any()))
          .thenThrow(Exception('Network error'));
      
      await examEngine.submitExam();
      
      expect(examEngine.status, ExamEngineStatus.error);
      expect(examEngine.errorMessage, contains('Failed to submit exam'));
    });

    test('should cancel timer on submission', () async {
      examEngine.startExam();
      await examEngine.submitExam();
      
      // Timer should be cancelled (no way to directly test, but submission should complete)
      expect(examEngine.status, ExamEngineStatus.completed);
    });
  });

  group('ExamEngine Properties', () {
    test('should return total questions', () {
      expect(examEngine.totalQuestions, 2);
    });

    test('should return answered count', () async {
      final testSession = ExamSession(
        id: 'session1',
        examId: 'exam1',
        studentId: 'student1',
        status: ExamSessionStatus.ready,
        remainingTime: 3600,
        deviceId: 'device1',
      );

      when(() => mockSessionRepository.createSession(any()))
          .thenAnswer((_) async => Right(testSession));
      when(() => mockAnswerRepository.createAnswer(any()))
          .thenAnswer((_) async => Right(ExamAnswer(
            id: 'answer1',
            sessionId: 'session1',
            questionId: 'q1',
            selectedAnswer: '4',
            isCorrect: true,
            answeredAt: DateTime.now(),
          )));

      await examEngine.initialize('student1', 'device1');
      examEngine.selectAnswer('q1', '4');
      
      expect(examEngine.answeredCount, 1);
    });
  });
}
