import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';

class CustomPopup {
  static void show(
    BuildContext context, {
    required String iconPath,
    required String title,
    required String description,
    required String primaryText,
    required VoidCallback onPrimaryPressed,
    String? secondaryText,
    VoidCallback? onSecondaryPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.paddingL,
              horizontal: AppSizes.paddingM,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(iconPath, width: 80, height: 80),

                const SizedBox(height: AppSizes.paddingL),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTypography.h3_18Medium.copyWith(
                    color: AppColors.titles,
                  ),
                ),

                const SizedBox(height: AppSizes.paddingXS),

                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: AppTypography.body16Regular.copyWith(
                    color: AppColors.hint,
                  ),
                ),

                const SizedBox(height: AppSizes.paddingL),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: onPrimaryPressed,

                    child: Text(primaryText),
                  ),
                ),

                if (secondaryText != null) ...[
                  const SizedBox(height: AppSizes.paddingM),
                  SizedBox(
                    width: double.infinity,

                    child: OutlinedButton(
                      onPressed:
                          onSecondaryPressed ?? () => Navigator.pop(context),

                      child: Text(secondaryText),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
