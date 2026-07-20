import 'package:flutter/material.dart';

enum AppChipVariant { primary, secondary, success, warning, danger, info }

/// Standard chip widget for consistent UI
class AppChip extends StatelessWidget {
  final String label;
  final AppChipVariant variant;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool outlined;

  const AppChip({
    super.key,
    required this.label,
    this.variant = AppChipVariant.primary,
    this.icon,
    this.onTap,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    Color getBackgroundColor() {
      if (outlined) return Colors.transparent;

      switch (variant) {
        case AppChipVariant.primary:
          return Theme.of(context).colorScheme.primary.withOpacity(0.1);
        case AppChipVariant.secondary:
          return Colors.grey[200]!;
        case AppChipVariant.success:
          return Colors.green.withOpacity(0.1);
        case AppChipVariant.warning:
          return Colors.orange.withOpacity(0.1);
        case AppChipVariant.danger:
          return Colors.red.withOpacity(0.1);
        case AppChipVariant.info:
          return Colors.blue.withOpacity(0.1);
      }
    }

    Color getForegroundColor() {
      switch (variant) {
        case AppChipVariant.primary:
          return Theme.of(context).colorScheme.primary;
        case AppChipVariant.secondary:
          return Colors.grey[700]!;
        case AppChipVariant.success:
          return Colors.green;
        case AppChipVariant.warning:
          return Colors.orange;
        case AppChipVariant.danger:
          return Colors.red;
        case AppChipVariant.info:
          return Colors.blue;
      }
    }

    Color getBorderColor() {
      return outlined ? getForegroundColor() : Colors.transparent;
    }

    final chip = Chip(
      label: Text(label),
      avatar: icon != null ? Icon(icon, size: 18) : null,
      backgroundColor: getBackgroundColor(),
      labelStyle: TextStyle(
        color: getForegroundColor(),
        fontWeight: FontWeight.w500,
      ),
      side: BorderSide(color: getBorderColor()),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    );

    if (onTap != null) {
      return ActionChip(
        label: Text(label),
        avatar: icon != null ? Icon(icon, size: 18) : null,
        backgroundColor: getBackgroundColor(),
        labelStyle: TextStyle(
          color: getForegroundColor(),
          fontWeight: FontWeight.w500,
        ),
        side: BorderSide(color: getBorderColor()),
        onPressed: onTap,
      );
    }

    return chip;
  }
}
