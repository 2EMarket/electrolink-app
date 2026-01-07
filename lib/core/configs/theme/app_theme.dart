import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Main theme configuration for the app
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
        titleTextStyle: AppTypography.h5_20Medium.copyWith(
          color: AppColors.black,
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTypography.h1_64Bold.copyWith(color: AppColors.black),
        displayMedium: AppTypography.h1_56Bold.copyWith(color: AppColors.black),
        displaySmall: AppTypography.h1_48Bold.copyWith(color: AppColors.black),
        headlineLarge: AppTypography.h2_48SemiBold.copyWith(color: AppColors.titles),
        headlineMedium: AppTypography.h2_36SemiBold.copyWith(color: AppColors.titles),
        headlineSmall: AppTypography.h3_36Medium.copyWith(color: AppColors.titles),
        titleLarge: AppTypography.h4_28Medium.copyWith(color: AppColors.titles),
        titleMedium: AppTypography.h5_20Medium.copyWith(color: AppColors.titles),
        titleSmall: AppTypography.h5_16Medium.copyWith(color: AppColors.titles),
        bodyLarge: AppTypography.body18Regular.copyWith(color: AppColors.text),
        bodyMedium: AppTypography.body16Regular.copyWith(color: AppColors.text),
        bodySmall: AppTypography.body14Regular.copyWith(color: AppColors.text),
        labelLarge: AppTypography.label12Regular.copyWith(color: AppColors.text),
        labelMedium: AppTypography.label10Regular.copyWith(color: AppColors.text),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        hintStyle: AppTypography.body16Regular.copyWith(
          color: AppColors.placeholders,
        ),
        labelStyle: AppTypography.body14Regular.copyWith(
          color: AppColors.text,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.mainColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainColor,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppTypography.buttonBig,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.mainColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: AppTypography.buttonBig,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.mainColor,
          side: BorderSide(color: AppColors.mainColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppTypography.buttonBig,
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: AppColors.white,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Icon Theme
      iconTheme: IconThemeData(
        color: AppColors.icons,
        size: 24,
      ),

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
        selectedLabelStyle: AppTypography.mobileNavLabel10Medium,
        unselectedLabelStyle: AppTypography.mobileNavLabel10Regular,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
