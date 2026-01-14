import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_shadows.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';

class FAQWidget extends StatelessWidget {
  final String title;
  final String description;

  const FAQWidget({Key? key, required this.title, required this.description})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        boxShadow: AppShadows.card,
      ),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.only(
          left: AppSizes.paddingM,
          right: AppSizes.paddingM,
          bottom: AppSizes.paddingM,
        ),
        collapsedShape: const Border(),
        shape: const Border(),
        title: Text(
          title,
          style: AppTypography.body16Medium.copyWith(color: AppColors.titles),
        ),

        iconColor: AppColors.hint,
        collapsedIconColor: AppColors.hint,
        children: [
          const Divider(thickness: 1, height: 1),
          const SizedBox(height: AppSizes.paddingS),
          Text(
            description,
            style: AppTypography.body14Regular.copyWith(color: AppColors.hint),
          ),
        ],
      ),
    );
  }
}
