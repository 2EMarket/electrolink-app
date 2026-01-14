import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/amal.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_theme.dart';

class ElectroLinkApp extends StatelessWidget {
  const ElectroLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const AmalsApp(), //Use Your screen
    );
  }
}
