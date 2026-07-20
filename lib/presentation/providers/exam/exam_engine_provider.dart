import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/exam_providers.dart';
import '../../../core/exam_engine/exam_engine.dart';
import '../../../domain/entities/exam.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/repositories/exam_session_repository.dart';
import '../../../domain/repositories/exam_answer_repository.dart';

class ExamEngineNotifier extends StateNotifier<ExamEngine?> {
  final ExamSessionRepository _sessionRepository;
  final ExamAnswerRepository _answerRepository;

  ExamEngineNotifier(
    this._sessionRepository,
    this._answerRepository,
  ) : super(null);

  Future<void> initializeEngine(
    Exam exam,
    List<Question> questions,
    String studentId,
    String deviceId,
  ) async {
    final engine = ExamEngine(
      sessionRepository: _sessionRepository,
      answerRepository: _answerRepository,
      exam: exam,
      questions: questions,
    );

    final initialized = await engine.initialize(studentId, deviceId);
    if (initialized) {
      state = engine;
    }
  }

  void startExam() {
    state?.startExam();
  }

  void pauseExam() {
    state?.pauseExam();
  }

  void resumeExam() {
    state?.resumeExam();
  }

  void goToQuestion(int index) {
    state?.goToQuestion(index);
  }

  void nextQuestion() {
    state?.nextQuestion();
  }

  void previousQuestion() {
    state?.previousQuestion();
  }

  void selectAnswer(String questionId, String answer) {
    state?.selectAnswer(questionId, answer);
  }

  Future<void> submitExam({bool autoSubmit = false}) async {
    await state?.submitExam(autoSubmit: autoSubmit);
  }

  void disposeEngine() {
    state?.dispose();
    state = null;
  }

  @override
  void dispose() {
    disposeEngine();
    super.dispose();
  }
}

final examEngineProvider =
    StateNotifierProvider<ExamEngineNotifier, ExamEngine?>((ref) {
  final sessionRepository = ref.watch(examSessionRepositoryProvider);
  final answerRepository = ref.watch(examAnswerRepositoryProvider);
  return ExamEngineNotifier(sessionRepository, answerRepository);
});
