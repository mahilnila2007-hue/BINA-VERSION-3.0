import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'design_tokens.dart';

/// Elderly-First Typography System.
/// Strict rules enforced:
/// - Body text: minimum 20sp
/// - Headings: 28-34sp
/// - Giant counters: 96sp+
/// - Generous line-height and letter-spacing for visual clarity and presbyopia
class AppTypography {
  AppTypography._();

  static TextTheme createTextTheme({bool isHighContrast = false}) {
    final primaryTextColor = isHighContrast ? AppColors.hcTextPrimary : AppColors.textPrimary;
    final secondaryTextColor = isHighContrast ? AppColors.hcTextSecondary : AppColors.textSecondary;

    return TextTheme(
      // 96sp+ Giant Rep Counter
      displayLarge: TextStyle(
        fontSize: AppTokens.fontCounterHero,
        fontWeight: FontWeight.w800,
        height: 1.05,
        letterSpacing: -1.5,
        color: primaryTextColor,
      ),

      // 72sp Large Counter / Metric
      displayMedium: TextStyle(
        fontSize: AppTokens.fontCounterMedium,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -0.5,
        color: primaryTextColor,
      ),

      // 32sp Primary Screen Heading
      headlineLarge: TextStyle(
        fontSize: AppTokens.fontHeading1,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.2,
        color: primaryTextColor,
      ),

      // 28sp Section Heading
      headlineMedium: TextStyle(
        fontSize: AppTokens.fontHeading2,
        fontWeight: FontWeight.w700,
        height: 1.3,
        letterSpacing: 0.0,
        color: primaryTextColor,
      ),

      // 24sp Sub-heading / Card Title
      headlineSmall: TextStyle(
        fontSize: AppTokens.fontHeading3,
        fontWeight: FontWeight.w600,
        height: 1.35,
        letterSpacing: 0.1,
        color: primaryTextColor,
      ),

      // 24sp Title Large (e.g. AppBar title)
      titleLarge: TextStyle(
        fontSize: AppTokens.fontHeading3,
        fontWeight: FontWeight.w700,
        height: 1.3,
        letterSpacing: 0.0,
        color: primaryTextColor,
      ),

      // 22sp Body Large (Primary elderly readability tier)
      bodyLarge: TextStyle(
        fontSize: AppTokens.fontBodyLarge,
        fontWeight: FontWeight.w500,
        height: 1.45,
        letterSpacing: 0.2,
        color: primaryTextColor,
      ),

      // 20sp Body Default (Absolute minimum body text size for elderly)
      bodyMedium: TextStyle(
        fontSize: AppTokens.fontBodyDefault,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.25,
        color: primaryTextColor,
      ),

      // 18sp Supporting / Caption text
      bodySmall: TextStyle(
        fontSize: AppTokens.fontCaption,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.3,
        color: secondaryTextColor,
      ),

      // 22sp Primary Button Label (Bold, legible)
      labelLarge: TextStyle(
        fontSize: AppTokens.fontBodyLarge,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: 0.5,
        color: AppColors.onPrimary,
      ),

      // 20sp Secondary / Status Badge Label
      labelMedium: TextStyle(
        fontSize: AppTokens.fontBodyDefault,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: 0.3,
        color: primaryTextColor,
      ),
    );
  }
}
