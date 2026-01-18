import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';

import '../../../../../../configs/theme/app_colors.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/widgets/circle_button.dart';
import '../../../widgets/public_profile_widgets/bottom_sheet_profile_options.dart';
import '../../../widgets/report_user_widgets/toggle_circle_button.dart';

class SendReportScreen extends StatelessWidget {
  const SendReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report User'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.paddingM,
          AppSizes.paddingM,
          AppSizes.paddingM,
          AppSizes.paddingL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.paddingL),
            Text(
              'Help us keep the community safe. Please select the reason that best describes the issue with this user.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.paddingXS),
            ToggleCircleButton(
              value: false,
              size: 40,
              activeIcon: AppAssets.selectedSvg,
              inactiveIcon: AppAssets.notSelectedSvg,
              activeColor: context.colors.mainColor,
              inactiveColor: context.colors.icons,
              onTap: () {
                showCustomBottomSheet(context);
              },
            ),

          ],
        ),
      ),
    );
  }
}
