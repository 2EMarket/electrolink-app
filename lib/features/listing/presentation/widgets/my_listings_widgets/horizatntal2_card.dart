import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/card_content_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/card_image_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/badge_widget.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/listing_model.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/widgets/my_listings_widgets/more_vert_button.dart';

class Horizontal2Card extends StatelessWidget {
  final ListingModel listing;
  final VoidCallback? onTap;
  final int selectState;

  Horizontal2Card({
    super.key,
    required this.listing,
    this.onTap,
    required this.selectState,
  });
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: CardContentWidget(listing: listing)),
                          MoreVertButton(selectState: selectState),
                        ],
                      ),
                      const SizedBox(height: AppSizes.paddingXS),
                      BadgeWidget(
                        text: switch (listing.status) {
                          ListingStatus.active => 'Active',
                          ListingStatus.pending => 'Pending',
                          ListingStatus.rejected => 'Rejected',
                          ListingStatus.sold => 'Sold',
                          ListingStatus.archived => 'Archived',
                          ListingStatus.draft => 'Draft',
                          // TODO: Handle this case.
                          null => 'Null',
                        },
                        bgColor: switch (listing.status) {
                          ListingStatus.active => Color.fromARGB(
                            255,
                            213,
                            248,
                            226,
                          ),
                          ListingStatus.pending => Color.fromARGB(
                            255,
                            253,
                            244,
                            209,
                          ),
                          ListingStatus.rejected => Color.fromARGB(
                            255,
                            238,
                            219,
                            219,
                          ),
                          ListingStatus.sold =>
                            context.colors.neutralWithoutTransparent,
                          ListingStatus.archived =>
                            context.colors.neutralWithoutTransparent,
                          ListingStatus.draft =>
                            context.colors.neutralWithoutTransparent,
                          // TODO: Handle this case.
                          null => context.colors.neutralWithoutTransparent,
                        }, //Color.fromARGB(255, 213, 248, 226),
                        textColor: switch (listing.status) {
                          ListingStatus.active => Color(0XFF22C55E),
                          ListingStatus.pending => Color(0XFFFACC15),
                          ListingStatus.rejected => Color(0XFFEF4444),
                          ListingStatus.sold => context.colors.neutral,
                          ListingStatus.archived => context.colors.neutral,
                          ListingStatus.draft => context.colors.neutral,
                          // TODO: Handle this case.
                          null => context.colors.neutral,
                        },
                      ),
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
