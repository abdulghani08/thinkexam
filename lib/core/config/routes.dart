/// Route path constants
class AppRoutes {
  AppRoutes._();

  // Auth
  static const String login = '/login';

  // Admin
  static const String adminDashboard = '/admin/dashboard';
  static const String adminTeachers = '/admin/teachers';
  static const String adminTeacherCreate = '/admin/teachers/create';
  static const String adminTeacherDetail = '/admin/teachers/:id';
  static const String adminTeacherEdit = '/admin/teachers/:id/edit';
  static const String adminExams = '/admin/exams';
  static const String adminExamCreate = '/admin/exams/create';
  static const String adminExamEdit = '/admin/exams/:id';
  static const String adminStudents = '/admin/students';
  static const String adminClasses = '/admin/classes';
  static const String adminSubjects = '/admin/subjects';
  static const String adminResults = '/admin/results';
  static const String adminSettings = '/admin/settings';

  // Student
  static const String studentDashboard = '/student/dashboard';
  static const String studentExams = '/student/exams';
  static const String studentExamDetail = '/student/exams/:id';
  static const String studentExam = '/student/exams/:id/take';
  static const String studentHistory = '/student/history';
  static const String studentProfile = '/student/profile';

  // Common
  static const String splash = '/';
  static const String notFound = '/404';
}
