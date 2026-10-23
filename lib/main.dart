import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/design_tokens.dart';
import 'core/widgets/accessible_button.dart';
import 'core/widgets/status_badge.dart';
import 'core/widgets/destructive_dialog.dart';
import 'core/widgets/accessibility_wrapper.dart';
import 'core/l10n/app_strings.dart';

// Riverpod provider for high-contrast accessibility mode
final highContrastProvider = StateProvider<bool>((ref) => false);

// Riverpod provider for simulated text scale factor (for elderly testing)
final textScaleFactorProvider = StateProvider<double>((ref) => 1.0);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: ReHabRepApp(),
    ),
  );
}

class ReHabRepApp extends ConsumerWidget {
  const ReHabRepApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHighContrast = ref.watch(highContrastProvider);
    final textScale = ref.watch(textScaleFactorProvider);

    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: isHighContrast ? AppTheme.highContrast() : AppTheme.light(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
          ),
          child: AccessibilityWrapper(child: child ?? const SizedBox.shrink()),
        );
      },
      home: const DesignSystemShowcaseScreen(),
    );
  }
}

class DesignSystemShowcaseScreen extends ConsumerWidget {
  const DesignSystemShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHighContrast = ref.watch(highContrastProvider);
    final textScale = ref.watch(textScaleFactorProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ReHabRep Design System',
          semanticsLabel: 'ReHabRep Design System and Accessibility Verification',
        ),
        actions: [
          IconButton(
            tooltip: 'Toggle High Contrast Mode',
            icon: Icon(
              isHighContrast ? Icons.contrast_rounded : Icons.contrast_outlined,
              size: AppTokens.iconSizeMedium,
            ),
            onPressed: () {
              ref.read(highContrastProvider.notifier).state = !isHighContrast;
            },
          ),
          const SizedBox(width: AppTokens.spacing8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.spacing20,
            vertical: AppTokens.spacing16,
          ),
          children: [
            // Clinical safety statement banner
            Container(
              padding: const EdgeInsets.all(AppTokens.spacing16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                border: Border.all(
                  color: AppColors.borderSubtle,
                  width: AppTokens.borderWidthStandard,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.health_and_safety_rounded,
                    size: AppTokens.iconSizeMedium,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppTokens.spacing12),
                  Expanded(
                    child: Text(
                      AppStrings.safetyNotice,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTokens.spacing24),

            // Font scale simulator slider for testing 100% to 200% scaling
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTokens.spacing20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elderly Text Scaling Simulator',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppTokens.spacing8),
                    Text(
                      'Current scale: ${(textScale * 100).toInt()}% (Rule: Supports up to 200% without overflow)',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppTokens.spacing12),
                    Row(
                      children: [
                        Text('100%', style: theme.textTheme.bodySmall),
                        Expanded(
                          child: Slider(
                            value: textScale,
                            min: 1.0,
                            max: 2.0,
                            divisions: 4,
                            activeColor: AppColors.accent,
                            label: '${(textScale * 100).toInt()}%',
                            onChanged: (val) {
                              ref.read(textScaleFactorProvider.notifier).state = val;
                            },
                          ),
                        ),
                        Text('200%', style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTokens.spacing20),

            // Giant Rep Counter Section (96sp+)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTokens.spacing24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "LIVE REP COUNTER (96sp+)",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppTokens.spacing8),
                    Text(
                      '12',
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppTokens.spacing8),
                    Text(
                      'of 15 target repetitions',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTokens.spacing20),

            // Status Badges (Never color alone: icon + word + color)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTokens.spacing20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status Semantics (Color + Icon + Word)',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppTokens.spacing16),
                    Wrap(
                      spacing: AppTokens.spacing12,
                      runSpacing: AppTokens.spacing12,
                      children: [
                        StatusBadge.good(label: 'Good Rep'),
                        StatusBadge.adjust(label: 'Bend a little more'),
                        StatusBadge.rest(label: 'Rest now'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTokens.spacing20),

            // Buttons Section (Full-width, 72dp tall, min 64dp touch target)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTokens.spacing20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elderly-First Buttons (72dp Tall)',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppTokens.spacing16),
                    AccessibleButton(
                      label: AppStrings.buttonStartExercise,
                      icon: Icons.play_arrow_rounded,
                      type: AccessibleButtonType.primary,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Exercise Started',
                              style: TextStyle(fontSize: AppTokens.fontBodyDefault),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppTokens.spacing16),
                    AccessibleButton(
                      label: 'Test Stop Confirmation',
                      icon: Icons.stop_circle_outlined,
                      type: AccessibleButtonType.destructive,
                      onPressed: () async {
                        final result = await DestructiveConfirmationDialog.show(context);
                        if (context.mounted && result == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Session Stopped',
                                style: TextStyle(fontSize: AppTokens.fontBodyDefault),
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTokens.spacing24),

            // WCAG Contrast Verification Table
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTokens.spacing20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WCAG AAA Contrast Verification',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppTokens.spacing8),
                    Text(
                      'Requirement: >= 7.0:1 for text, >= 4.5:1 for UI elements',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppTokens.spacing16),
                    _buildContrastRow('Text Primary on Background', '#101F22', '#FBFDFD', '16.57:1', 'PASS AAA'),
                    _buildContrastRow('Text Secondary on Background', '#3B4A4D', '#FBFDFD', '9.05:1', 'PASS AAA'),
                    _buildContrastRow('onPrimary on Primary', '#FFFFFF', '#004D40', '9.83:1', 'PASS AAA'),
                    _buildContrastRow('onAccent on Accent', '#FFFFFF', '#0050A0', '7.91:1', 'PASS AAA'),
                    _buildContrastRow('onSecondary on Secondary', '#FFFFFF', '#005D6D', '7.54:1', 'PASS AAA'),
                    _buildContrastRow('Success text on Background', '#0B5B2B', '#FBFDFD', '8.08:1', 'PASS AAA'),
                    _buildContrastRow('Warning text on Background', '#763F00', '#FBFDFD', '8.29:1', 'PASS AAA'),
                    _buildContrastRow('Error text on Background', '#A01010', '#FBFDFD', '7.98:1', 'PASS AAA'),
                    _buildContrastRow('Primary Button on BG (UI)', '#004D40', '#FBFDFD', '9.63:1', 'PASS AAA'),
                    _buildContrastRow('Disabled text on Container', '#5A6464', '#DDE4E4', '4.73:1', 'PASS AA'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTokens.spacing32),
          ],
        ),
      ),
    );
  }

  Widget _buildContrastRow(
    String label,
    String fgHex,
    String bgHex,
    String ratio,
    String status,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTokens.spacing8),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: AppTokens.fontBodyDefault,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              ratio,
              style: const TextStyle(
                fontSize: AppTokens.fontBodyDefault,
                fontWeight: FontWeight.w700,
                color: AppColors.secondary,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.spacing8,
              vertical: AppTokens.spacing4,
            ),
            decoration: BoxDecoration(
              color: AppColors.successContainer,
              borderRadius: BorderRadius.circular(AppTokens.radiusBadge),
              border: Border.all(color: AppColors.success),
            ),
            child: Text(
              status,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.onSuccessContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
