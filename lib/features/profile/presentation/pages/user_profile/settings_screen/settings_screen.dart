import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/constants/constants_exports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.paddingM,
          AppSizes.paddingM,
          AppSizes.paddingM,
          AppSizes.paddingL,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(AppSizes.paddingM),
              leading: SvgPicture.asset(AppAssets.notificationIcon),
            ),
          ],
        ),
      ),
    );
  }
}
