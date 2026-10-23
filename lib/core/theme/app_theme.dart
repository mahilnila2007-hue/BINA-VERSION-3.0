import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'design_tokens.dart';

/// Application theme configurations.
/// Supports Standard Clinical Light mode and High-Contrast Accessibility mode.
class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final textTheme = AppTypography.createTextTheme(isHighContrast: false);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        tertiary: AppColors.accent,
        onTertiary: AppColors.onAccent,
        tertiaryContainer: AppColors.accentContainer,
        onTertiaryContainer: AppColors.onAccentContainer,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.onErrorContainer,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.border,
        outlineVariant: AppColors.borderSubtle,
      ),
      textTheme: textTheme,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        toolbarHeight: 72,
        iconTheme: const IconThemeData(
          size: AppTokens.iconSizeMedium,
          color: AppColors.textPrimary,
        ),
      ),

      // Card Theme (20dp radius, generous padding, accessible borders)
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          side: const BorderSide(
            color: AppColors.borderSubtle,
            width: AppTokens.borderWidthStandard,
          ),
        ),
        margin: const EdgeInsets.only(bottom: AppTokens.spacing16),
      ),

      // Elevated Button Theme (Primary CTA, 72dp tall, 64dp+ touch target)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onAccent,
          minimumSize: const Size.fromHeight(AppTokens.primaryButtonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusButton),
          ),
          elevation: 2,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.spacing24,
            vertical: AppTokens.spacing16,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // Outlined Button Theme (Secondary CTA, 64dp+ tall, distinct border)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(AppTokens.secondaryButtonHeight),
          side: const BorderSide(
            color: AppColors.primary,
            width: AppTokens.borderWidthStandard,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusButton),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.spacing20,
            vertical: AppTokens.spacing16,
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),

      // Dialog Theme (Large, clear buttons for destructive confirmation)
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          side: const BorderSide(
            color: AppColors.border,
            width: AppTokens.borderWidthStandard,
          ),
        ),
        titleTextStyle: textTheme.headlineMedium,
        contentTextStyle: textTheme.bodyLarge,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.borderSubtle,
        thickness: AppTokens.borderWidthStandard,
        space: AppTokens.spacing24,
      ),
    );
  }

  static ThemeData highContrast() {
    final textTheme = AppTypography.createTextTheme(isHighContrast: true);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.hcBackground,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.hcPrimary,
        onPrimary: Colors.white,
        secondary: AppColors.hcPrimary,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.hcSurface,
        onSurface: AppColors.hcTextPrimary,
        outline: AppColors.hcBorder,
      ),
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: AppColors.hcSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          side: const BorderSide(
            color: AppColors.hcBorder,
            width: AppTokens.borderWidthThick,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.hcAccent,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(AppTokens.primaryButtonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusButton),
            side: const BorderSide(color: Colors.black, width: 2.0),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          minimumSize: const Size.fromHeight(AppTokens.secondaryButtonHeight),
          side: const BorderSide(color: Colors.black, width: AppTokens.borderWidthThick),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusButton),
          ),
          textStyle: textTheme.labelLarge?.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
