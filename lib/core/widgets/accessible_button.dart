import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';

enum AccessibleButtonType {
  primary, // Reserved for single primary action (Accent color)
  secondary, // For secondary navigation or alternative actions
  destructive, // For stopping / cancelling session
  subtle,
}

/// An accessibility-first button engineered for elderly users.
/// Guarantees:
/// - 72dp height for primary buttons (minimum 64dp touch target)
/// - Generous touch bounds (expands to full width by default)
/// - Integrated tactile haptic feedback (HapticFeedback.lightImpact)
/// - TalkBack / screen-reader accessibility labels
class AccessibleButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AccessibleButtonType type;
  final String? semanticLabel;
  final bool isLoading;

  const AccessibleButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.type = AccessibleButtonType.primary,
    this.semanticLabel,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null && !isLoading;

    Color backgroundColor;
    Color foregroundColor;
    BorderSide? borderSide;

    switch (type) {
      case AccessibleButtonType.primary:
        backgroundColor = isEnabled ? AppColors.accent : AppColors.disabledBackground;
        foregroundColor = isEnabled ? AppColors.onAccent : AppColors.onDisabled;
        break;
      case AccessibleButtonType.secondary:
        backgroundColor = isEnabled ? AppColors.surface : AppColors.disabledBackground;
        foregroundColor = isEnabled ? AppColors.primary : AppColors.onDisabled;
        borderSide = BorderSide(
          color: isEnabled ? AppColors.primary : AppColors.disabledBackground,
          width: AppTokens.borderWidthStandard,
        );
        break;
      case AccessibleButtonType.destructive:
        backgroundColor = isEnabled ? AppColors.error : AppColors.disabledBackground;
        foregroundColor = isEnabled ? AppColors.onError : AppColors.onDisabled;
        break;
      case AccessibleButtonType.subtle:
        backgroundColor = isEnabled ? AppColors.surfaceContainer : AppColors.disabledBackground;
        foregroundColor = isEnabled ? AppColors.textPrimary : AppColors.onDisabled;
        break;
    }

    final effectiveHeight = type == AccessibleButtonType.primary
        ? AppTokens.primaryButtonHeight
        : AppTokens.secondaryButtonHeight;

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: semanticLabel ?? label,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: AppTokens.minTouchTarget,
          minWidth: AppTokens.minTouchTarget,
        ),
        child: SizedBox(
          width: double.infinity,
          height: effectiveHeight,
          child: ElevatedButton(
            onPressed: isEnabled
                ? () {
                    HapticFeedback.mediumImpact();
                    onPressed!();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              elevation: isEnabled ? 2 : 0,
              side: borderSide,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTokens.radiusButton),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppTokens.spacing24,
                vertical: AppTokens.spacing16,
              ),
            ),
            child: isLoading
                ? SizedBox(
                    height: 28,
                    width: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          size: AppTokens.iconSizeMedium,
                          color: foregroundColor,
                        ),
                        const SizedBox(width: AppTokens.spacing12),
                      ],
                      Flexible(
                        child: Text(
                          label,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: foregroundColor,
                            fontSize: AppTokens.fontBodyLarge,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
