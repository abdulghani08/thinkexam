import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/teacher.dart';
import '../../providers/teacher/teacher_provider.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/loading_indicator.dart';

class TeacherDetailPage extends ConsumerWidget {
  final String teacherId;
  const TeacherDetailPage({super.key, required this.teacherId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher details'),
        actions: [
          IconButton(
            tooltip: 'Edit teacher',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.go('/admin/teachers/$teacherId/edit'),
          ),
        ],
      ),
      body: ref
          .watch(teacherDetailProvider(teacherId))
          .when(
            loading: () =>
                const LoadingIndicator(message: 'Loading teacher...'),
            error: (error, _) => ErrorState(
              title: 'Unable to load teacher',
              message: error.toString(),
            ),
            data: (teacher) => _TeacherDetails(
              teacher: teacher,
              onDelete: () => _confirmDelete(context, ref, teacher),
            ),
          ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Teacher teacher,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete teacher?'),
        content: Text(
          'Remove ${teacher.fullName} from the authorized teachers list?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    final error = await ref
        .read(teacherListProvider.notifier)
        .deleteTeacher(teacher.id);
    if (!context.mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    context.go(RouteNames.adminTeachers);
  }
}

class _TeacherDetails extends StatelessWidget {
  final Teacher teacher;
  final VoidCallback onDelete;
  const _TeacherDetails({required this.teacher, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Center(
          child: CircleAvatar(
            radius: 44,
            backgroundImage: teacher.photoUrl?.isNotEmpty == true
                ? NetworkImage(teacher.photoUrl!)
                : null,
            child: teacher.photoUrl?.isNotEmpty == true
                ? null
                : const Icon(Icons.person, size: 44),
          ),
        ),
        const SizedBox(height: 24),
        _DetailRow(label: 'Name', value: teacher.fullName),
        _DetailRow(label: 'Email', value: teacher.email),
        _DetailRow(label: 'Firebase User ID', value: teacher.id),
        _DetailRow(label: 'Role', value: teacher.role),
        _DetailRow(
          label: 'Status',
          value: teacher.isActive ? 'Active' : 'Inactive',
        ),
        _DetailRow(
          label: 'Created',
          value: teacher.createdAt == null
              ? '-'
              : Formatters.formatDateTime(teacher.createdAt!),
        ),
        _DetailRow(
          label: 'Updated',
          value: teacher.updatedAt == null
              ? '-'
              : Formatters.formatDateTime(teacher.updatedAt!),
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline),
          label: const Text('Delete teacher'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(label, style: Theme.of(context).textTheme.labelLarge),
        ),
        Expanded(child: SelectableText(value)),
      ],
    ),
  );
}
