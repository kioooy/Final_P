import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// All typography tokens derived from DESIGN.md (TechZone AI Design System).
///
/// Combines Poppins (headlines, titles, display) and Inter (body, labels).
class AppTextStyles {
  AppTextStyles._();

  // ── Display (Poppins) ─────────────────────────────────────────────
  static final TextStyle displayLg = GoogleFonts.poppins(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    height: 64 / 57,
    letterSpacing: -0.25,
  );

  static final TextStyle displayMd = GoogleFonts.poppins(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 52 / 45,
  );

  static final TextStyle displaySm = GoogleFonts.poppins(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 44 / 36,
  );

  // ── Headline (Poppins) ────────────────────────────────────────────
  static final TextStyle headlineLg = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 40 / 32,
  );

  static final TextStyle headlineMd = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 36 / 28,
  );

  static final TextStyle headlineSm = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24,
  );

  // ── Title (Poppins) ───────────────────────────────────────────────
  static final TextStyle titleLg = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 28 / 22,
  );

  static final TextStyle titleMd = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 24 / 16,
    letterSpacing: 0.15,
  );

  static final TextStyle titleSm = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
    letterSpacing: 0.1,
  );

  // ── Body (Inter) ──────────────────────────────────────────────────
  static final TextStyle bodyLg = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    letterSpacing: 0.5,
  );

  static final TextStyle bodyMd = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0.25,
  );

  static final TextStyle bodySm = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0.4,
  );

  // ── Label (Inter) ─────────────────────────────────────────────────
  static final TextStyle labelLg = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0.1,
  );

  static final TextStyle labelMd = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    letterSpacing: 0.5,
  );

  static final TextStyle labelSm = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 16 / 11,
    letterSpacing: 0.5,
  );
}
