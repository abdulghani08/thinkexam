import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/exam.dart';
import '../../providers/student/student_exam_provider.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/loading_indicator.dart';

class StudentExamListPage extends ConsumerStatefulWidget {
  const StudentExamListPage({super.key});

  @override
  ConsumerState<StudentExamListPage> createState() =>
      _StudentExamListPageState();
}

class _StudentExamListPageState extends ConsumerState<StudentExamListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(studentExamListProvider.notifier).loadExams(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studentExamListProvider);
    final notifier = ref.read(studentExamListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Available Exams')),
      body: _buildContent(context, state, notifier),
    );
  }

  Widget _buildContent(
    BuildContext context,
    StudentExamListState state,
    StudentExamListNotifier notifier,
  ) {
    if (state.status == StudentExamListStatus.initial ||
        state.status == StudentExamListStatus.loading) {
      return const LoadingIndicator(message: 'Loading exams...');
    }

    if (state.status == StudentExamListStatus.error) {
      return ErrorState(
        title: 'Unable to load exams',
        message: state.errorMessage,
        onRetry: () {
          notifier.loadExams(refresh: true);
        },
      );
    }

    if (state.exams.isEmpty) {
      return EmptyState(
        icon: Icons.quiz_outlined,
        title: 'No available exams',
        message: 'Check back later for new exams',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.exams.length + (state.hasMore ? 1 : 0),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        if (index == state.exams.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: OutlinedButton.icon(
                onPressed: notifier.loadMore,
                icon: const Icon(Icons.expand_more),
                label: const Text('Load more'),
              ),
            ),
          );
        }

        final exam = state.exams[index];
        return _buildExamCard(context, exam);
      },
    );
  }

  Widget _buildExamCard(BuildContext context, Exam exam) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    exam.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Chip(
                  label: Text(exam.status.toUpperCase()),
                  backgroundColor: Colors.green.withOpacity(0.2),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (exam.description != null) ...[
              Text(exam.description!),
              const SizedBox(height: 8),
            ],
            Row(
              children: [
                Icon(Icons.access_time, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text('${exam.durationMinutes} minutes'),
                const SizedBox(width: 16),
                Icon(Icons.question_answer, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 4),
                const Text('Multiple choice'),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/student/exams/${exam.id}'),
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}
