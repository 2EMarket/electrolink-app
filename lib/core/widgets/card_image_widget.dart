import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';

class CardImageWidget extends StatelessWidget {
  const CardImageWidget({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder:
          (ctx, err, stack) => Container(
            color: AppColors.neutral10,
            child: const Icon(
              Icons.image_not_supported,
              color: AppColors.neutral,
            ),
          ),
    );
  }
}
