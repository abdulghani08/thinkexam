import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/route_names.dart';
import '../../../domain/entities/dashboard_summary.dart';
import '../../providers/admin/dashboard_provider.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_state.dart';

class AdminDashboardPage extends ConsumerStatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  ConsumerState<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends ConsumerState<AdminDashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(dashboardProvider.notifier).loadSummary());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);

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
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(dashboardProvider.notifier).loadSummary(),
          ),
        ],
      ),
      body: _buildContent(context, state),
    );
  }

  Widget _buildContent(BuildContext context, DashboardState state) {
    if (state.status == DashboardStatus.initial ||
        state.status == DashboardStatus.loading) {
      return const LoadingIndicator(message: 'Loading dashboard...');
    }

    if (state.status == DashboardStatus.error) {
      return ErrorState(
        title: 'Unable to load dashboard',
        message: state.errorMessage,
        onRetry: () => ref.read(dashboardProvider.notifier).loadSummary(),
      );
    }

    final summary = state.summary;
    if (summary == null) {
      return const Center(child: Text('No data available'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsGrid(summary),
          const SizedBox(height: 24),
          _buildQuickActions(context),
          const SizedBox(height: 24),
          _buildRecentActivity(context),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(DashboardSummary summary) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildStatCard(
          'Total Exams',
          summary.totalExams.toString(),
          Icons.quiz,
          Colors.blue,
        ),
        _buildStatCard(
          'Active Exams',
          summary.activeExams.toString(),
          Icons.play_circle,
          Colors.green,
        ),
        _buildStatCard(
          'Total Students',
          summary.totalStudents.toString(),
          Icons.people,
          Colors.orange,
        ),
        _buildStatCard(
          'Total Classes',
          summary.totalClasses.toString(),
          Icons.class_,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildActionButton(
                  context,
                  'Create Exam',
                  Icons.add_circle,
                  () => context.go(RouteNames.adminExamCreate),
                ),
                _buildActionButton(
                  context,
                  'Manage Students',
                  Icons.people,
                  () => context.go(RouteNames.adminStudents),
                ),
                _buildActionButton(
                  context,
                  'Manage Classes',
                  Icons.class_,
                  () => context.go(RouteNames.adminClasses),
                ),
                _buildActionButton(
                  context,
                  'Manage Subjects',
                  Icons.book,
                  () => context.go(RouteNames.adminSubjects),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
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
            const SizedBox(height: 16),
            const ListTile(
              leading: Icon(Icons.quiz, color: Colors.blue),
              title: Text('No recent activity'),
              subtitle: Text('Activity will appear here'),
            ),
          ],
        ),
      ),
    );
  }
}
