import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/student.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/student/student_dashboard_provider.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_state.dart';

class StudentProfilePage extends ConsumerStatefulWidget {
  const StudentProfilePage({super.key});

  @override
  ConsumerState<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends ConsumerState<StudentProfilePage> {
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
      appBar: AppBar(title: const Text('Profile')),
      body: _buildContent(context, state),
    );
  }

  Widget _buildContent(BuildContext context, StudentDashboardState state) {
    if (state.status == StudentDashboardStatus.initial ||
        state.status == StudentDashboardStatus.loading) {
      return const LoadingIndicator(message: 'Loading profile...');
    }

    if (state.status == StudentDashboardStatus.error) {
      return ErrorState(
        title: 'Unable to load profile',
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
          _buildProfileCard(student),
          const SizedBox(height: 16),
          _buildInfoCard(student),
          const SizedBox(height: 16),
          _buildStatsCard(),
          const SizedBox(height: 16),
          _buildSettingsCard(context),
        ],
      ),
    );
  }

  Widget _buildProfileCard(Student student) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundImage: student.photoUrl?.isNotEmpty == true
                  ? NetworkImage(student.photoUrl!)
                  : null,
              child: student.photoUrl?.isNotEmpty == true
                  ? null
                  : const Icon(Icons.person, size: 48),
            ),
            const SizedBox(height: 16),
            Text(
              student.fullName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              student.email,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            if (student.studentNumber != null) ...[
              const SizedBox(height: 4),
              Text(
                'ID: ${student.studentNumber}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(Student student) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Information', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            _buildInfoRow(Icons.email, 'Email', student.email),
            const SizedBox(height: 12),
            if (student.studentNumber != null)
              _buildInfoRow(Icons.badge, 'Student ID', student.studentNumber!),
            if (student.classId != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow(Icons.class_, 'Class', student.classId!),
            ],
            const SizedBox(height: 12),
            _buildInfoRow(
              Icons.calendar_today,
              'Joined',
              student.createdAt != null
                  ? Formatters.formatDate(student.createdAt!)
                  : 'Unknown',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value)),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Statistics', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Exams Taken', '0', Icons.quiz),
                _buildStatItem('Average Score', '0', Icons.analytics),
                _buildStatItem('Rank', 'N/A', Icons.emoji_events),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.blue),
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

  Widget _buildSettingsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Implement edit profile
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Implement notifications settings
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement logout
              context.pop();
              context.go(RouteNames.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
