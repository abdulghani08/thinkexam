import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../logging/app_logger.dart';
import '../../firebase_options.dart';

/// Firebase Providers
/// Provides Firebase instances using Riverpod for dependency injection
/// This follows Clean Architecture by making Firebase instances injectable
class FirebaseProviders {
  FirebaseProviders._();

  /// Firebase Core Provider
  static final firebaseCoreProvider = Provider<FirebaseApp>((ref) {
    throw UnimplementedError(
      'FirebaseCore must be initialized in main() before use',
    );
  });

  /// Firebase Auth Provider
  static final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
    return FirebaseAuth.instance;
  });

  /// Cloud Firestore Provider
  static final firestoreProvider = Provider<FirebaseFirestore>((ref) {
    return FirebaseFirestore.instanceFor(app: Firebase.app(), databaseId: 'default');
  });


  /// Firebase Analytics Provider
  static final analyticsProvider = Provider<FirebaseAnalytics>((ref) {
    return FirebaseAnalytics.instance;
  });

  /// Firebase Crashlytics Provider
  static final crashlyticsProvider = Provider<FirebaseCrashlytics>((ref) {
    return FirebaseCrashlytics.instance;
  });

  /// Firebase Messaging Provider
  static final messagingProvider = Provider<FirebaseMessaging>((ref) {
    return FirebaseMessaging.instance;
  });

  /// Firebase Storage Provider
  static final storageProvider = Provider<FirebaseStorage>((ref) {
    return FirebaseStorage.instance;
  });

  /// Initialize Firebase
  /// This should be called in main() before runApp
  static Future<void> initialize() async {
    try {
      AppLogger.i('Initializing Firebase...');

      // Initialize Firebase Core
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      AppLogger.i('Firebase Core initialized');

      // Initialize Analytics
      final analytics = FirebaseAnalytics.instance;
      await analytics.setAnalyticsCollectionEnabled(true);
      AppLogger.i('Firebase Analytics initialized');

      // Initialize Crashlytics
      final crashlytics = FirebaseCrashlytics.instance;

      // Enable Crashlytics in release mode
      if (kReleaseMode) {
        await crashlytics.setCrashlyticsCollectionEnabled(true);
        FlutterError.onError = (errorDetails) {
          crashlytics.recordError(
            errorDetails.exception,
            errorDetails.stack,
            fatal: true,
          );
        };
      } else {
        await crashlytics.setCrashlyticsCollectionEnabled(false);
      }
      AppLogger.i('Firebase Crashlytics initialized');

      // Initialize Messaging
      final messaging = FirebaseMessaging.instance;

      // Request notification permissions
      final settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      AppLogger.i('Firebase Messaging initialized');
      AppLogger.i('Notification permission: ${settings.authorizationStatus}');

      // Get FCM token
      final token = await messaging.getToken();
      if (token != null) {
        AppLogger.i('FCM Token: $token');
      }

      AppLogger.i('Firebase initialization completed successfully');
    } catch (e, stackTrace) {
      AppLogger.e(
        'Firebase initialization failed',
        e,
        stackTrace,
      );

      rethrow;
    }
  }
}
