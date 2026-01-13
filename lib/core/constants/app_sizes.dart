import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  // ==================== UI Spacing (Padding & Margins) ====================
  static const double paddingXXS = 4.0;
  static const double paddingXS = 8.0;
  static const double paddingS = 12.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double padding2XL = 40.0;
  static const double paddingXXL = 48.0;

  // ==================== Border Radius ====================
  static const double borderRadius = 12.0;
  static const double bottomSheetRadiusTop = 20.0;

  static const double safeAreaBottom = 24.0;

  // Example: Base width & height (designed for a reference device, e.g., 375x812)
  static double baseWidth = 375.0;
  static double baseHeight = 812.0;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Scale factor for width
  static double scaleWidth(BuildContext context) =>
      screenWidth(context) / baseWidth;

  // Scale factor for height
  static double scaleHeight(BuildContext context) =>
      screenHeight(context) / baseHeight;

  // ==================== UI Spacing (Padding & Margins) ====================
  static double paddingXXSRes(BuildContext context) =>
      4.0 * scaleWidth(context);

  static double paddingXSRes(BuildContext context) => 8.0 * scaleWidth(context);

  static double paddingSRes(BuildContext context) => 12.0 * scaleWidth(context);

  static double paddingMRes(BuildContext context) => 16.0 * scaleWidth(context);

  static double paddingLRes(BuildContext context) => 24.0 * scaleWidth(context);

  static double paddingXLRes(BuildContext context) =>
      32.0 * scaleWidth(context);

  static double padding2XLRes(BuildContext context) =>
      40.0 * scaleWidth(context);

  static double paddingXXLRes(BuildContext context) =>
      48.0 * scaleWidth(context);

  // ==================== Border Radius ====================
  static double borderRadiusRes(BuildContext context) =>
      12.0 * scaleWidth(context);

  static double bottomSheetRadiusTopRes(BuildContext context) =>
      20.0 * scaleWidth(context);

  static double safeAreaBottomRes(BuildContext context) =>
      24.0 * scaleHeight(context);
}
