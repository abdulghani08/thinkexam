import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../providers/admin/student_provider.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/loading_indicator.dart';

class StudentListPage extends ConsumerStatefulWidget {
  const StudentListPage({super.key});

  @override
  ConsumerState<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends ConsumerState<StudentListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(studentListProvider.notifier).loadStudents());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studentListProvider);
    final notifier = ref.read(studentListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(RouteNames.adminStudentCreate),
        icon: const Icon(Icons.person_add),
        label: const Text('Add Student'),
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
                  notifier.searchStudents(query);
                } else {
                  notifier.loadStudents(refresh: true);
                }
              },
              decoration: InputDecoration(
                labelText: 'Search students',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear search',
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          notifier.loadStudents(refresh: true);
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
    StudentListState state,
    StudentListNotifier notifier,
  ) {
    if (state.status == StudentListStatus.initial ||
        state.status == StudentListStatus.loading) {
      return const LoadingIndicator(message: 'Loading students...');
    }

    if (state.status == StudentListStatus.error) {
      return ErrorState(
        title: 'Unable to load students',
        message: state.errorMessage,
        onRetry: () => notifier.loadStudents(refresh: true),
      );
    }

    if (state.students.isEmpty) {
      return EmptyState(
        icon: Icons.people_outline,
        title: state.currentQuery != null && state.currentQuery!.isNotEmpty
            ? 'No students found'
            : 'No students yet',
        action: state.currentQuery == null || state.currentQuery!.isEmpty
            ? ElevatedButton.icon(
                onPressed: () => context.go(RouteNames.adminStudentCreate),
                icon: const Icon(Icons.person_add),
                label: const Text('Add Student'),
              )
            : null,
      );
    }

    return ListView.separated(
      itemCount: state.students.length + (state.hasMore ? 1 : 0),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        if (index == state.students.length) {
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

        final student = state.students[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 6,
          ),
          leading: CircleAvatar(
            backgroundImage: student.photoUrl?.isNotEmpty == true
                ? NetworkImage(student.photoUrl!)
                : null,
            child: student.photoUrl?.isNotEmpty == true
                ? null
                : const Icon(Icons.person),
          ),
          title: Text(student.fullName),
          subtitle: Text(
            '${student.email}\n${student.studentNumber ?? 'No ID'}\nCreated ${student.createdAt == null ? '-' : Formatters.formatDate(student.createdAt!)}',
          ),
          isThreeLine: true,
          trailing: Chip(
            label: Text(student.isActive ? 'Active' : 'Inactive'),
            avatar: Icon(
              student.isActive
                  ? Icons.check_circle_outline
                  : Icons.pause_circle_outline,
              size: 18,
            ),
          ),
          onTap: () => context.go('/admin/students/${student.id}'),
        );
      },
    );
  }
}
