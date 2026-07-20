/// Application-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Think Exam';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Computer Based Test Platform for Elementary Schools';

  // Assets
  static const String appLogo = 'assets/images/logo_thinkexam.png';

  // Roles
  static const String roleAdmin = 'ADMIN';
  static const String roleStudent = 'STUDENT';

  // Exam Status
  static const String examStatusDraft = 'draft';
  static const String examStatusPublished = 'published';
  static const String examStatusArchived = 'archived';

  // Session Status
  static const String sessionStatusReady = 'ready';
  static const String sessionStatusRunning = 'running';
  static const String sessionStatusCompleted = 'completed';

  // Question Types
  static const String questionTypeMultipleChoice = 'multiple_choice';
  static const String questionTypeTrueFalse = 'true_false';
  static const String questionTypeCheckbox = 'checkbox';
  static const String questionTypeShortAnswer = 'short_answer';

  // Violation Threshold
  static const int maxViolations = 3;

  // Timeouts
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration examSyncInterval = Duration(seconds: 10);

  // Pagination
  static const int defaultPageSize = 20;
}
