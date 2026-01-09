import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Main theme configuration for mobile app
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',

      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: AppColors.mainColor,
        secondary: AppColors.secondaryColor,
        error: AppColors.error,
        surface: AppColors.white,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onError: AppColors.white,
        onSurface: AppColors.text,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.white,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.h2_20Medium.copyWith(
          color: AppColors.black,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
      ),
      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTypography.h2_20SemiBold.copyWith(
          color: AppColors.black,
        ),
        displayMedium: AppTypography.h2_20Medium.copyWith(
          color: AppColors.black,
        ),
        displaySmall: AppTypography.h2_20Regular.copyWith(
          color: AppColors.black,
        ),
        headlineLarge: AppTypography.h2_20SemiBold.copyWith(
          color: AppColors.titles,
        ),
        headlineMedium: AppTypography.h2_20Medium.copyWith(
          color: AppColors.titles,
        ),
        headlineSmall: AppTypography.h3_18Medium.copyWith(
          color: AppColors.titles,
        ),
        titleLarge: AppTypography.h3_18Medium.copyWith(color: AppColors.titles),
        titleMedium: AppTypography.h2_20Medium.copyWith(
          color: AppColors.titles,
        ),
        titleSmall: AppTypography.body16Medium.copyWith(
          color: AppColors.titles,
        ),
        bodyLarge: AppTypography.h3_18Regular.copyWith(color: AppColors.text),
        bodyMedium: AppTypography.body16Regular.copyWith(color: AppColors.text),
        bodySmall: AppTypography.body14Regular.copyWith(color: AppColors.text),
        labelLarge: AppTypography.label12Regular.copyWith(
          color: AppColors.text,
        ),
        labelMedium: AppTypography.label10Regular.copyWith(
          color: AppColors.text,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        hintStyle: AppTypography.body16Regular.copyWith(
          color: AppColors.placeholders,
        ),
        labelStyle: AppTypography.body14Regular.copyWith(color: AppColors.text),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          borderSide: BorderSide(color: AppColors.mainColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          borderSide: BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingM,
          vertical: AppSizes.paddingM,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainColor,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingL,
            vertical: AppSizes.paddingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          ),
          textStyle: AppTypography.buttonBig,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.mainColor,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingM,
            vertical: AppSizes.paddingS,
          ),
          textStyle: AppTypography.buttonBig,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.mainColor,
          side: BorderSide(color: AppColors.mainColor),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingL,
            vertical: AppSizes.paddingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          ),
          textStyle: AppTypography.buttonBig,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
        margin: const EdgeInsets.all(AppSizes.paddingXS),
      ),

      // Icon Theme
      iconTheme: IconThemeData(color: AppColors.icons, size: 24),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.icons,
        selectedLabelStyle: AppTypography.label10Medium,
        unselectedLabelStyle: AppTypography.label10Regular,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
