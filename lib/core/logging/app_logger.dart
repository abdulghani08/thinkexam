import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:logger/logger.dart';

/// Application logger wrapper
/// Provides centralized logging configuration for the app
class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
      noBoxingByDefault: false,
    ),
    level: Level.debug,
    filter: ProductionFilter(),
  );

  static Logger get instance => _logger;

  /// Debug log
  static void d(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Info log
  static void i(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Warning log
  static void w(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Error log
  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Verbose log
  static void v(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error: error, stackTrace: stackTrace);
  }

  /// WTF log (What a Terrible Failure)
  static void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.wtf(message, error: error, stackTrace: stackTrace);
  }
}

/// Custom filter to control log output based on environment
class ProductionFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // In release mode, only log warnings and errors
    if (kReleaseMode) {
      return event.level.index >= Level.warning.index;
    }
    // In debug mode, log everything
    return true;
  }
}
