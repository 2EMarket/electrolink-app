import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/card_content_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/card_image_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/badge_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/favorite_button.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/listing_model.dart';

class VerticalCard extends StatelessWidget {
  final ListingModel listing;
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
                    child: CardImageWidget(imageUrl: listing.imageUrl),
                  ),
                  Positioned(
                    bottom: AppSizes.paddingXS,
                    left: AppSizes.paddingXS,
                    child: BadgeWidget(text: listing.category),
                  ),
                  if (listing.isSold)
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
                      isFavorite: listing.isFavorite,
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
