# Design Tokens for Flutter (Mobile) - Light & Dark Theme Support

This directory contains design tokens converted from Figma design files, with full support for both light and dark themes.

## Files

### `app_colors.dart`
Contains all color definitions organized into:
- **Basic Colors**: white, black, placeholders, borders, icons, text, titles, hints (your original design colors)
- **Main Colors**: primary color with transparency variants (40%, 20%, 10%, 5%)
- **Secondary Colors**: secondary color with transparency variants
- **Status Colors**: warning, success, error, neutral with transparency variants
- **Light Theme**: Uses your exact Figma design colors
- **Dark Theme**: Inverted colors optimized for dark mode

### `app_typography.dart`
Contains all text styles for mobile applications:
- **Headings**: H2 (20px), H3 (18px) in various weights
- **Body Text**: 16px and 14px in regular and medium weights
- **Buttons**: Big (16px) and small (14px) button styles
- **Labels**: 10px and 12px labels for navigation and small UI elements

All text styles use the **Poppins** font family.

### `app_shadows.dart`
Contains predefined box shadow configurations:
- `card`: Standard card shadow
- `card2`: Alternative card shadow (lighter)
- `bottomSheet`: Shadow for bottom sheets
- `dropShadow`: General drop shadow

### `app_theme.dart`
Main theme configuration that provides:
- `AppTheme.lightTheme` - Your original design (uses exact Figma colors)
- `AppTheme.darkTheme` - Dark mode variant

## ✅ How to Use Theme Correctly

### 1. In Your App - Enable Both Themes

```dart
MaterialApp(
  theme: AppTheme.lightTheme,      // Your original design
  darkTheme: AppTheme.darkTheme,   // Dark mode version
  themeMode: ThemeMode.system,     // Or .light, .dark
  home: MyHomePage(),
)
```

### 2. In Components - Use Theme, Not Static Colors

```dart
// ✅ CORRECT - Works for both light and dark
Text(
  'Title',
  style: Theme.of(context).textTheme.titleLarge,
)

// ✅ CORRECT - Access app colors
final colors = context.colors;
Container(
  color: colors.surface,
  child: Text('Content'),
)

// ❌ WRONG - Hardcoded, won't work in dark mode
Text(
  'Title',
  style: TextStyle(color: AppColors.titles),
)
```

### 3. Widgets That Auto-Theme

No extra work needed for these:
- `ElevatedButton`, `OutlinedButton`, `TextButton`
- `TextField`, `TextFormField`
- `Card`, `ListTile`
- `AppBar`, `BottomNavigationBar`
- `Icon`, `Divider`

### 4. Custom Widgets

```dart
Widget build(BuildContext context) {
  final colors = context.colors;  // Gets current theme colors
  final theme = Theme.of(context);
  
  return Container(
    decoration: BoxDecoration(
      color: colors.surface,
      border: Border.all(color: colors.border),
    ),
    child: Text(
      'Content',
      style: theme.textTheme.bodyMedium,
    ),
  );
}
```

### 5. Status Colors

```dart
final colors = context.colors;

// All automatically adjust for dark mode
Container(color: colors.success)  // Success indicator
Container(color: colors.error)    // Error state
Container(color: colors.warning)  // Warning
```

## 🎨 Color Mapping

### Light Theme (Your Original Design)
- `textPrimary` → `titles` (#212121)
- `textSecondary` → `text` (#3D3D3D)
- `textTertiary` → `hint` (#828282)
- `placeholder` → `placeholders` (#C7C7C7)
- `border` → `border` (#E4E4E4)
- `icon` → `icons` (#828282)
- `surfaceVariant` → `greyFillButton` (#F9FAFB)

### Dark Theme (Auto-Generated)
- `textPrimary` → Inverted to #E5E5E5
- `textSecondary` → Inverted to #B3B3B3
- `textTertiary` → Inverted to #808080
- `background` → #121212
- `surface` → #1E1E1E

## 📋 Quick Reference

| Need | Use This |
|------|----------|
| Title text | `theme.textTheme.titleLarge` |
| Body text | `theme.textTheme.bodyMedium` |
| Label text | `theme.textTheme.labelLarge` |
| Background | `colors.background` |
| Surface | `colors.surface` |
| Border | `colors.border` |
| Icon color | `colors.icon` |
| Primary | `colors.primary` |
| Success | `colors.success` |
| Error | `colors.error` |

## 1. Add Poppins Font to Your Project

Add the Poppins font to your `pubspec.yaml`:

```yaml
flutter:
  fonts:
    - family: Poppins
      fonts:
        - asset: fonts/Poppins-Regular.ttf
          weight: 400
        - asset: fonts/Poppins-Medium.ttf
          weight: 500
        - asset: fonts/Poppins-SemiBold.ttf
          weight: 600
        - asset: fonts/Poppins-Bold.ttf
          weight: 700
```

Download the Poppins font from [Google Fonts](https://fonts.google.com/specimen/Poppins) and place the files in a `fonts` directory.

### 2. Apply Theme in Your App

In your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
```

### 3. Use Colors

```dart
import 'theme/app_colors.dart';

Container(
  color: AppColors.mainColor,
  child: Text(
    'Hello',
    style: TextStyle(color: AppColors.white),
  ),
)
```

### 4. Use Typography

```dart
import 'theme/app_typography.dart';

Text(
  'Heading',
  style: AppTypography.h2_20SemiBold,
)

// Or with color override
Text(
  'Body Text',
  style: AppTypography.body16Regular.copyWith(
    color: AppColors.text,
  ),
)
```

### 5. Use Shadows

```dart
import 'theme/app_shadows.dart';

Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: AppShadows.card,
  ),
  child: YourWidget(),
)
```

### 6. Use Theme-aware Widgets

Since the theme is configured in `app_theme.dart`, many widgets will automatically use the design tokens:

```dart
ElevatedButton(
  onPressed: () {},
  child: Text('Button'), // Automatically uses buttonBig style and mainColor
)

TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'Enter your email',
  ), // Automatically uses configured borders and colors
)
```

## Design System Structure

```
lib/
└── theme/
    ├── app_colors.dart      # Color palette
    ├── app_typography.dart  # Mobile text styles
    ├── app_shadows.dart     # Shadow definitions
    └── app_theme.dart       # Complete mobile theme configuration
```

## Customization

To customize any design token, simply modify the values in the respective files. The changes will automatically propagate throughout your app if you're using the theme system properly.
