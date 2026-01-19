import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'configs/theme/app_theme.dart';
import 'imports.dart';

void main() {
  runApp(
    DevicePreview(enabled: true, builder: (context) => const ElectroLinkApp()),
  );

}
