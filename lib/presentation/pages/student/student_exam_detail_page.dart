import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/exam.dart';
import '../../providers/student/student_exam_provider.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/loading_indicator.dart';

class StudentExamDetailPage extends ConsumerStatefulWidget {
  final String examId;
  const StudentExamDetailPage({super.key, required this.examId});

  @override
  ConsumerState<StudentExamDetailPage> createState() =>
      _StudentExamDetailPageState();
}

class _StudentExamDetailPageState extends ConsumerState<StudentExamDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          ref.read(studentExamDetailProvider.notifier).loadExam(widget.examId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studentExamDetailProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Exam Details')),
      body: _buildContent(context, state),
    );
  }

  Widget _buildContent(BuildContext context, StudentExamDetailState state) {
    if (state.status == StudentExamDetailStatus.initial ||
        state.status == StudentExamDetailStatus.loading) {
      return const LoadingIndicator(message: 'Loading exam...');
    }

    if (state.status == StudentExamDetailStatus.error) {
      return ErrorState(
        title: 'Unable to load exam',
        message: state.errorMessage,
        onRetry: () => ref
            .read(studentExamDetailProvider.notifier)
            .loadExam(widget.examId),
      );
    }

    final exam = state.exam;
    if (exam == null) {
      return const Center(child: Text('Exam not found'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(exam),
          const SizedBox(height: 16),
          _buildInstructionsCard(),
          const SizedBox(height: 16),
          _buildStartButton(context, exam),
        ],
      ),
    );
  }

  Widget _buildInfoCard(Exam exam) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    exam.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text(exam.status.toUpperCase()),
                  backgroundColor: Colors.green.withOpacity(0.2),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (exam.description != null) ...[
              Text(exam.description!),
              const SizedBox(height: 16),
            ],
            _buildInfoRow(
              Icons.access_time,
              'Duration',
              '${exam.durationMinutes} minutes',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              Icons.question_answer,
              'Question Type',
              'Multiple Choice',
            ),
            const SizedBox(height: 12),
            if (exam.randomQuestion)
              _buildInfoRow(Icons.shuffle, 'Random Questions', 'Yes'),
            if (exam.randomOption)
              _buildInfoRow(Icons.shuffle, 'Random Options', 'Yes'),
            if (exam.showResult)
              _buildInfoRow(Icons.visibility, 'Show Results', 'Yes'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  Widget _buildInstructionsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Instructions', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            const SizedBox(height: 8),
            const Text('• Read each question carefully before answering.'),
            const SizedBox(height: 8),
            const Text(
              '• You can navigate between questions using the Next/Previous buttons.',
            ),
            const SizedBox(height: 8),
            const Text('• Your answers are automatically saved.'),
            const SizedBox(height: 8),
            const Text('• Make sure to submit before time runs out.'),
            const SizedBox(height: 8),
            const Text('• Once submitted, you cannot change your answers.'),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context, Exam exam) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.push('/student/exam/${widget.examId}');
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text('Start Exam', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
