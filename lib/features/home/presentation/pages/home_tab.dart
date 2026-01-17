import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_strings.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/category_item.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/vertical_card.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/widgets/home_header.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/listing_model.dart';

final List<Map<String, dynamic>> categories = [
  {'name': 'Phones', 'icon': AppAssets.smartPhoneCatIcon},
  {'name': 'Laptops', 'icon': AppAssets.laptopCatIcon},
  {'name': 'Tablets', 'icon': AppAssets.tabletCatIcon},
  {'name': 'Watches', 'icon': AppAssets.smartWatchCatIcon},
  {'name': 'Headphones', 'icon': AppAssets.headphoneCatIcon},
  {'name': 'Gaming', 'icon': AppAssets.gameCatIcon},
  {'name': 'Cameras', 'icon': AppAssets.cameraCatIcon},
  {'name': 'TVs', 'icon': AppAssets.tvCatIcon},
  {'name': 'Routers', 'icon': AppAssets.routerCatIcon},
  {'name': 'Wifi', 'icon': AppAssets.wifiCatIcon},
  {'name': 'Plugs', 'icon': AppAssets.plugCatIcon},
  {'name': 'AI Chips', 'icon': AppAssets.aiChipCatIcon},
];

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidthPercent = 0.55;
    final double cardWidth = screenWidth * cardWidthPercent;
    final double listHeight = cardWidth + 112;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(),
          const SizedBox(height: AppSizes.paddingL),
          _buildSectionHeader(context, title: "Categories", onSeeAll: () {}),
          const SizedBox(height: AppSizes.paddingS),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSizes.paddingS),
                      child: CategoryItem(
                        title: category['name'],
                        iconPath: category['icon'],
                        isSelected: false,
                        onTap: () {},
                      ),
                    );
                  }).toList(),
            ),
          ),
          const SizedBox(height: AppSizes.paddingL),
          _buildSectionHeader(context, title: "Recent", onSeeAll: () {}),
          const SizedBox(height: AppSizes.paddingS),
          SizedBox(
            height: listHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingM,
              ),
              itemCount: dummyListings.length,
              separatorBuilder:
                  (ctx, index) => const SizedBox(width: AppSizes.paddingM),
              itemBuilder: (ctx, index) {
                return VerticalCard(
                  width: cardWidth,
                  listing: dummyListings[index],
                );
              },
            ),
          ),
          const SizedBox(height: AppSizes.paddingM),
          _buildSectionHeader(context, title: "Nearby", onSeeAll: () {}),
          const SizedBox(height: AppSizes.paddingS),
          SizedBox(
            height: listHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingM,
              ),
              itemCount: dummyListings.length,
              separatorBuilder:
                  (ctx, index) => const SizedBox(width: AppSizes.paddingM),
              itemBuilder: (ctx, index) {
                return VerticalCard(
                  width: cardWidth,
                  listing: dummyListings[index],
                );
              },
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required VoidCallback onSeeAll,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTypography.h3_18Medium.copyWith(
              color: context.colors.titles,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: onSeeAll,
            child: Text(AppStrings.seeAll, style: AppTypography.body14Regular),
          ),
        ],
      ),
    );
  }
}
