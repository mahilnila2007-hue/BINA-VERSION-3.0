import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rehabrep/core/theme/app_colors.dart';
import 'package:rehabrep/core/theme/app_theme.dart';
import 'package:rehabrep/core/theme/design_tokens.dart';
import 'package:rehabrep/core/widgets/accessible_button.dart';
import 'package:rehabrep/core/widgets/status_badge.dart';

// Helper to compute WCAG 2.1 relative luminance
double relativeLuminance(Color color) {
  double channel(double v) {
    return v <= 0.04045 ? v / 12.92 : pow((v + 0.055) / 1.055, 2.4).toDouble();
  }

  final r = channel(color.r);
  final g = channel(color.g);
  final b = channel(color.b);
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

// Helper to compute WCAG contrast ratio
double contrastRatio(Color c1, Color c2) {
  final l1 = relativeLuminance(c1);
  final l2 = relativeLuminance(c2);
  final lighter = max(l1, l2);
  final darker = min(l1, l2);
  return (lighter + 0.05) / (darker + 0.05);
}

void main() {
  group('WCAG Contrast Verification', () {
    test('Text Primary on Background meets WCAG AAA (>= 7.0:1)', () {
      final ratio = contrastRatio(AppColors.textPrimary, AppColors.background);
      expect(ratio, greaterThanOrEqualTo(7.0), reason: 'Ratio: $ratio:1');
    });

    test('Text Primary on Surface meets WCAG AAA (>= 7.0:1)', () {
      final ratio = contrastRatio(AppColors.textPrimary, AppColors.surface);
      expect(ratio, greaterThanOrEqualTo(7.0), reason: 'Ratio: $ratio:1');
    });

    test('Text Secondary on Background meets WCAG AAA (>= 7.0:1)', () {
      final ratio = contrastRatio(AppColors.textSecondary, AppColors.background);
      expect(ratio, greaterThanOrEqualTo(7.0), reason: 'Ratio: $ratio:1');
    });

    test('onPrimary on Primary meets WCAG AAA (>= 7.0:1)', () {
      final ratio = contrastRatio(AppColors.onPrimary, AppColors.primary);
      expect(ratio, greaterThanOrEqualTo(7.0), reason: 'Ratio: $ratio:1');
    });

    test('onAccent on Accent meets WCAG AAA (>= 7.0:1)', () {
      final ratio = contrastRatio(AppColors.onAccent, AppColors.accent);
      expect(ratio, greaterThanOrEqualTo(7.0), reason: 'Ratio: $ratio:1');
    });

    test('onSecondary on Secondary meets WCAG AAA (>= 7.0:1)', () {
      final ratio = contrastRatio(AppColors.onSecondary, AppColors.secondary);
      expect(ratio, greaterThanOrEqualTo(7.0), reason: 'Ratio: $ratio:1');
    });

    test('Success text on Background meets WCAG AAA (>= 7.0:1)', () {
      final ratio = contrastRatio(AppColors.success, AppColors.background);
      expect(ratio, greaterThanOrEqualTo(7.0), reason: 'Ratio: $ratio:1');
    });

    test('Warning text on Background meets WCAG AAA (>= 7.0:1)', () {
      final ratio = contrastRatio(AppColors.warning, AppColors.background);
      expect(ratio, greaterThanOrEqualTo(7.0), reason: 'Ratio: $ratio:1');
    });

    test('Error text on Background meets WCAG AAA (>= 7.0:1)', () {
      final ratio = contrastRatio(AppColors.error, AppColors.background);
      expect(ratio, greaterThanOrEqualTo(7.0), reason: 'Ratio: $ratio:1');
    });

    test('Status containers meet high legibility contrast on themselves', () {
      expect(contrastRatio(AppColors.onSuccessContainer, AppColors.successContainer), greaterThan(7.0));
      expect(contrastRatio(AppColors.onWarningContainer, AppColors.warningContainer), greaterThan(7.0));
      expect(contrastRatio(AppColors.onErrorContainer, AppColors.errorContainer), greaterThan(7.0));
    });

    test('UI Primary Button on Background meets WCAG AA UI (>= 4.5:1)', () {
      final ratio = contrastRatio(AppColors.primary, AppColors.background);
      expect(ratio, greaterThanOrEqualTo(4.5), reason: 'Ratio: $ratio:1');
    });
  });

  group('Elderly Typography Sizing Rules', () {
    final theme = AppTheme.light();

    test('Body text minimum size is at least 20sp', () {
      expect(theme.textTheme.bodyMedium?.fontSize, greaterThanOrEqualTo(20.0));
      expect(theme.textTheme.bodyLarge?.fontSize, greaterThanOrEqualTo(22.0));
    });

    test('Headings are in the 28-34sp range', () {
      expect(theme.textTheme.headlineLarge?.fontSize, inInclusiveRange(28.0, 34.0));
      expect(theme.textTheme.headlineMedium?.fontSize, inInclusiveRange(28.0, 34.0));
    });

    test('Giant counter text is at least 96sp', () {
      expect(theme.textTheme.displayLarge?.fontSize, greaterThanOrEqualTo(96.0));
    });
  });

  group('Elderly Touch & Accessible Component Rules', () {
    testWidgets('AccessibleButton renders with 72dp height and min 64dp touch target', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: AccessibleButton(
                label: 'START',
                onPressed: () {},
                type: AccessibleButtonType.primary,
              ),
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(AccessibleButton);
      expect(buttonFinder, findsOneWidget);

      final buttonSize = tester.getSize(buttonFinder);
      expect(buttonSize.height, equals(AppTokens.primaryButtonHeight));
      expect(buttonSize.height, greaterThanOrEqualTo(AppTokens.minTouchTarget));
    });

    testWidgets('StatusBadge displays both an icon and text (never color alone)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: StatusBadge.good(label: 'Good Rep'),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
      expect(find.text('Good Rep'), findsOneWidget);
    });
  });
}
