import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';

import '../../../../../../configs/theme/theme_exports.dart';
import '../../../../../../core/constants/app_sizes.dart';

class PublicProfile extends StatelessWidget {
  const PublicProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  bottomNavigationBar: BottomNavigationBar(items: ),
      appBar: AppBar(title: const Text('Eleanor Vance')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.paddingM,
            AppSizes.paddingM,
            AppSizes.paddingM,
            AppSizes.paddingL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(AppAssets.profilePic),
                  SizedBox(width: AppSizes.paddingXS),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
Text('Eleanor Vance')
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
