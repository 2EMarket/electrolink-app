import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_theme.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // خليها false لو بدك تطفئيها
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('Hello Team'))),
    );
  }
}
