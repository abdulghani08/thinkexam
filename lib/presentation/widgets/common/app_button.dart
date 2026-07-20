import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, outline, danger }

/// Standard button widget for consistent UI
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool fullWidth;
  final bool isLoading;
  final bool disabled;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = disabled || isLoading || onPressed == null;

    ButtonStyle getButtonStyle() {
      switch (variant) {
        case AppButtonVariant.primary:
          return ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey[300],
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          );
        case AppButtonVariant.secondary:
          return ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.grey[800],
            disabledBackgroundColor: Colors.grey[100],
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          );
        case AppButtonVariant.outline:
          return OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            disabledForegroundColor: Colors.grey[400],
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(
              color: isDisabled ? Colors.grey[300]! : Theme.of(context).colorScheme.primary,
            ),
          );
        case AppButtonVariant.danger:
          return ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey[300],
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          );
      }
    }

    Widget buttonChild() {
      if (isLoading) {
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      }

      if (icon != null) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(label),
          ],
        );
      }

      return Text(label);
    }

    final button = variant == AppButtonVariant.outline
        ? OutlinedButton(
            onPressed: isDisabled ? null : onPressed,
            style: getButtonStyle(),
            child: buttonChild(),
          )
        : ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: getButtonStyle(),
            child: buttonChild(),
          );

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
