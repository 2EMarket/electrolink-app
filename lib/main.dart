import 'package:flutter/material.dart';
import 'core/helpers/cache_helper.dart';
import 'imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    DevicePreview(enabled: true, builder: (context) => const ElectroLinkApp()),
  );
}
