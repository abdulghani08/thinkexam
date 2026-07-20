import 'package:flutter/material.dart';

/// Empty state widget
/// Used when there is no data to display
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final Widget? action;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[const SizedBox(height: 24), action!],
          ],
        ),
      ),
    );
  }
}

/// Pre-configured empty states for common scenarios
class EmptyStates {
  EmptyStates._();

  static Widget noData({Widget? action}) {
    return EmptyState(
      icon: Icons.inbox_outlined,
      title: 'No Data',
      message: 'There is no data to display',
      action: action,
    );
  }

  static Widget noExams({Widget? action}) {
    return EmptyState(
      icon: Icons.quiz_outlined,
      title: 'No Exams',
      message: 'There are no exams available',
      action: action,
    );
  }

  static Widget noStudents({Widget? action}) {
    return EmptyState(
      icon: Icons.people_outline,
      title: 'No Students',
      message: 'There are no students registered',
      action: action,
    );
  }

  static Widget noResults({Widget? action}) {
    return EmptyState(
      icon: Icons.assessment_outlined,
      title: 'No Results',
      message: 'There are no results to display',
      action: action,
    );
  }

  static Widget noHistory({Widget? action}) {
    return EmptyState(
      icon: Icons.history_outlined,
      title: 'No History',
      message: 'You have not taken any exams yet',
      action: action,
    );
  }
}
