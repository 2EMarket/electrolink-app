import 'package:flutter/material.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_sizes.dart';
import 'trust_indicator_card.dart';

class TrustIndicatorsSection extends StatelessWidget {
  const TrustIndicatorsSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 113,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TrustIndicatorCard(
              label: "Verified Phone",
              iconSvgPath: AppAssets.verifiedPhoneSvg,
              verified: true,
            ),
            SizedBox(width: AppSizes.paddingXS),
            TrustIndicatorCard(
              label: "Verified Identity",
              iconSvgPath: AppAssets.verifiedIdentityCardSvg,
              verified: false,
            ),
            SizedBox(width: AppSizes.paddingXS),
            TrustIndicatorCard(
              label: "Verified Email",
              iconSvgPath: AppAssets.verifiedMessageSvg,
              verified: false,
            ),
          ],
        ),
      ),
    );
  }
}
