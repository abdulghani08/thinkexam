/// Application configuration
class AppConfig {
  AppConfig._();

  // Environment
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  static bool get isDevelopment => environment == 'development';
  static bool get isProduction => environment == 'production';
  static bool get isStaging => environment == 'staging';

  // API Configuration (for future use)
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  // Firebase Configuration (loaded from firebase_options.dart)
  // This will be configured in Phase 2
}
