import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/card_content_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/card_image_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/badge_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/favorite_button.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/listing_model.dart';

class HorizontalCard extends StatelessWidget {
  final ListingModel listing;
  final VoidCallback? onTap;

  const HorizontalCard({super.key, required this.listing, this.onTap});

  @override
  Widget build(BuildContext context) {
    const double imageWidth = 120.0;
    const double favButtonSize = imageWidth / 4;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          boxShadow: context.shadows.card,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          child: Row(
            children: [
              SizedBox(
                width: imageWidth,
                height: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CardImageWidget(imageUrl: listing.imageUrl),
                    ),
                    Positioned(
                      top: AppSizes.paddingXS,
                      left: AppSizes.paddingXS,
                      child: FavoriteButton(
                        isFavorite: listing.isFavorite,
                        size: favButtonSize,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingS),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardContentWidget(listing: listing),
                      const SizedBox(height: AppSizes.paddingXS),
                      BadgeWidget(text: listing.category),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
