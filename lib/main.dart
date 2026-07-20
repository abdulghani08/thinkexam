import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/di/auth_providers.dart';
import 'core/di/firebase_providers.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/logging/app_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // NOTE: This requires firebase_options.dart to be configured
  // Run: flutterfire configure or manually create firebase_options.dart
  try {
    await FirebaseProviders.initialize();
    AppLogger.i('Firebase initialized successfully');
  } catch (e) {
    AppLogger.e('Firebase initialization failed: $e');
    // Continue without Firebase for development
  }

  AppLogger.i('Starting Easy Exam v${AppConstants.appVersion}');

  runApp(const ProviderScope(child: EasyExamApp()));
}

class EasyExamApp extends ConsumerWidget {
  const EasyExamApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router(ref),
    );
  }
}
