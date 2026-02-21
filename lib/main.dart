import 'package:flutter/material.dart';
import 'core/helpers/cache_helper.dart';
import 'imports.dart';

void main() async {
  //test
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    DevicePreview(enabled: false, builder: (context) => const ElectroLinkApp()),
  );
}
