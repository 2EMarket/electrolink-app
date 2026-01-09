import 'package:flutter/material.dart';

/// Design system typography exported from Figma
/// Font family: Poppins
class AppTypography {
  AppTypography._();

  static const String _fontFamily = 'Poppins';

  // ==================== Web Fonts ====================

  // Buttons
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.0,
  );

  static const TextStyle buttonBig = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.0,
  );

  // H1 (Page title - Hero)
  static const TextStyle h1_64Bold = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 64,
    height: 1.0,
  );

  static const TextStyle h1_56Bold = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 56,
    height: 1.0,
  );

  static const TextStyle h1_48Bold = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 48,
    height: 1.0,
  );

  // H2 (Section heading)
  static const TextStyle h2_48SemiBold = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 48,
    height: 1.0,
  );

  static const TextStyle h2_36SemiBold = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 36,
    height: 1.0,
  );

  // H3 (Subsection heading)
  static const TextStyle h3_36Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 36,
    height: 1.0,
  );

  static const TextStyle h3_28Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 28,
    height: 1.0,
  );

  // H4
  static const TextStyle h4_28Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 28,
    height: 1.0,
  );

  static const TextStyle h4_24Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.0,
  );

  static const TextStyle h4_20Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 1.0,
  );

  // H5
  static const TextStyle h5_20Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 1.0,
  );

  static const TextStyle h5_20Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 1.0,
  );

  static const TextStyle h5_16Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.0,
  );

  // Body
  static const TextStyle body18Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.0,
  );

  static const TextStyle body18Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.0,
  );

  static const TextStyle body16Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.0,
  );

  static const TextStyle body14Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.0,
  );

  // Caption
  static const TextStyle caption14Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.0,
  );

  static const TextStyle caption12Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.0,
  );

  // Label
  static const TextStyle label12Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.0,
  );

  static const TextStyle label10Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 1.0,
  );

  // ==================== Mobile Fonts ====================

  // Mobile Buttons
  static const TextStyle mobileButtonSmall = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.0,
  );

  static const TextStyle mobileButtonBig = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.0,
  );

  // Mobile H2
  static const TextStyle mobileH2_20SemiBold = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1.0,
  );

  static const TextStyle mobileH2_20Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 1.0,
  );

  static const TextStyle mobileH2_20Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 1.0,
  );

  // Mobile H3
  static const TextStyle mobileH3_18Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.0,
  );

  static const TextStyle mobileH3_18Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.0,
  );

  // Mobile Body
  static const TextStyle mobileBody16Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.0,
  );

  static const TextStyle mobileBody16Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.0,
  );

  static const TextStyle mobileBody14Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.0,
  );

  static const TextStyle mobileBody14Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.0,
  );

  // Mobile Navigation Label
  static const TextStyle mobileNavLabel10Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 1.0,
  );

  static const TextStyle mobileNavLabel10Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 10,
    height: 1.0,
  );

  static const TextStyle mobileNavLabel12Regular = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.0,
  );

  static const TextStyle mobileNavLabel12Medium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.0,
  );
}
