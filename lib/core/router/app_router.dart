import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/providers/auth/auth_provider.dart';
import '../../presentation/pages/auth/login_page.dart';
import '../../presentation/pages/admin/admin_dashboard_page.dart';
import '../../presentation/pages/admin/exam_list_page.dart';
import '../../presentation/pages/admin/exam_detail_page.dart';
import '../../presentation/pages/admin/exam_create_page.dart';
import '../../presentation/pages/admin/class_list_page.dart';
import '../../presentation/pages/admin/class_form_page.dart';
import '../../presentation/pages/admin/subject_list_page.dart';
import '../../presentation/pages/admin/subject_form_page.dart';
import '../../presentation/pages/admin/student_list_page.dart';
import '../../presentation/pages/admin/student_form_page.dart';
import '../../presentation/pages/admin/results_page.dart';
import '../../presentation/pages/admin/question_builder_page.dart';
import '../../presentation/pages/teacher/teacher_detail_page.dart';
import '../../presentation/pages/teacher/teacher_form_page.dart';
import '../../presentation/pages/teacher/teacher_list_page.dart';
import '../../presentation/pages/student/student_dashboard_page.dart';
import '../../presentation/pages/student/student_exam_list_page.dart';
import '../../presentation/pages/student/student_exam_detail_page.dart';
import '../../presentation/pages/student/exam_taking_page.dart';
import '../../presentation/pages/student/student_history_page.dart';
import '../../presentation/pages/student/student_profile_page.dart';
import 'route_names.dart';

/// Application router configuration with authentication guards
class AppRouter {
  AppRouter._();

