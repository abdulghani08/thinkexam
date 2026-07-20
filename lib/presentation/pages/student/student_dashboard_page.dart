import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/exam.dart';
import '../../../domain/entities/student.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/student/student_dashboard_provider.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_state.dart';

class StudentDashboardPage extends ConsumerStatefulWidget {
  const StudentDashboardPage({super.key});

  @override
  ConsumerState<StudentDashboardPage> createState() =>
      _StudentDashboardPageState();
}

class _StudentDashboardPageState extends ConsumerState<StudentDashboardPage> {
  @override
  void initState() {
    super.initState();
    final authState = ref.read(authProvider);
    final studentId = authState.user?.id ?? '';

    Future.microtask(
      () =>
          ref.read(studentDashboardProvider.notifier).loadDashboard(studentId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studentDashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              AppConstants.appLogo,
              width: 32,
              height: 32,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.quiz, size: 32);
              },
            ),
            const SizedBox(width: 12),
            const Text('Dashboard'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.go(RouteNames.studentProfile),
          ),
        ],
      ),
      body: _buildContent(context, state),
    );
  }

  Widget _buildContent(BuildContext context, StudentDashboardState state) {
    if (state.status == StudentDashboardStatus.initial ||
        state.status == StudentDashboardStatus.loading) {
      return const LoadingIndicator(message: 'Loading dashboard...');
    }

    if (state.status == StudentDashboardStatus.error) {
      return ErrorState(
        title: 'Unable to load dashboard',
        message: state.errorMessage,
        onRetry: () {
          final studentId = ref.read(authProvider).user?.id ?? '';
          ref.read(studentDashboardProvider.notifier).loadDashboard(studentId);
        },
      );
    }

    final student = state.student;
    if (student == null) {
      return const Center(child: Text('Student not found'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(student),
          const SizedBox(height: 16),
          _buildStatsCard(),
          const SizedBox(height: 16),
          _buildAvailableExamsSection(context, state.availableExams),
          const SizedBox(height: 16),
          _buildRecentActivitySection(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(Student student) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: student.photoUrl?.isNotEmpty == true
                  ? NetworkImage(student.photoUrl!)
                  : null,
              child: student.photoUrl?.isNotEmpty == true
                  ? null
                  : const Icon(Icons.person, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${student.fullName}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    student.email,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Available Exams', '0', Icons.quiz, Colors.blue),
            _buildStatItem('Completed', '0', Icons.check_circle, Colors.green),
            _buildStatItem(
              'Average Score',
              '0',
              Icons.analytics,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, size: 32, color: color),
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

  Widget _buildAvailableExamsSection(BuildContext context, List<Exam> exams) {
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
                  'Available Exams',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () => context.go(RouteNames.studentExamList),
                  child: const Text('View All'),
                ),
              ],
            ),
            const Divider(),
            if (exams.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('No available exams'),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: exams.length > 3 ? 3 : exams.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final exam = exams[index];
                  return ListTile(
                    title: Text(exam.title),
                    subtitle: Text('Duration: ${exam.durationMinutes} minutes'),
                    trailing: ElevatedButton(
                      onPressed: () => context.go('/student/exams/${exam.id}'),
                      child: const Text('Start'),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.history, color: Colors.grey),
              title: Text('No recent activity'),
              subtitle: Text('Your exam history will appear here'),
            ),
          ],
        ),
      ),
    );
  }
}
