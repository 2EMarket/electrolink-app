import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/app.dart';

void main() {
  runApp(DevicePreview(enabled: false, builder: (context) => const MyApp()));
}
