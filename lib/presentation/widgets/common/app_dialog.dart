import 'package:flutter/material.dart';

/// Standard dialog widget for consistent UI
class AppDialog extends StatelessWidget {
  final String title;
  final String? content;
  final String? primaryActionLabel;
  final String? secondaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final Widget? customContent;

  const AppDialog({
    super.key,
    required this.title,
    this.content,
    this.primaryActionLabel,
    this.secondaryActionLabel,
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.customContent,
  });

  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String title,
    String? content,
    String primaryLabel = 'Confirm',
    String secondaryLabel = 'Cancel',
    bool isDangerous = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        content: content,
        primaryActionLabel: primaryLabel,
        secondaryActionLabel: secondaryLabel,
        onPrimaryAction: () => Navigator.pop(context, true),
        onSecondaryAction: () => Navigator.pop(context, false),
      ),
    );
  }

  static Future<void> showInfoDialog(
    BuildContext context, {
    required String title,
    String? content,
    String primaryLabel = 'OK',
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        content: content,
        primaryActionLabel: primaryLabel,
        onPrimaryAction: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: customContent ?? (content != null ? Text(content!) : null),
      actions: [
        if (secondaryActionLabel != null)
          TextButton(
            onPressed: onSecondaryAction,
            child: Text(secondaryActionLabel!),
          ),
        if (primaryActionLabel != null)
          ElevatedButton(
            onPressed: onPrimaryAction,
            child: Text(primaryActionLabel!),
          ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
