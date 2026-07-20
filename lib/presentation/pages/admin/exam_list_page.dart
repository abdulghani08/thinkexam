import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/exam.dart';
import '../../providers/admin/exam_provider.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/loading_indicator.dart';

class ExamListPage extends ConsumerStatefulWidget {
  const ExamListPage({super.key});

  @override
  ConsumerState<ExamListPage> createState() => _ExamListPageState();
}

class _ExamListPageState extends ConsumerState<ExamListPage> {
  final _searchController = TextEditingController();
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(examListProvider.notifier).loadExams());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(examListProvider);
    final notifier = ref.read(examListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exams'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (status) {
              setState(() {
                _selectedStatus = status == 'all' ? null : status;
              });
              notifier.loadExams(status: _selectedStatus, refresh: true);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'all', child: Text('All Status')),
              const PopupMenuItem(value: 'draft', child: Text('Draft')),
              const PopupMenuItem(value: 'published', child: Text('Published')),
              const PopupMenuItem(value: 'archived', child: Text('Archived')),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(RouteNames.adminExamCreate),
        icon: const Icon(Icons.add),
        label: const Text('Create Exam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  notifier.searchExams(query, status: _selectedStatus);
                } else {
                  notifier.loadExams(status: _selectedStatus, refresh: true);
                }
              },
              decoration: InputDecoration(
                labelText: 'Search exams',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear search',
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          notifier.loadExams(
                            status: _selectedStatus,
                            refresh: true,
                          );
                          setState(() {});
                        },
                      ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 20),
            Expanded(child: _buildContent(context, state, notifier)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ExamListState state,
    ExamListNotifier notifier,
  ) {
    if (state.status == ExamListStatus.initial ||
        state.status == ExamListStatus.loading) {
      return const LoadingIndicator(message: 'Loading exams...');
    }

    if (state.status == ExamListStatus.error) {
      return ErrorState(
        title: 'Unable to load exams',
        message: state.errorMessage,
        onRetry: () =>
            notifier.loadExams(status: _selectedStatus, refresh: true),
      );
    }

    if (state.exams.isEmpty) {
      return EmptyState(
        icon: Icons.quiz_outlined,
        title: state.currentQuery != null && state.currentQuery!.isNotEmpty
            ? 'No exams found'
            : 'No exams yet',
        action: state.currentQuery == null || state.currentQuery!.isEmpty
            ? ElevatedButton.icon(
                onPressed: () => context.go(RouteNames.adminExamCreate),
                icon: const Icon(Icons.add),
                label: const Text('Create Exam'),
              )
            : null,
      );
    }

    return ListView.separated(
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
        return _buildExamTile(context, exam);
      },
    );
  }

  Widget _buildExamTile(BuildContext context, Exam exam) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      leading: CircleAvatar(child: Text(exam.title[0].toUpperCase())),
      title: Text(exam.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Duration: ${exam.durationMinutes} minutes'),
          if (exam.startTime != null)
            Text('Start: ${Formatters.formatDate(exam.startTime!)}'),
        ],
      ),
      isThreeLine: exam.startTime != null,
      trailing: Chip(
        label: Text(exam.status.toUpperCase()),
        backgroundColor: _getStatusColor(exam.status),
      ),
      onTap: () => context.go('${RouteNames.adminExamDetail}/${exam.id}'),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'published':
        return Colors.green.withOpacity(0.2);
      case 'draft':
        return Colors.grey.withOpacity(0.2);
      case 'archived':
        return Colors.orange.withOpacity(0.2);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }
}
