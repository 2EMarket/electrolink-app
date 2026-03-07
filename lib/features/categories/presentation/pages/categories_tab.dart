import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_routes.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_strings.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/category_item.dart';
import 'package:second_hand_electronics_marketplace/features/products/presentation/cubit/products_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/products/presentation/cubit/products_state.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Phones', 'icon': AppAssets.smartPhoneCatIcon},
      {'name': 'Tablets', 'icon': AppAssets.tabletCatIcon},
      {'name': 'Laptops', 'icon': AppAssets.laptopCatIcon},
      {
        'name': 'PC Parts',
        'icon': AppAssets.aiChipCatIcon,
      }, // AI Chip as PC Part
      {'name': 'Gaming', 'icon': AppAssets.gameCatIcon},
      {'name': 'Audio', 'icon': AppAssets.headphoneCatIcon},
      {'name': 'Smartwatches', 'icon': AppAssets.smartWatchCatIcon},
      {'name': 'Cameras', 'icon': AppAssets.cameraCatIcon},
      {
        'name': 'Smart Home',
        'icon': AppAssets.routerCatIcon,
      }, // Router as Smart Home icon
      {'name': 'TV & Monitors', 'icon': AppAssets.tvCatIcon},
      {'name': 'Accessories', 'icon': AppAssets.plugCatIcon},
      {'name': 'Networking', 'icon': AppAssets.wifiCatIcon},
    ];

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.categories,
          style: AppTypography.h2_20SemiBold.copyWith(
            color: context.colors.titles,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: AppSizes.paddingS,
          mainAxisSpacing: AppSizes.paddingS,
          childAspectRatio: 1.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryItem(
            title: category['name'],
            iconPath: category['icon'],
            isSelected: false,
            onTap: () {
              final productsState = context.read<ProductsCubit>().state;
              final products =
                  productsState is ProductsLoaded ? productsState.products : [];

              context.pushNamed(
                AppRoutes.listings,
                extra: {'title': category['name'], 'listings': products},
              );
            },
          );
        },
      ),
    );
  }
}
