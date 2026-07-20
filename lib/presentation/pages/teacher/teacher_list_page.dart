import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../providers/teacher/teacher_provider.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/loading_indicator.dart';

class TeacherListPage extends ConsumerStatefulWidget {
  const TeacherListPage({super.key});

  @override
  ConsumerState<TeacherListPage> createState() => _TeacherListPageState();
}

class _TeacherListPageState extends ConsumerState<TeacherListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(teacherListProvider.notifier).loadTeachers(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherListProvider);
    final notifier = ref.read(teacherListProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Teachers')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(RouteNames.adminTeacherCreate),
        icon: const Icon(Icons.person_add_outlined),
        label: const Text('Add Teacher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (query) => notifier.loadTeachers(query: query),
              decoration: InputDecoration(
                labelText: 'Search teachers',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear search',
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          notifier.loadTeachers();
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
    TeacherListState state,
    TeacherListNotifier notifier,
  ) {
    if (state.status == TeacherListStatus.initial ||
        state.status == TeacherListStatus.loading) {
      return const LoadingIndicator(message: 'Loading teachers...');
    }
    if (state.status == TeacherListStatus.error) {
      return ErrorState(
        title: 'Unable to load teachers',
        message: state.errorMessage,
        onRetry: () => notifier.loadTeachers(query: state.query),
      );
    }
    if (state.teachers.isEmpty) {
      return EmptyState(
        icon: Icons.people_outline,
        title: state.query.isEmpty ? 'No teachers yet' : 'No teachers found',
        action: state.query.isEmpty
            ? ElevatedButton.icon(
                onPressed: () => context.go(RouteNames.adminTeacherCreate),
                icon: const Icon(Icons.person_add_outlined),
                label: const Text('Add Teacher'),
              )
            : null,
      );
    }
    return ListView.separated(
      itemCount: state.teachers.length + (state.hasMore ? 1 : 0),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        if (index == state.teachers.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: state.isLoadingMore
                  ? const SmallLoadingIndicator()
                  : OutlinedButton.icon(
                      onPressed: notifier.loadMore,
                      icon: const Icon(Icons.expand_more),
                      label: const Text('Load more'),
                    ),
            ),
          );
        }
        final teacher = state.teachers[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 6,
          ),
          leading: CircleAvatar(
            backgroundImage: teacher.photoUrl?.isNotEmpty == true
                ? NetworkImage(teacher.photoUrl!)
                : null,
            child: teacher.photoUrl?.isNotEmpty == true
                ? null
                : const Icon(Icons.person),
          ),
          title: Text(teacher.fullName),
          subtitle: Text(
            '${teacher.email}\nCreated ${teacher.createdAt == null ? '-' : Formatters.formatDate(teacher.createdAt!)}',
          ),
          isThreeLine: true,
          trailing: Chip(
            label: Text(teacher.isActive ? 'Active' : 'Inactive'),
            avatar: Icon(
              teacher.isActive
                  ? Icons.check_circle_outline
                  : Icons.pause_circle_outline,
              size: 18,
            ),
          ),
          onTap: () => context.go('/admin/teachers/${teacher.id}'),
        );
      },
    );
  }
}
