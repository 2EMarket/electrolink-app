import 'package:flutter/material.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../auth/data/models/auth_models.dart';
import 'trust_indicator_card.dart';

class TrustIndicatorsSection extends StatelessWidget {
  const TrustIndicatorsSection({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    //not singlechildview, all 3 cards should be visible and responsive
    return SizedBox(
      height: 113,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TrustIndicatorCard(
              label: "Verified Phone",
              iconSvgPath: AppAssets.verifiedPhoneSvg,
              verified: user.isPhoneVerified,
            ),
            SizedBox(width: AppSizes.paddingXS),
            TrustIndicatorCard(
              label: "Verified Identity",
              iconSvgPath: AppAssets.verifiedIdentityCardSvg,
              verified: user.isIdentityVerified,
            ),
            SizedBox(width: AppSizes.paddingXS),
            TrustIndicatorCard(
              label: "Verified Email",
              iconSvgPath: AppAssets.verifiedMessageSvg,
              verified: user.isEmailVerified,
            ),
          ],
        ),
      ),
    );
  }
}
