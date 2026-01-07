 # Design Tokens for Flutter

This directory contains design tokens converted from Figma design files, ready to use in your Flutter application.

## Files

### `app_colors.dart`
Contains all color definitions organized into:
- **Basic Colors**: white, black, placeholders, borders, icons, text, titles, hints
- **Main Colors**: primary color with transparency variants (40%, 20%, 10%, 5%)
- **Secondary Colors**: secondary color with transparency variants
- **Status Colors**: warning, success, error, neutral with transparency variants
- **Wireframe Colors**: colors for wireframe/prototype designs

### `app_typography.dart`
Contains all text styles organized into:
- **Web Fonts**: H1-H5 headings, body text, buttons, captions, labels
- **Mobile Fonts**: Optimized typography for mobile devices

All text styles use the **Poppins** font family.

### `app_shadows.dart`
Contains predefined box shadow configurations:
- `card`: Standard card shadow
- `card2`: Alternative card shadow (lighter)
- `bottomSheet`: Shadow for bottom sheets
- `dropShadow`: General drop shadow

### `app_theme.dart`
Main theme configuration that combines colors, typography, and shadows into a complete Flutter theme.

## Usage

### 1. Add Poppins Font to Your Project

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
  style: AppTypography.h1_48Bold,
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
    ├── app_typography.dart  # Text styles
    ├── app_shadows.dart     # Shadow definitions
    └── app_theme.dart       # Complete theme configuration
```

## Responsive Design

The design tokens include both web and mobile typography variants. You can conditionally apply them based on screen size:

```dart
import 'package:flutter/material.dart';
import 'theme/app_typography.dart';

Text(
  'Responsive Heading',
  style: MediaQuery.of(context).size.width > 600
      ? AppTypography.h2_48SemiBold
      : AppTypography.mobileH2_20SemiBold,
)
```

## Customization

To customize any design token, simply modify the values in the respective files. The changes will automatically propagate throughout your app if you're using the theme system properly.
