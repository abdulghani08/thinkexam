/// Route names constants
/// Used for navigation throughout the app
class RouteNames {
  RouteNames._();

  // Auth routes
  static const String login = '/login';
  static const String splash = '/';

  // Admin routes
  static const String adminDashboard = '/admin/dashboard';
  static const String adminTeachers = '/admin/teachers';
  static const String adminTeacherDetail = '/admin/teachers/:id';
  static const String adminTeacherCreate = '/admin/teachers/create';
  static const String adminTeacherEdit = '/admin/teachers/:id/edit';
  static const String adminExams = '/admin/exams';
  static const String adminExamDetail = '/admin/exams/:id';
  static const String adminExamCreate = '/admin/exams/create';
  static const String adminExamEdit = '/admin/exams/:id/edit';
  static const String adminStudents = '/admin/students';
  static const String adminStudentDetail = '/admin/students/:id';
  static const String adminStudentCreate = '/admin/students/create';
  static const String adminResults = '/admin/results';
  static const String adminResultDetail = '/admin/results/:id';
  static const String adminSettings = '/admin/settings';
  static const String adminStudentList = adminStudents;
  static const String adminClassList = adminClasses;
  static const String adminSubjectList = adminSubjects;

  // Admin - Class management
  static const String adminClasses = '/admin/classes';
  static const String adminClassDetail = '/admin/classes/:id';
  static const String adminClassCreate = '/admin/classes/create';

  // Admin - Subject management
  static const String adminSubjects = '/admin/subjects';
  static const String adminSubjectDetail = '/admin/subjects/:id';
  static const String adminSubjectCreate = '/admin/subjects/create';

  // Admin - Question builder
  static const String adminQuestionBuilder = '/admin/exams/:id/questions';

  // Student routes
  static const String studentDashboard = '/student/dashboard';
  static const String studentExamList = '/student/exams';
  static const String studentExamDetail = '/student/exams/:id';
  static const String studentExam = '/student/exam/:examId';
  static const String studentHistory = '/student/history';
  static const String studentProfile = '/student/profile';
}
