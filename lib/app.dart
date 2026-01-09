import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_theme.dart';

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
      home: Scaffold(
        appBar: AppBar(title: Text('Second Hand Electronics Marketplace')),
        body: Center(
          child: ElevatedButton(onPressed: () {}, child: Text('hi')),
        ),
      ),
    );
  }
}