  /// GoRouter instance with auth guards
  static GoRouter router(WidgetRef ref) {
    ref.watch(authProvider);
    return GoRouter(
      initialLocation: RouteNames.splash,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final authState = ref.read(authProvider);

        if (authState.status == AuthStatus.initial ||
            authState.status == AuthStatus.loading) {
          return RouteNames.splash;
        }

        final isAuthRoute = state.matchedLocation == RouteNames.login;
        if (!authState.isAuthenticated && !isAuthRoute) {
          return RouteNames.login;
        }

        if (authState.isAuthenticated &&
            (isAuthRoute || state.matchedLocation == RouteNames.splash)) {
          if (authState.isAdmin) {
            return RouteNames.adminDashboard;
          } else if (authState.isStudent) {
            return RouteNames.studentDashboard;
          }
        }

        if (state.matchedLocation.startsWith('/admin') && !authState.isAdmin) {
          return RouteNames.studentDashboard;
        }
        if (state.matchedLocation.startsWith('/student') &&
            !authState.isStudent) {
          return RouteNames.adminDashboard;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: RouteNames.splash,
          name: 'splash',
          builder: (context, state) => const _SplashScreen(),
        ),
        GoRoute(
          path: RouteNames.login,
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        // -- Admin routes --
        GoRoute(
          path: RouteNames.adminDashboard,
          name: 'admin-dashboard',
          builder: (context, state) => const AdminDashboardPage(),
        ),
        GoRoute(
          path: RouteNames.adminTeachers,
          name: 'admin-teachers',
          builder: (context, state) => const TeacherListPage(),
        ),
        GoRoute(
          path: RouteNames.adminTeacherDetail,
          name: 'admin-teacher-detail',
          builder: (context, state) =>
              TeacherDetailPage(teacherId: state.pathParameters['id']!),
        ),
        GoRoute(
          path: RouteNames.adminTeacherCreate,
          name: 'admin-teacher-create',
          builder: (context, state) => const TeacherFormPage(),
        ),
        GoRoute(
          path: RouteNames.adminTeacherEdit,
          name: 'admin-teacher-edit',
          builder: (context, state) =>
              TeacherFormPage(teacherId: state.pathParameters['id']),
        ),
        GoRoute(
          path: RouteNames.adminExams,
          name: 'admin-exams',
          builder: (context, state) => const ExamListPage(),
        ),
        GoRoute(
          path: RouteNames.adminExamDetail,
          name: 'admin-exam-detail',
          builder: (context, state) =>
              ExamDetailPage(examId: state.pathParameters['id']!),
        ),
        GoRoute(
          path: RouteNames.adminExamCreate,
          name: 'admin-exam-create',
          builder: (context, state) => const ExamCreatePage(),
        ),
        GoRoute(
          path: RouteNames.adminExamEdit,
          name: 'admin-exam-edit',
          builder: (context, state) => const _PlaceholderScreen(
            title: 'Edit Exam',
            message: 'Exam editing will be implemented in a future phase',
          ),
        ),
        GoRoute(
          path: RouteNames.adminStudents,
          name: 'admin-students',
          builder: (context, state) => const StudentListPage(),
        ),
        GoRoute(
          path: RouteNames.adminStudentDetail,
          name: 'admin-student-detail',
          builder: (context, state) => const _PlaceholderScreen(
            title: 'Student Detail',
            message: 'Student detail will be implemented in a future phase',
          ),
        ),
        GoRoute(
          path: RouteNames.adminStudentCreate,
          name: 'admin-student-create',
          builder: (context, state) => const StudentFormPage(),
        ),
        GoRoute(
          path: RouteNames.adminResults,
          name: 'admin-results',
          builder: (context, state) => const _PlaceholderScreen(
            title: 'Admin Results',
            message: 'Results list will be implemented in a future phase',
          ),
        ),
        GoRoute(
          path: RouteNames.adminResultDetail,
          name: 'admin-result-detail',
          builder: (context, state) =>
              ResultsPage(examId: state.pathParameters['id']!),
        ),
        GoRoute(
          path: RouteNames.adminSettings,
          name: 'admin-settings',
          builder: (context, state) => const _PlaceholderScreen(
            title: 'Admin Settings',
            message: 'Settings will be implemented in a future phase',
          ),
        ),
        // Admin - Class management
        GoRoute(
          path: RouteNames.adminClasses,
          name: 'admin-classes',
          builder: (context, state) => const ClassListPage(),
        ),
        GoRoute(
          path: RouteNames.adminClassDetail,
          name: 'admin-class-detail',
          builder: (context, state) =>
              ClassFormPage(classId: state.pathParameters['id']),
        ),
        GoRoute(
          path: RouteNames.adminClassCreate,
          name: 'admin-class-create',
          builder: (context, state) => const ClassFormPage(),
        ),
        // Admin - Subject management
        GoRoute(
          path: RouteNames.adminSubjects,
          name: 'admin-subjects',
          builder: (context, state) => const SubjectListPage(),
        ),
        GoRoute(
          path: RouteNames.adminSubjectDetail,
          name: 'admin-subject-detail',
          builder: (context, state) =>
              SubjectFormPage(subjectId: state.pathParameters['id']),
        ),
        GoRoute(
          path: RouteNames.adminSubjectCreate,
          name: 'admin-subject-create',
          builder: (context, state) => const SubjectFormPage(),
        ),
        // Admin - Question builder
        GoRoute(
          path: RouteNames.adminQuestionBuilder,
          name: 'admin-question-builder',
          builder: (context, state) =>
              QuestionBuilderPage(examId: state.pathParameters['id']!),
        ),
        // -- Student routes --
        GoRoute(
          path: RouteNames.studentDashboard,
          name: 'student-dashboard',
          builder: (context, state) => const StudentDashboardPage(),
        ),
        GoRoute(
          path: RouteNames.studentExamList,
          name: 'student-exam-list',
          builder: (context, state) => const StudentExamListPage(),
        ),
        GoRoute(
          path: RouteNames.studentExamDetail,
          name: 'student-exam-detail',
          builder: (context, state) =>
              StudentExamDetailPage(examId: state.pathParameters['id']!),
        ),
        GoRoute(
          path: RouteNames.studentExam,
          name: 'student-exam',
          builder: (context, state) =>
              ExamTakingPage(examId: state.pathParameters['examId']!),
        ),
        GoRoute(
          path: RouteNames.studentHistory,
          name: 'student-history',
          builder: (context, state) => const StudentHistoryPage(),
        ),
        GoRoute(
          path: RouteNames.studentProfile,
          name: 'student-profile',
          builder: (context, state) => const StudentProfilePage(),
        ),
      ],
      errorBuilder: (context, state) => _ErrorScreen(error: state.error),
    );
  }
}

/// Splash screen
class _SplashScreen extends ConsumerStatefulWidget {
  const _SplashScreen();

  @override
  ConsumerState<_SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<_SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}

/// Placeholder screen for unimplemented routes
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  final String message;

  const _PlaceholderScreen({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.construction, size: 64, color: Colors.orange),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Error screen for routing errors
class _ErrorScreen extends StatelessWidget {
  final Exception? error;

  const _ErrorScreen({this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Navigation Error',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                error?.toString() ?? 'An unknown error occurred',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(RouteNames.splash),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
