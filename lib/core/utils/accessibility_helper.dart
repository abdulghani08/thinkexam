import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class AccessibilityHelper {
  static Widget addSemantics({
    required Widget child,
    String? label,
    String? hint,
    bool? button,
    bool? checked,
    bool? selected,
    bool? enabled,
    bool? inMutuallyExclusiveGroup,
    bool? isHeader,
    bool? isTextField,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    bool? excludeFromSemantics,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      button: button,
      checked: checked,
      selected: selected,
      enabled: enabled,
      inMutuallyExclusiveGroup: inMutuallyExclusiveGroup,
      header: isHeader,
      textField: isTextField,
      onTap: onTap,
      onLongPress: onLongPress,
      excludeSemantics: excludeFromSemantics ?? false,
      child: child,
    );
  }

  static Widget addFocus({
    required Widget child,
    FocusNode? focusNode,
    bool autofocus = false,
    bool requestFocus = false,
    Function(bool)? onFocusChange,
  }) {
    return Focus(
      focusNode: focusNode,
      autofocus: autofocus,
      onKeyEvent: (node, event) {
        if (requestFocus) {
          node.requestFocus();
        }
        return KeyEventResult.ignored;
      },
      onFocusChange: onFocusChange,
      child: child,
    );
  }

  static String getScreenReaderText({
    required String title,
    String? subtitle,
    String? description,
    String? status,
  }) {
    final buffer = StringBuffer();
    buffer.write(title);
    
    if (subtitle != null) {
      buffer.write('. $subtitle');
    }
    
    if (description != null) {
      buffer.write('. $description');
    }
    
    if (status != null) {
      buffer.write('. Status: $status');
    }
    
    return buffer.toString();
  }

  static String formatNumberForScreenReader(int number) {
    return number.toString();
  }

  static String formatDurationForScreenReader(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    final parts = <String>[];
    
    if (hours > 0) {
      parts.add('$hours hour${hours > 1 ? 's' : ''}');
    }
    
    if (minutes > 0) {
      parts.add('$minutes minute${minutes > 1 ? 's' : ''}');
    }
    
    if (seconds > 0) {
      parts.add('$seconds second${seconds > 1 ? 's' : ''}');
    }
    
    return parts.join(', ');
  }

  static String formatDateForScreenReader(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  static String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return months[month - 1];
  }
}

class AccessibleButton extends StatelessWidget {
  final String label;
  final String? hint;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isPrimary;

  const AccessibleButton({
    super.key,
    required this.label,
    this.hint,
    this.onPressed,
    this.icon,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = isPrimary
        ? ElevatedButton(
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[icon!, const SizedBox(width: 8)],
                Text(label),
              ],
            ),
          )
        : TextButton(
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[icon!, const SizedBox(width: 8)],
                Text(label),
              ],
            ),
          );

    return AccessibilityHelper.addSemantics(
      child: button,
      label: label,
      hint: hint,
      button: true,
      enabled: onPressed != null,
    );
  }
}
