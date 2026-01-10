import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_shadows.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';

class FaqTileWidget extends StatelessWidget {
  final String title;
  final String answer;

  const FaqTileWidget({Key? key, required this.title, required this.answer})
    : super(key: key);
  //لسة هاد الودجت بده تنظيف ومقارنة مع فيجما بالزبط
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius), // 12.0
        boxShadow: AppShadows.card,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingL,
            vertical: 8,
          ),
          childrenPadding: const EdgeInsets.only(
            left: AppSizes.paddingL,
            right: AppSizes.paddingL,
            bottom: AppSizes.paddingL,
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
            const Divider(color: Color(0xFFE2E8F0), thickness: 1, height: 1),
            const SizedBox(height: AppSizes.paddingM),
            Text(
              answer,
              style: AppTypography.body14Regular.copyWith(
                color: AppColors.hint,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
