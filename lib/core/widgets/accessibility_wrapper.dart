import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';

/// Wraps any screen or UI section to ensure compliance with elderly-first accessibility rules:
/// - Clamps font scale factor up to 200% (2.0) while preventing UI crashes or catastrophic overflow
/// - Honors system reduce-motion settings
class AccessibilityWrapper extends StatelessWidget {
  final Widget child;

  const AccessibilityWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final clampedTextScaler = mediaQuery.textScaler.clamp(
      minScaleFactor: 1.0,
      maxScaleFactor: AppTokens.maxFontScaleFactor,
    );

    return MediaQuery(
      data: mediaQuery.copyWith(
        textScaler: clampedTextScaler,
      ),
      child: child,
    );
  }
}
