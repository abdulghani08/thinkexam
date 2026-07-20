import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/admin/exam_provider.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_state.dart';

class ExamDetailPage extends ConsumerStatefulWidget {
  final String examId;
  const ExamDetailPage({super.key, required this.examId});

  @override
  ConsumerState<ExamDetailPage> createState() => _ExamDetailPageState();
}

class _ExamDetailPageState extends ConsumerState<ExamDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(examDetailProvider.notifier).loadExam(widget.examId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(examDetailProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Details'),
        actions: [
          if (state.exam?.status == 'draft') ...[
            IconButton(
              icon: const Icon(Icons.publish),
              tooltip: 'Publish',
              onPressed: () => _publishExam(context),
            ),
          ],
          if (state.exam?.status == 'published') ...[
            IconButton(
              icon: const Icon(Icons.archive),
              tooltip: 'Archive',
              onPressed: () => _archiveExam(context),
            ),
          ],
          IconButton(
            icon: const Icon(Icons.content_copy),
            tooltip: 'Duplicate',
            onPressed: () => _duplicateExam(context),
          ),
          PopupMenuButton<String>(
            onSelected: (action) {
              if (action == 'edit') {
                context.go('${RouteNames.adminExamEdit}/${widget.examId}');
              } else if (action == 'delete') {
                _deleteExam(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ],
      ),
      body: _buildContent(context, state),
    );
  }

  Widget _buildContent(BuildContext context, ExamDetailState state) {
    if (state.status == ExamDetailStatus.initial ||
        state.status == ExamDetailStatus.loading) {
      return const LoadingIndicator(message: 'Loading exam...');
    }

    if (state.status == ExamDetailStatus.error) {
      return ErrorState(
        title: 'Unable to load exam',
        message: state.errorMessage,
        onRetry: () =>
            ref.read(examDetailProvider.notifier).loadExam(widget.examId),
      );
    }

    final exam = state.exam;
    if (exam == null) {
      return const Center(child: Text('Exam not found'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard('Exam Information', [
            _buildInfoRow('Title', exam.title),
            _buildInfoRow('Status', exam.status.toUpperCase()),
            _buildInfoRow('Duration', '${exam.durationMinutes} minutes'),
            if (exam.description != null)
              _buildInfoRow('Description', exam.description!),
            if (exam.startTime != null)
              _buildInfoRow('Start Time', Formatters.formatDate(exam.startTime!)),
            if (exam.endTime != null)
              _buildInfoRow('End Time', Formatters.formatDate(exam.endTime!)),
          ]),
          const SizedBox(height: 16),
          _buildInfoCard('Settings', [
            _buildInfoRow(
              'Randomize Questions',
              exam.randomQuestion ? 'Yes' : 'No',
            ),
            _buildInfoRow(
              'Randomize Options',
              exam.randomOption ? 'Yes' : 'No',
            ),
            _buildInfoRow('Show Results', exam.showResult ? 'Yes' : 'No'),
          ]),
          const SizedBox(height: 16),
          _buildQuestionsSection(context),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildQuestionsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Questions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    context.push('/admin/exams/${widget.examId}/questions');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Question'),
                ),
              ],
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.quiz_outlined),
              title: Text('No questions yet'),
              subtitle: Text('Add questions to this exam'),
            ),
          ],
        ),
      ),
    );
  }

  void _publishExam(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Publish Exam'),
        content: const Text(
          'Are you sure you want to publish this exam? Students will be able to see and take this exam.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(examDetailProvider.notifier)
                  .publishExam(widget.examId);
              context.pop();
            },
            child: const Text('Publish'),
          ),
        ],
      ),
    );
  }

  void _archiveExam(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Archive Exam'),
        content: const Text(
          'Are you sure you want to archive this exam? It will no longer be visible to students.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(examDetailProvider.notifier)
                  .archiveExam(widget.examId);
              context.pop();
            },
            child: const Text('Archive'),
          ),
        ],
      ),
    );
  }

  void _duplicateExam(BuildContext context) {
    final authState = ref.read(authProvider);
    final createdBy = authState.user?.id ?? '';
    ref.read(examDetailProvider.notifier).duplicateExam(widget.examId, createdBy);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exam duplicated successfully')),
    );
  }

  void _deleteExam(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Exam'),
        content: const Text(
          'Are you sure you want to delete this exam? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref
                  .read(examDetailProvider.notifier)
                  .deleteExam(widget.examId);
              if (context.mounted) {
                context.pop();
                context.pop(); // Go back to list
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
