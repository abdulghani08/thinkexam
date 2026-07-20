import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/exam_session.dart';
import '../../providers/admin/result_provider.dart';
import '../../providers/admin/exam_provider.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_state.dart';

class ResultsPage extends ConsumerStatefulWidget {
  final String examId;
  const ResultsPage({super.key, required this.examId});

  @override
  ConsumerState<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends ConsumerState<ResultsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(resultProvider.notifier).loadResults(widget.examId);
      ref.read(examDetailProvider.notifier).loadExam(widget.examId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultState = ref.watch(resultProvider);
    final examState = ref.watch(examDetailProvider);
    final exam = examState.exam;

    return Scaffold(
      appBar: AppBar(title: Text(exam?.title ?? 'Exam Results')),
      body: _buildContent(resultState),
    );
  }

  Widget _buildContent(ResultState state) {
    switch (state.status) {
      case ResultStatus.initial:
      case ResultStatus.loading:
        return const LoadingIndicator(message: 'Loading results...');
      case ResultStatus.error:
        return ErrorState(
          title: 'Unable to load results',
          message: state.errorMessage,
          onRetry: () =>
              ref.read(resultProvider.notifier).loadResults(widget.examId),
        );
      case ResultStatus.success:
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _buildStatisticsCard(state),
            const SizedBox(height: 16),
            _buildResultsTable(state),
          ],
        );
    }
  }

  Widget _buildStatisticsCard(ResultState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Statistics', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Total Submissions',
                  '${state.sessions.length}',
                  Icons.people,
                ),
                _buildStatItem(
                  'Completed',
                  '${state.completedCount}',
                  Icons.check_circle,
                ),
                _buildStatItem(
                  'In Progress',
                  '${state.inProgressCount}',
                  Icons.timer,
                ),
                _buildStatItem(
                  'Abandoned',
                  '${state.sessions.length - state.completedCount - state.inProgressCount}',
                  Icons.cancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.blue),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildResultsTable(ResultState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Results',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            if (state.sessions.isEmpty)
              const ListTile(
                leading: Icon(Icons.person_outline),
                title: Text('No results yet'),
                subtitle: Text(
                  'Results will appear here after students complete the exam',
                ),
              )
            else
              ...state.sessions.map(
                (session) => ListTile(
                  leading: Icon(
                    session.status == ExamSessionStatus.completed
                        ? Icons.check_circle
                        : session.status == ExamSessionStatus.running
                        ? Icons.timer
                        : Icons.cancel,
                    color: session.status == ExamSessionStatus.completed
                        ? Colors.green
                        : session.status == ExamSessionStatus.running
                        ? Colors.orange
                        : Colors.red,
                  ),
                  title: Text('Student: ${session.studentId}'),
                  subtitle: Text(
                    'Status: ${session.status.name} '
                    '${session.endTime != null ? '| ${Formatters.formatDate(session.endTime!)}' : ''}',
                  ),
                  trailing: session.status == ExamSessionStatus.completed
                      ? TextButton(onPressed: () {}, child: const Text('View'))
                      : null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
