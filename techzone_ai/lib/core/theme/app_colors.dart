import 'dart:ui';

/// All color tokens derived from DESIGN.md (TechZone AI Design System).
///
/// Token naming follows the DESIGN.md YAML keys, converted to camelCase.
/// Every hex value is copied verbatim from the DESIGN.md `colors:` block.
///
/// Usage:
///   Container(color: AppColors.primary)
///   Text('Hello', style: TextStyle(color: AppColors.onSurface))
class AppColors {
  AppColors._();

  // ── Primary (Orange) ──────────────────────────────────────────────
  static const Color primary = Color(0xFFE8611A);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFFFDBC9);
  static const Color onPrimaryContainer = Color(0xFF341100);
  static const Color inversePrimary = Color(0xFFFFB690);

  // ── Secondary (Warm Slate) ────────────────────────────────────────
  static const Color secondary = Color(0xFF76574B);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFFDBC9);
  static const Color onSecondaryContainer = Color(0xFF2C160C);

  // ── Tertiary (Teal Accent) ────────────────────────────────────────
  static const Color tertiary = Color(0xFF006B5E);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF74F8E0);
  static const Color onTertiaryContainer = Color(0xFF00201B);

  // ── Error ─────────────────────────────────────────────────────────
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  // ── Neutral / Surface ────────────────────────────────────────────
  static const Color surface = Color(0xFFFFFBFF);
  static const Color surfaceDim = Color(0xFFE4D8D1);
  static const Color surfaceBright = Color(0xFFFFFBFF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFFEF1EB);
  static const Color surfaceContainer = Color(0xFFF8EBE5);
  static const Color surfaceContainerHigh = Color(0xFFF3E5DF);
  static const Color surfaceContainerHighest = Color(0xFFEDE0DA);
  static const Color onSurface = Color(0xFF201A17);
  static const Color onSurfaceVariant = Color(0xFF52443C);
  static const Color inverseSurface = Color(0xFF362F2B);
  static const Color inverseOnSurface = Color(0xFFFBEEE8);
  static const Color outline = Color(0xFF85746B);
  static const Color outlineVariant = Color(0xFFD7C2B8);
  static const Color surfaceTint = Color(0xFFE8611A);
  static const Color background = Color(0xFFFFFBFF);
  static const Color onBackground = Color(0xFF201A17);
  static const Color surfaceVariant = Color(0xFFF4DED4);

  // ── Extended Palette ──────────────────────────────────────────────
  static const Color success = Color(0xFF2E7D32);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color warning = Color(0xFFF9A825);
  static const Color onWarning = Color(0xFF1C1400);
  static const Color info = Color(0xFF1565C0);
  static const Color onInfo = Color(0xFFFFFFFF);
  static const Color starRating = Color(0xFFFFB300);
  static const Color badgeDiscount = Color(0xFFD32F2F);
  static const Color adminSidebar = Color(0xFF1B1B1F);
  static const Color adminSidebarActive = Color(0xFFE8611A);

  // ── Order Status (from DESIGN.md component tokens) ────────────────
  static const Color statusPendingBg = Color(0xFFFFF3E0);
  static const Color statusPendingText = Color(0xFFE65100);
  static const Color statusProcessingBg = Color(0xFFE3F2FD);
  static const Color statusProcessingText = Color(0xFF0D47A1);
  static const Color statusShippingBg = Color(0xFFE8F5E9);
  static const Color statusShippingText = Color(0xFF1B5E20);
  static const Color statusDeliveredBg = Color(0xFFE8F5E9);
  static const Color statusDeliveredText = Color(0xFF2E7D32); // = success
  static const Color statusCancelledBg = Color(0xFFFFDAD6); // = errorContainer
  static const Color statusCancelledText = Color(0xFF410002); // = onErrorContainer

  // ── Button Hover (from DESIGN.md component tokens) ────────────────
  static const Color buttonFilledHover = Color(0xFFD05516);
}
