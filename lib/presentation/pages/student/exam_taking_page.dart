import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/exam_engine/exam_engine.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/exam.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/entities/question_option.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/exam/exam_engine_provider.dart';
import '../../widgets/common/loading_indicator.dart';

class ExamTakingPage extends ConsumerStatefulWidget {
  final String examId;
  const ExamTakingPage({super.key, required this.examId});

  @override
  ConsumerState<ExamTakingPage> createState() => _ExamTakingPageState();
}

class _ExamTakingPageState extends ConsumerState<ExamTakingPage> {
  @override
  void initState() {
    super.initState();
    _initializeExam();
  }

  Future<void> _initializeExam() async {
    // TODO: Fetch exam and questions from repositories
    // For now, using dummy data
    final exam = Exam(
      id: widget.examId,
      title: 'Sample Exam',
      subjectId: 'math',
      allowedClassIds: ['class1'],
      durationMinutes: 60,
      status: 'published',
      randomQuestion: false,
      randomOption: false,
      showResult: true,
      createdBy: 'teacher1',
    );

    final questions = [
      Question(
        id: 'q1',
        examId: widget.examId,
        questionText: 'What is 2 + 2?',
        questionType: 'single_choice',
        options: [
          QuestionOption(id: 'o1', text: '3'),
          QuestionOption(id: 'o2', text: '4'),
          QuestionOption(id: 'o3', text: '5'),
        ],
        correctAnswers: ['o2'],
        score: 10,
        order: 0,
      ),
    ];

    // Get student ID from auth provider
    final authState = ref.read(authProvider);
    final studentId = authState.user?.id ?? '';

    // TODO: Get device ID from device_info_plus
    final deviceId = 'device_id_placeholder';

    await ref
        .read(examEngineProvider.notifier)
        .initializeEngine(exam, questions, studentId, deviceId);
  }

  @override
  void dispose() {
    ref.read(examEngineProvider.notifier).disposeEngine();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final engine = ref.watch(examEngineProvider);

    if (engine == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: _buildAppBar(context, engine),
        body: _buildBody(context, engine),
        bottomNavigationBar: _buildBottomBar(context, engine),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, ExamEngine engine) {
    return AppBar(
      title: Text(engine.exam.title),
      actions: [
        _buildTimerChip(engine),
        const SizedBox(width: 8),
        _buildProgressChip(engine),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildTimerChip(ExamEngine engine) {
    final minutes = engine.remainingSeconds ~/ 60;
    final seconds = engine.remainingSeconds % 60;
    final timeStr =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Chip(
      avatar: const Icon(Icons.access_time, size: 18),
      label: Text(timeStr),
      backgroundColor: _getTimerColor(
        engine.remainingSeconds,
        engine.exam.durationMinutes * 60,
      ),
    );
  }

  Color _getTimerColor(int remaining, int total) {
    final ratio = remaining / total;
    if (ratio > 0.5) return Colors.green.withOpacity(0.2);
    if (ratio > 0.25) return Colors.orange.withOpacity(0.2);
    return Colors.red.withOpacity(0.2);
  }

  Widget _buildProgressChip(ExamEngine engine) {
    return Chip(
      avatar: const Icon(Icons.quiz, size: 18),
      label: Text(
        '${engine.currentQuestionIndex + 1}/${engine.totalQuestions}',
      ),
    );
  }

  Widget _buildBody(BuildContext context, ExamEngine engine) {
    if (engine.status == ExamEngineStatus.loading) {
      return const Center(child: LoadingIndicator(message: 'Loading exam...'));
    }

    if (engine.status == ExamEngineStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: ${engine.errorMessage}'),
          ],
        ),
      );
    }

    if (engine.status == ExamEngineStatus.completed) {
      return _buildCompletedView(context, engine);
    }

    final question = engine.currentQuestion;
    if (question == null) {
      return const Center(child: Text('No question available'));
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: _buildQuestionCard(context, engine, question),
          ),
        ),
        _buildQuestionNavigation(context, engine),
      ],
    );
  }

  Widget _buildQuestionCard(
    BuildContext context,
    ExamEngine engine,
    Question question,
  ) {
    final selectedAnswer = engine.answers[question.id]?.selectedAnswer;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Question ${engine.currentQuestionIndex + 1}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                ),
                const Spacer(),
                Chip(
                  label: Text('${question.score} points'),
                  backgroundColor: Colors.blue.withOpacity(0.1),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              question.questionText,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (question.questionImage != null) ...[
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(question.questionImage!),
              ),
            ],
            const SizedBox(height: 24),
            ...question.options.map((option) {
              final isSelected = selectedAnswer == option.id;
              return RadioListTile<String>(
                value: option.id,
                groupValue: selectedAnswer,
                title: Text(option.text),
                onChanged: (value) {
                  if (value != null) {
                    ref
                        .read(examEngineProvider.notifier)
                        .selectAnswer(question.id, value);
                  }
                },
                selected: isSelected,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionNavigation(BuildContext context, ExamEngine engine) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: const Border(top: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: engine.currentQuestionIndex > 0
                  ? () =>
                        ref.read(examEngineProvider.notifier).previousQuestion()
                  : null,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Previous'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: engine.currentQuestionIndex < engine.totalQuestions - 1
                  ? () => ref.read(examEngineProvider.notifier).nextQuestion()
                  : null,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, ExamEngine engine) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: Colors.grey)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _showSubmitDialog(context, engine),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Submit Exam'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedView(BuildContext context, ExamEngine engine) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 80, color: Colors.green),
          const SizedBox(height: 24),
          Text(
            'Exam Submitted!',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            'You answered ${engine.answeredCount} out of ${engine.totalQuestions} questions',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.go('/student/dashboard'),
            child: const Text('Return to Dashboard'),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showExitDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Exam'),
        content: const Text(
          'Are you sure you want to exit? Your progress will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => context.pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  Future<void> _showSubmitDialog(BuildContext context, ExamEngine engine) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit Exam'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have answered ${engine.answeredCount} out of ${engine.totalQuestions} questions.',
            ),
            const SizedBox(height: 8),
            if (engine.answeredCount < engine.totalQuestions)
              const Text(
                'You still have unanswered questions. Are you sure you want to submit?',
                style: TextStyle(color: Colors.orange),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              context.pop();
              await ref.read(examEngineProvider.notifier).submitExam();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
