import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/te/chating_screen_fixed.dart';
import 'core/helpers/cache_helper.dart';
import 'imports.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
DevicePreview(enabled: true, builder: (context) => const 
    // ElectroLinkApp()
    ChatingScreen1()
    ),
  );
}