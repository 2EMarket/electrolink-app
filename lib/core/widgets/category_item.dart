import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.title,
    required this.iconPath,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isSelected ? context.colors.mainColor : context.colors.neutral5;
    final iconColor =
        isSelected ? context.colors.surface : context.colors.icons;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              padding: EdgeInsets.all(AppSizes.paddingM),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: AppSizes.paddingXS),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  isSelected
                      ? AppTypography.body14Medium.copyWith(
                        color: context.colors.text,
                      )
                      : AppTypography.label12Regular.copyWith(
                        color: context.colors.text,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
