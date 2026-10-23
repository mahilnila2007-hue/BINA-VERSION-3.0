import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';

enum StatusBadgeType {
  correct, // Correct rep (Check icon + "Good")
  adjust, // Adjust posture (Arrow icon + "Adjust")
  rest, // Rest / unsafe / pause (Octagon icon + "Rest")
  info, // General cue / tip
}

/// Accessible status badge pairing icon + word + color.
/// Adheres strictly to the rule: "Never use color alone: pair every status color with an icon and a word".
class StatusBadge extends StatelessWidget {
  final StatusBadgeType type;
  final String label;
  final String? customSubLabel;
  final bool large;

  const StatusBadge({
    super.key,
    required this.type,
    required this.label,
    this.customSubLabel,
    this.large = false,
  });

  factory StatusBadge.good({String label = 'Good'}) {
    return StatusBadge(
      type: StatusBadgeType.correct,
      label: label,
    );
  }

  factory StatusBadge.adjust({required String label}) {
    return StatusBadge(
      type: StatusBadgeType.adjust,
      label: label,
    );
  }

  factory StatusBadge.rest({String label = 'Rest now'}) {
    return StatusBadge(
      type: StatusBadgeType.rest,
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;
    Color borderColor;
    IconData icon;

    switch (type) {
      case StatusBadgeType.correct:
        backgroundColor = AppColors.successContainer;
        foregroundColor = AppColors.onSuccessContainer;
        borderColor = AppColors.success;
        icon = Icons.check_circle_rounded;
        break;
      case StatusBadgeType.adjust:
        backgroundColor = AppColors.warningContainer;
        foregroundColor = AppColors.onWarningContainer;
        borderColor = AppColors.warning;
        icon = Icons.arrow_upward_rounded;
        break;
      case StatusBadgeType.rest:
        backgroundColor = AppColors.errorContainer;
        foregroundColor = AppColors.onErrorContainer;
        borderColor = AppColors.error;
        icon = Icons.stop_circle_rounded;
        break;
      case StatusBadgeType.info:
        backgroundColor = AppColors.secondaryContainer;
        foregroundColor = AppColors.onSecondaryContainer;
        borderColor = AppColors.secondary;
        icon = Icons.info_rounded;
        break;
    }

    final fontSize = large ? AppTokens.fontHeading3 : AppTokens.fontBodyDefault;
    final iconSize = large ? AppTokens.iconSizeMedium : AppTokens.iconSizeSmall;

    return Semantics(
      container: true,
      label: 'Status: $label',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: large ? AppTokens.spacing20 : AppTokens.spacing16,
          vertical: large ? AppTokens.spacing12 : AppTokens.spacing8,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppTokens.radiusBadge),
          border: Border.all(
            color: borderColor,
            width: AppTokens.borderWidthStandard,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: foregroundColor,
            ),
            const SizedBox(width: AppTokens.spacing8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
