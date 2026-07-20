import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../providers/admin/subject_provider.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/loading_indicator.dart';

class SubjectListPage extends ConsumerStatefulWidget {
  const SubjectListPage({super.key});

  @override
  ConsumerState<SubjectListPage> createState() => _SubjectListPageState();
}

class _SubjectListPageState extends ConsumerState<SubjectListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(subjectListProvider.notifier).loadSubjects());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(subjectListProvider);
    final notifier = ref.read(subjectListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(RouteNames.adminSubjectCreate),
        icon: const Icon(Icons.add),
        label: const Text('Add Subject'),
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
                  notifier.searchSubjects(query);
                } else {
                  notifier.loadSubjects(refresh: true);
                }
              },
              decoration: InputDecoration(
                labelText: 'Search subjects',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear search',
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          notifier.loadSubjects(refresh: true);
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
    SubjectListState state,
    SubjectListNotifier notifier,
  ) {
    if (state.status == SubjectListStatus.initial ||
        state.status == SubjectListStatus.loading) {
      return const LoadingIndicator(message: 'Loading subjects...');
    }

    if (state.status == SubjectListStatus.error) {
      return ErrorState(
        title: 'Unable to load subjects',
        message: state.errorMessage,
        onRetry: () => notifier.loadSubjects(refresh: true),
      );
    }

    if (state.subjects.isEmpty) {
      return EmptyState(
        icon: Icons.book_outlined,
        title: state.currentQuery != null && state.currentQuery!.isNotEmpty
            ? 'No subjects found'
            : 'No subjects yet',
        action: state.currentQuery == null || state.currentQuery!.isEmpty
            ? ElevatedButton.icon(
                onPressed: () => context.go(RouteNames.adminSubjectCreate),
                icon: const Icon(Icons.add),
                label: const Text('Add Subject'),
              )
            : null,
      );
    }

    return ListView.separated(
      itemCount: state.subjects.length + (state.hasMore ? 1 : 0),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        if (index == state.subjects.length) {
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

        final subject = state.subjects[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 6,
          ),
          leading: CircleAvatar(
            child: Text(subject.subjectName[0].toUpperCase()),
          ),
          title: Text(subject.subjectName),
          subtitle: subject.description != null
              ? Text(subject.description!)
              : null,
          onTap: () => context.go('/admin/subjects/${subject.id}'),
        );
      },
    );
  }
}
