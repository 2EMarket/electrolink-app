import 'package:flutter/material.dart';

import 'imports.dart';

void main() {
  runApp(
    DevicePreview(enabled: false, builder: (context) => const ElectroLinkApp()),
  );
}
