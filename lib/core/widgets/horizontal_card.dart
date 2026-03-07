import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/card_content_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/card_image_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/badge_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/favorite_button.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/listing_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/wishlist/presentation/cubits/wishlist_cubit.dart';
import '../../features/wishlist/presentation/cubits/wishlist_state.dart';
import '../../features/products/data/models/product_model.dart';

class HorizontalCard extends StatelessWidget {
  final ProductModel listing;
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
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned.fill(
                      child: CardImageWidget(
                        imageUrl:
                            listing.images.isNotEmpty
                                ? listing.images.first
                                : '',
                      ),
                    ),
                    if (listing.status == 'sold')
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          color: context.colors.secondaryColor.withOpacity(0.7),
                          alignment: Alignment.center,
                          child: Text(
                            "Sold",
                            style: AppTypography.label12Regular.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: AppSizes.paddingXS,
                      left: AppSizes.paddingXS,
                      child: BlocBuilder<WishlistCubit, WishlistState>(
                        builder: (context, state) {
                          final isFav = context
                              .read<WishlistCubit>()
                              .isFavorite(listing.id);
                          return FavoriteButton(
                            isFavorite: isFav,
                            size: favButtonSize,
                            onTap:
                                () => context
                                    .read<WishlistCubit>()
                                    .toggleWishlist(listing.id),
                          );
                        },
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
                      BadgeWidget(text: listing.condition),
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
