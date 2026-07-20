import 'package:flutter/material.dart';

/// Application color palette based on UI/UX specification
class AppColors {
  AppColors._();

  // Primary Colors (Blue)
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryContainer = Color(0xFFBBDEFB);

  // Secondary Colors (Green)
  static const Color secondary = Color(0xFF4CAF50);
  static const Color secondaryLight = Color(0xFF81C784);
  static const Color secondaryDark = Color(0xFF388E3C);
  static const Color secondaryContainer = Color(0xFFC8E6C9);

  // Warning Colors (Orange)
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);

  // Error Colors (Red)
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFC62828);
  static const Color errorContainer = Color(0xFFFFEBEE);

  // Neutral Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color surfaceVariant = Color(0xFFEEEEEE);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF0F0F0);

  // Status Colors
  static const Color success = secondary;
  static const Color info = primary;
  static const Color danger = error;

  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);

  // Exam Specific Colors
  static const Color examActive = success;
  static const Color examDraft = textSecondary;
  static const Color examArchived = textDisabled;
  static const Color examRunning = primary;
  static const Color examCompleted = secondary;
}
