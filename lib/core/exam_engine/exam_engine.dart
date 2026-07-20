import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/exam.dart';
import '../../domain/entities/exam_session.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/exam_answer.dart';
import '../../domain/repositories/exam_session_repository.dart';
import '../../domain/repositories/exam_answer_repository.dart';

enum ExamEngineStatus { idle, loading, running, paused, completed, error }

class ExamEngine extends ChangeNotifier {
  final ExamSessionRepository _sessionRepository;
  final ExamAnswerRepository _answerRepository;

  Exam _exam;
  List<Question> _questions;
  ExamSession? _session;
  Map<String, ExamAnswer> _answers;
  int _currentQuestionIndex;
  Timer? _timer;
  int _remainingSeconds;
  ExamEngineStatus _status;
  String? _errorMessage;

  ExamEngine({
    required ExamSessionRepository sessionRepository,
    required ExamAnswerRepository answerRepository,
    required Exam exam,
    required List<Question> questions,
  })  : _sessionRepository = sessionRepository,
        _answerRepository = answerRepository,
        _exam = exam,
        _questions = questions,
        _answers = {},
        _currentQuestionIndex = 0,
        _remainingSeconds = exam.durationMinutes * 60,
        _status = ExamEngineStatus.idle;

  Exam get exam => _exam;
  List<Question> get questions => _questions;
  ExamSession? get session => _session;
  Map<String, ExamAnswer> get answers => _answers;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question? get currentQuestion =>
      _currentQuestionIndex < _questions.length ? _questions[_currentQuestionIndex] : null;
  int get remainingSeconds => _remainingSeconds;
  ExamEngineStatus get status => _status;
  String? get errorMessage => _errorMessage;
  int get answeredCount => _answers.length;
  int get totalQuestions => _questions.length;
  double get progress => _currentQuestionIndex / _questions.length;

  Future<bool> initialize(String studentId, String deviceId) async {
    _status = ExamEngineStatus.loading;
    notifyListeners();

    try {
      final session = ExamSession(
        id: '',
        examId: _exam.id,
        studentId: studentId,
        status: ExamSessionStatus.ready,
        remainingTime: _remainingSeconds,
        deviceId: deviceId,
      );

      final result = await _sessionRepository.createSession(session);
      result.fold(
        (failure) {
          _status = ExamEngineStatus.error;
          _errorMessage = failure.message;
          notifyListeners();
          return false;
        },
        (createdSession) {
          _session = createdSession;
          _status = ExamEngineStatus.idle;
          notifyListeners();
          return true;
        },
      );

      return result.isRight();
    } catch (e) {
      _status = ExamEngineStatus.error;
      _errorMessage = 'Failed to initialize exam: $e';
      notifyListeners();
      return false;
    }
  }

  void startExam() {
    if (_session == null) {
      _status = ExamEngineStatus.error;
      _errorMessage = 'Session not initialized';
      notifyListeners();
      return;
    }

    _status = ExamEngineStatus.running;
    _session = _session!.copyWith(
      status: ExamSessionStatus.running,
      startTime: DateTime.now(),
    );
    
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
        
        if (_remainingSeconds % 30 == 0) {
          _autoSave();
        }
      } else {
        _timer?.cancel();
        submitExam(autoSubmit: true);
      }
    });
  }

  void pauseExam() {
    _status = ExamEngineStatus.paused;
    _timer?.cancel();
    notifyListeners();
  }

  void resumeExam() {
    if (_status == ExamEngineStatus.paused) {
      _status = ExamEngineStatus.running;
      _startTimer();
      notifyListeners();
    }
  }

  void goToQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentQuestionIndex = index;
      notifyListeners();
    }
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void selectAnswer(String questionId, String answer) {
    final question = _questions.firstWhere((q) => q.id == questionId);
    final isCorrect = question.correctAnswers.contains(answer);

    final examAnswer = ExamAnswer(
      id: '',
      sessionId: _session!.id,
      questionId: questionId,
      selectedAnswer: answer,
      isCorrect: isCorrect,
      answeredAt: DateTime.now(),
    );

    _answers[questionId] = examAnswer;
    notifyListeners();

    _saveAnswer(examAnswer);
  }

  Future<void> _saveAnswer(ExamAnswer answer) async {
    final existingAnswer = _answers[answer.questionId];
    
    if (existingAnswer != null && existingAnswer.id.isNotEmpty) {
      await _answerRepository.updateAnswer(answer.copyWith(id: existingAnswer.id));
    } else {
      final result = await _answerRepository.createAnswer(answer);
      result.fold(
        (failure) => debugPrint('Failed to save answer: ${failure.message}'),
        (created) {
          _answers[answer.questionId] = created;
          notifyListeners();
        },
      );
    }
  }

  Future<void> _autoSave() async {
    if (_session != null && _status == ExamEngineStatus.running) {
      await _sessionRepository.updateSession(_session!.copyWith(
        remainingTime: _remainingSeconds,
      ));
    }
  }

  Future<void> submitExam({bool autoSubmit = false}) async {
    _timer?.cancel();
    _status = ExamEngineStatus.loading;
    notifyListeners();

    try {
      if (_session != null) {
        final pendingAnswers = _answers.values
            .where((a) => a.selectedAnswer != null && a.id.isEmpty)
            .toList();

        if (pendingAnswers.isNotEmpty) {
          final answersWithSessionId = pendingAnswers.map((a) =>
            a.copyWith(sessionId: _session!.id)
          ).toList();
          await _answerRepository.createAnswersBatch(answersWithSessionId);
        }

        final updatedSession = _session!.copyWith(
          status: ExamSessionStatus.completed,
          endTime: DateTime.now(),
          remainingTime: _remainingSeconds,
        );

        await _sessionRepository.updateSession(updatedSession);
        _session = updatedSession;
      }

      _status = ExamEngineStatus.completed;
      notifyListeners();
    } catch (e) {
      _status = ExamEngineStatus.error;
      _errorMessage = 'Failed to submit exam: $e';
      notifyListeners();
    }
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
