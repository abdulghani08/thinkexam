import 'package:intl/intl.dart';

/// Common formatters for data formatting
class Formatters {
  Formatters._();

  /// Format date to readable string
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Format date and time to readable string
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
  }

  /// Format time to readable string
  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  /// Format duration in minutes to readable string
  static String formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;

    if (hours > 0) {
      return '${hours}h ${mins}m';
    }
    return '${mins}m';
  }

  /// Format number with commas
  static String formatNumber(int number) {
    return NumberFormat.decimalPattern().format(number);
  }

  /// Format score to percentage
  static String formatPercentage(double score) {
    return '${score.toStringAsFixed(1)}%';
  }
}
