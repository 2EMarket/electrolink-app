import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/listing_model.dart';

class CardContentWidget extends StatelessWidget {
  const CardContentWidget({super.key, required this.listing});

  final ListingModel listing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          listing.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.body14Regular.copyWith(color: AppColors.titles),
        ),

        const SizedBox(height: AppSizes.paddingXS),

        Text(
          listing.price,
          style: AppTypography.body16Medium.copyWith(
            color: AppColors.mainColor,
          ),
        ),

        const SizedBox(height: AppSizes.paddingXS),

        Row(
          children: [
            SvgPicture.asset(AppAssets.locationIcon),
            const SizedBox(width: AppSizes.paddingXXS),
            Expanded(
              child: Text(
                listing.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.label12Regular.copyWith(
                  color: AppColors.text,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
