import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border.all(color: context.colors.border),
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
        child: SvgPicture.asset(
          AppAssets.filterSvg,
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(context.colors.icons, BlendMode.srcIn),
        ),
      ),
    );
  }
}
