import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';

class VerificationInstructionView extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> guidelines;
  final VoidCallback onTakePicture;

  const VerificationInstructionView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.guidelines,
    required this.onTakePicture,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. العنوان الرئيسي
          Text(title, style: AppTypography.h3_18Medium),
          const SizedBox(height: AppSizes.paddingS),

          // 2. العنوان الفرعي
          Text(
            subtitle,
            style: AppTypography.body14Regular.copyWith(
              color: context.colors.neutral,
            ),
          ),
          const SizedBox(height: AppSizes.paddingL),

          // 3. قائمة التعليمات (Bullet Points)
          ...guidelines.map(
            (guide) => Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.paddingS),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("• ", style: AppTypography.body14Medium), // النقطة
                  Expanded(
                    child: Text(guide, style: AppTypography.body14Regular),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // 4. زر فتح الكاميرا
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTakePicture,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.mainColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Take Photo",
                style: AppTypography.body16Medium.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.paddingL),
        ],
      ),
    );
  }
}
