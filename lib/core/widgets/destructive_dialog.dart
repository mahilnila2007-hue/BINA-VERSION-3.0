import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';
import 'accessible_button.dart';

/// Standard confirmation dialog for destructive actions.
/// Designed specifically for elderly post-surgery patients:
/// - Distinct, unambiguous question
/// - Giant Yes / No touch targets (min 64dp, 72dp tall)
/// - High-contrast text and buttons
class DestructiveConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const DestructiveConfirmationDialog({
    super.key,
    this.title = 'Stop session?',
    this.message = 'Your progress so far will be saved.',
    this.confirmLabel = 'Yes, stop',
    this.cancelLabel = 'No, continue',
    required this.onConfirm,
    required this.onCancel,
  });

  static Future<bool?> show(
    BuildContext context, {
    String title = 'Stop session?',
    String message = 'Your progress so far will be saved.',
    String confirmLabel = 'Yes, stop',
    String cancelLabel = 'No, continue',
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => DestructiveConfirmationDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: () => Navigator.of(ctx).pop(true),
        onCancel: () => Navigator.of(ctx).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTokens.radiusCard),
        side: const BorderSide(
          color: AppColors.border,
          width: AppTokens.borderWidthStandard,
        ),
      ),
      contentPadding: const EdgeInsets.all(AppTokens.spacing24),
      title: Text(
        title,
        style: theme.textTheme.headlineMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppTokens.spacing32),
          // Primary action here is to keep exercising / cancel the destruction
          AccessibleButton(
            label: cancelLabel,
            type: AccessibleButtonType.primary,
            icon: Icons.play_arrow_rounded,
            onPressed: onCancel,
          ),
          const SizedBox(height: AppTokens.spacing16),
          // Destructive action is secondary
          AccessibleButton(
            label: confirmLabel,
            type: AccessibleButtonType.destructive,
            icon: Icons.stop_rounded,
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}
