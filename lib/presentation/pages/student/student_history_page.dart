import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/exam_session.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/student/student_history_provider.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_state.dart';

class StudentHistoryPage extends ConsumerStatefulWidget {
  const StudentHistoryPage({super.key});

  @override
  ConsumerState<StudentHistoryPage> createState() => _StudentHistoryPageState();
}

class _StudentHistoryPageState extends ConsumerState<StudentHistoryPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_loadHistory);
  }

  void _loadHistory() {
    final authState = ref.read(authProvider);
    final studentId = authState.user?.id ?? '';
    if (studentId.isNotEmpty) {
      ref.read(studentHistoryProvider.notifier).loadHistory(studentId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(studentHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Exam History')),
      body: _buildContent(historyState),
    );
  }

  Widget _buildContent(StudentHistoryState state) {
    switch (state.status) {
      case StudentHistoryStatus.initial:
      case StudentHistoryStatus.loading:
        return const LoadingIndicator(message: 'Loading history...');
      case StudentHistoryStatus.error:
        return ErrorState(
          title: 'Unable to load history',
          message: state.errorMessage,
          onRetry: _loadHistory,
        );
      case StudentHistoryStatus.success:
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildFilterCard(state),
            const SizedBox(height: 16),
            if (state.filteredSessions.isEmpty)
              EmptyState(
                icon: Icons.history_outlined,
                title: 'No exam history',
                message: 'Your completed exams will appear here',
              )
            else
              ...state.filteredSessions.map(_buildHistoryItem),
          ],
        );
    }
  }

  Widget _buildFilterCard(StudentHistoryState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Filter by Status',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          value: state.filterStatus ?? 'all',
          items: const [
            DropdownMenuItem(value: 'all', child: Text('All')),
            DropdownMenuItem(value: 'completed', child: Text('Completed')),
            DropdownMenuItem(value: 'running', child: Text('In Progress')),
            DropdownMenuItem(value: 'abandoned', child: Text('Abandoned')),
          ],
          onChanged: (value) {
            ref.read(studentHistoryProvider.notifier).setFilter(value);
          },
        ),
      ),
    );
  }

  Widget _buildHistoryItem(ExamSession session) {
    final statusColor = switch (session.status) {
      ExamSessionStatus.completed => Colors.green,
      ExamSessionStatus.running => Colors.orange,
      ExamSessionStatus.abandoned => Colors.red,
      ExamSessionStatus.ready => Colors.grey,
    };
    final statusIcon = switch (session.status) {
      ExamSessionStatus.completed => Icons.check_circle,
      ExamSessionStatus.running => Icons.timer,
      ExamSessionStatus.abandoned => Icons.cancel,
      ExamSessionStatus.ready => Icons.schedule,
    };

    return Card(
      child: ListTile(
        leading: Icon(statusIcon, color: statusColor, size: 32),
        title: Text('Exam: ${session.examId}'),
        subtitle: Text(
          'Status: ${session.status.name}'
          '${session.endTime != null ? ' | ${Formatters.formatDate(session.endTime!)}' : ''}'
          '${session.startTime != null ? ' | Started: ${Formatters.formatDate(session.startTime!)}' : ''}',
        ),
        trailing: session.status == ExamSessionStatus.completed
            ? const Icon(Icons.chevron_right)
            : null,
        onTap: session.status == ExamSessionStatus.completed
            ? () {
                context.push(RouteNames.studentHistory);
              }
            : null,
      ),
    );
  }
}
