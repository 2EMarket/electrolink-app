import 'package:flutter/material.dart';
import 'configs/theme/theme_exports.dart';
import 'imports.dart';

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
      home: Center(child: ElevatedButton(onPressed: () {}, child: Text('hi'))),
    );
  }
}
