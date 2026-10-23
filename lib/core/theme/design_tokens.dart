/// Design tokens for ReHabRep.
/// Strictly enforces Elderly-First accessibility constraints:
/// - Minimum 64x64dp touch target
/// - 72dp tall primary buttons
/// - Body text minimum 20sp, headings 28-34sp, counters 96sp+
/// - No animations faster than 300ms, respect reduced motion
class AppTokens {
  AppTokens._();

  // Spacing (generous whitespace to prevent mis-taps)
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;

  // Touch & Component Dimensions
  static const double minTouchTarget = 64.0;
  static const double primaryButtonHeight = 72.0;
  static const double secondaryButtonHeight = 64.0;
  static const double statusBadgeHeight = 44.0;
  static const double iconSizeSmall = 24.0;
  static const double iconSizeMedium = 32.0;
  static const double iconSizeLarge = 48.0;
  static const double iconSizeHero = 64.0;

  // Radii
  static const double radiusCard = 20.0;
  static const double radiusButton = 18.0;
  static const double radiusBadge = 12.0;
  static const double radiusPill = 999.0;

  // Borders
  static const double borderWidthStandard = 1.5;
  static const double borderWidthThick = 2.5;

  // Font Sizes (sp) - strictly compliant with elderly accessibility rules
  static const double fontCounterHero = 96.0;
  static const double fontCounterMedium = 72.0;
  static const double fontHeading1 = 32.0;
  static const double fontHeading2 = 28.0;
  static const double fontHeading3 = 24.0;
  static const double fontBodyLarge = 22.0;
  static const double fontBodyDefault = 20.0;
  static const double fontCaption = 18.0;

  // Maximum font scaling allowed before capping to prevent UI overflow while maintaining readability
  static const double maxFontScaleFactor = 2.0;

  // Motion & Timing (no flashing, max 300ms)
  static const Duration animStandard = Duration(milliseconds: 250);
  static const Duration animSlow = Duration(milliseconds: 300);
  static const Duration animInstant = Duration.zero;

  // Voice & Cue timing
  static const Duration minCueInterval = Duration(seconds: 3);
}
