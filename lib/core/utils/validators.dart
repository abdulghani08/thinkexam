/// Common validators for form validation
class Validators {
  Validators._();

  /// Validate email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Validate required field
  static String? validateRequired(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate number
  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final numberRegex = RegExp(r'^\d+$');
    if (!numberRegex.hasMatch(value)) {
      return 'Please enter a valid number';
    }
    return null;
  }

  /// Validate positive number
  static String? validatePositiveNumber(String? value) {
    final numberError = validateNumber(value);
    if (numberError != null) return numberError;

    final number = int.tryParse(value!);
    if (number == null || number <= 0) {
      return 'Please enter a positive number';
    }
    return null;
  }

  static String? validateMinDuration(String? value, {int minMinutes = 5}) {
    final numberError = validatePositiveNumber(value);
    if (numberError != null) return numberError;
    final minutes = int.parse(value!);
    if (minutes < minMinutes) {
      return 'Duration must be at least $minMinutes minutes';
    }
    return null;
  }

  static String? validateSubjectCode(String? value) {
    final requiredError = validateRequired(value, fieldName: 'Subject code');
    if (requiredError != null) return requiredError;
    final codeRegex = RegExp(r'^[A-Za-z0-9_-]{2,20}$');
    if (!codeRegex.hasMatch(value!)) {
      return 'Use 2-20 letters, numbers, dash, or underscore';
    }
    return null;
  }
}
