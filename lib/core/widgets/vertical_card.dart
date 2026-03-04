import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/card_content_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/card_image_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/badge_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/favorite_button.dart';

// استيراد الـ ProductModel الجديد
import '../../features/products/data/models/product_model.dart';

class VerticalCard extends StatelessWidget {
  final ProductModel listing; // تم التعديل هنا
  final VoidCallback? onTap;
  final double? width;

  const VerticalCard({
    super.key,
    required this.listing,
    this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final double favButtonSize = (width != null) ? (width! / 6) : 30.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.none,
        // margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
        width: width,
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          boxShadow: context.shadows.card,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    // فحص مصفوفة الصور زي ما عملنا بالـ Horizontal
                    child: CardImageWidget(
                      imageUrl:
                          listing.images.isNotEmpty ? listing.images.first : '',
                    ),
                  ),
                  Positioned(
                    bottom: AppSizes.paddingXS,
                    left: AppSizes.paddingXS,
                    child: BadgeWidget(
                      text: listing.condition,
                    ), // تعديل للـ condition
                  ),
                  // فحص حالة البيع
                  if (listing.status == 'sold')
                    Positioned(
                      top: AppSizes.paddingXS,
                      left: AppSizes.paddingXS,
                      child: BadgeWidget(
                        text: 'Sold',
                        bgColor: context.colors.secondaryColor,
                        textColor: context.colors.surface,
                      ),
                    ),
                  Positioned(
                    top: AppSizes.paddingXS,
                    right: AppSizes.paddingXS,
                    child: FavoriteButton(
                      isFavorite: false, // TODO: implement favorite
                      size: favButtonSize,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingS,
                  vertical: AppSizes.paddingS,
                ),
                child: CardContentWidget(listing: listing),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
