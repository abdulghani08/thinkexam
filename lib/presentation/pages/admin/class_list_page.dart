import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../providers/admin/class_provider.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/loading_indicator.dart';

class ClassListPage extends ConsumerStatefulWidget {
  const ClassListPage({super.key});

  @override
  ConsumerState<ClassListPage> createState() => _ClassListPageState();
}

class _ClassListPageState extends ConsumerState<ClassListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(classListProvider.notifier).loadClasses());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(classListProvider);
    final notifier = ref.read(classListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(RouteNames.adminClassCreate),
        icon: const Icon(Icons.add),
        label: const Text('Add Class'),
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
                  notifier.searchClasses(query);
                } else {
                  notifier.loadClasses(refresh: true);
                }
              },
              decoration: InputDecoration(
                labelText: 'Search classes',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear search',
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          notifier.loadClasses(refresh: true);
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
    ClassListState state,
    ClassListNotifier notifier,
  ) {
    if (state.status == ClassListStatus.initial ||
        state.status == ClassListStatus.loading) {
      return const LoadingIndicator(message: 'Loading classes...');
    }

    if (state.status == ClassListStatus.error) {
      return ErrorState(
        title: 'Unable to load classes',
        message: state.errorMessage,
        onRetry: () => notifier.loadClasses(refresh: true),
      );
    }

    if (state.classes.isEmpty) {
      return EmptyState(
        icon: Icons.class_outlined,
        title: state.currentQuery != null && state.currentQuery!.isNotEmpty
            ? 'No classes found'
            : 'No classes yet',
        action: state.currentQuery == null || state.currentQuery!.isEmpty
            ? ElevatedButton.icon(
                onPressed: () => context.go(RouteNames.adminClassCreate),
                icon: const Icon(Icons.add),
                label: const Text('Add Class'),
              )
            : null,
      );
    }

    return ListView.separated(
      itemCount: state.classes.length + (state.hasMore ? 1 : 0),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        if (index == state.classes.length) {
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

        final classRoom = state.classes[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 6,
          ),
          leading: CircleAvatar(
            child: Text('Grade ${classRoom.grade}'),
          ),
          title: Text(classRoom.className),
          subtitle: classRoom.homeroomTeacherId != null
              ? Text('Homeroom: ${classRoom.homeroomTeacherId}')
              : null,
          onTap: () => context.go('/admin/classes/${classRoom.id}'),
        );
      },
    );
  }
}
