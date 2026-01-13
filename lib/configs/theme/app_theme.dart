import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Main theme configuration for mobile app
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme => _buildTheme(
        brightness: Brightness.light,
        colors: AppColors.light,
      );

  /// Dark theme configuration  
  static ThemeData get darkTheme => _buildTheme(
        brightness: Brightness.dark,
        colors: AppColors.dark,
      );

  /// Build theme with given brightness and color scheme
  static ThemeData _buildTheme({
    required Brightness brightness,
    required AppColorScheme colors,
  }) {
    final bool isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: brightness,

      // Color Scheme
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: colors.mainColor,
        onPrimary: AppColors.white,
        primaryContainer: colors.mainColor40,
        onPrimaryContainer: isDark ? AppColors.white : AppColors.black,
        secondary: colors.secondaryColor,
        onSecondary: AppColors.white,
        secondaryContainer: colors.secondaryColor40,
        onSecondaryContainer: isDark ? AppColors.white : AppColors.black,
        tertiary: colors.mainColor,
        onTertiary: AppColors.white,
        error: colors.error,
        onError: AppColors.white,
        surface: colors.surface,
        onSurface: colors.titles,
        surfaceContainerHighest: colors.greyFillButton,
        onSurfaceVariant: colors.text,
        outline: colors.border,
        outlineVariant: colors.border,
        shadow: isDark ? Colors.black : Colors.black.withValues(alpha: 0.1),
        scrim: Colors.black.withValues(alpha: 0.6),
        inverseSurface: isDark ? AppColors.white : AppColors.black,
        onInverseSurface: isDark ? AppColors.black : AppColors.white,
        inversePrimary: isDark ? AppColors.mainColor : Color(0xFF3B82F6),
      ),

      // Scaffold
      scaffoldBackgroundColor: colors.background,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.titles,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.h2_20Medium.copyWith(
          color: colors.titles,
        ),
        iconTheme: IconThemeData(color: colors.icons),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTypography.h2_20SemiBold.copyWith(
          color: colors.titles,
        ),
        displayMedium: AppTypography.h2_20Medium.copyWith(
          color: colors.titles,
        ),
        displaySmall: AppTypography.h2_20Regular.copyWith(
          color: colors.titles,
        ),
        headlineLarge: AppTypography.h2_20SemiBold.copyWith(
          color: colors.titles,
        ),
        headlineMedium: AppTypography.h2_20Medium.copyWith(
          color: colors.titles,
        ),
        headlineSmall: AppTypography.h3_18Medium.copyWith(
          color: colors.titles,
        ),
        titleLarge: AppTypography.h3_18Medium.copyWith(
          color: colors.titles,
        ),
        titleMedium: AppTypography.h2_20Medium.copyWith(
          color: colors.titles,
        ),
        titleSmall: AppTypography.body16Medium.copyWith(
          color: colors.titles,
        ),
        bodyLarge: AppTypography.h3_18Regular.copyWith(
          color: colors.text,
        ),
        bodyMedium: AppTypography.body16Regular.copyWith(
          color: colors.text,
        ),
        bodySmall: AppTypography.body14Regular.copyWith(
          color: colors.text,
        ),
        labelLarge: AppTypography.label12Regular.copyWith(
          color: colors.hint,
        ),
        labelMedium: AppTypography.label10Regular.copyWith(
          color: colors.hint,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        hintStyle: AppTypography.body16Regular.copyWith(
          color: colors.placeholders,
        ),
        labelStyle: AppTypography.body14Regular.copyWith(
          color: colors.text,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.mainColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.mainColor,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTypography.buttonBig,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.mainColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: AppTypography.buttonBig,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.mainColor,
          side: BorderSide(color: colors.mainColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTypography.buttonBig,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shadowColor: isDark ? Colors.black : Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(8),
      ),

      // Icon Theme
      iconTheme: IconThemeData(color: colors.icons, size: 24),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 1,
        space: 1,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        selectedItemColor: colors.mainColor,
        unselectedItemColor: colors.icons,
        selectedLabelStyle: AppTypography.label10Medium,
        unselectedLabelStyle: AppTypography.label10Regular,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colors.greyFillButton,
        selectedColor: colors.mainColor40,
        labelStyle: AppTypography.body14Medium.copyWith(
          color: colors.titles,
        ),
        secondaryLabelStyle: AppTypography.body14Regular.copyWith(
          color: colors.text,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: AppTypography.h2_20SemiBold.copyWith(
          color: colors.titles,
        ),
        contentTextStyle: AppTypography.body16Regular.copyWith(
          color: colors.text,
        ),
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? colors.greyFillButton : AppColors.black,
        contentTextStyle: AppTypography.body14Regular.copyWith(
          color: AppColors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
