import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_routes.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_strings.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/category_item.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/vertical_card.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/widgets/home_header.dart';

import 'package:second_hand_electronics_marketplace/features/categories/presentation/cubits/category_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/categories/presentation/cubits/category_states.dart';

// تأكدي من صحة هذه المسارات حسب مشروعك
import '../../../products/presentation/cubit/products_cubit.dart';
import '../../../products/presentation/cubit/products_state.dart';

final List<Map<String, dynamic>> dummyCategories = [
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
  const HomeTab({super.key});

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

          // ---------------- قسم الأقسام (Categories) ----------------
          _buildSectionHeader(
            context,
            title: AppStrings.categories,
            onSeeAll: () {},
          ),
          const SizedBox(height: AppSizes.paddingS),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizes.paddingM),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is CategoryFailure) {
                return Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingM),
                  child: Center(
                    child: Text(
                      'Failed to load categories: ${state.errorMessage}',
                      style: TextStyle(color: context.colors.error),
                    ),
                  ),
                );
              }

              if (state is CategorySuccess) {
                final categoriesData = state.response.data;
                if (categoriesData.isEmpty) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingM,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          dummyCategories.map((category) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: AppSizes.paddingS,
                              ),
                              child: CategoryItem(
                                title: category['name'],
                                iconPath: category['icon'],
                                isSelected: false,
                                onTap: () {},
                              ),
                            );
                          }).toList(),
                    ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingM,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        categoriesData.map((category) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: AppSizes.paddingS,
                            ),
                            child: CategoryItem(
                              title: category.name,
                              iconPath: category.icon?.url ?? '',
                              isSelected: false,
                              onTap: () {},
                            ),
                          );
                        }).toList(),
                  ),
                );
              }

              return const SizedBox();
            },
          ),

          const SizedBox(height: AppSizes.paddingL),

          // ---------------- قسم المنتجات (Products) ----------------
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is ProductsError) {
                return Center(
                  child: Text(
                    'خطأ في جلب المنتجات: ${state.message}',
                    style: TextStyle(color: context.colors.error),
                  ),
                );
              } else if (state is ProductsLoaded) {
                final products = state.products;

                if (products.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('لا توجد منتجات حالياً'),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. المضافة حديثاً (Recent)
                    _buildSectionHeader(
                      context,
                      title: AppStrings.recent,
                      onSeeAll: () {
                        context.pushNamed(
                          AppRoutes.listings,
                          extra: {
                            'title': 'Recent Listings',
                            'listings': products,
                          },
                        );
                      },
                    ),
                    const SizedBox(height: AppSizes.paddingS),
                    SizedBox(
                      height: listHeight,
                      child: ListView.separated(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingM,
                        ),
                        itemCount: products.length,
                        separatorBuilder:
                            (ctx, index) =>
                                const SizedBox(width: AppSizes.paddingM),
                        itemBuilder: (ctx, index) {
                          return VerticalCard(
                            width: cardWidth,
                            listing: products[index], // استخدام الداتا الحقيقية
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: AppSizes.paddingM),

                    // 2. الموصى بها (Recommended)
                    _buildSectionHeader(
                      context,
                      title: AppStrings.recommended,
                      onSeeAll: () {
                        context.pushNamed(
                          AppRoutes.listings,
                          extra: {
                            'title': 'Recommended Listings',
                            'listings': products,
                          },
                        );
                      },
                    ),
                    const SizedBox(height: AppSizes.paddingS),
                    SizedBox(
                      height: listHeight,
                      child: ListView.separated(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingM,
                        ),
                        itemCount: products.length,
                        separatorBuilder:
                            (ctx, index) =>
                                const SizedBox(width: AppSizes.paddingM),
                        itemBuilder: (ctx, index) {
                          // عكسنا اللستة كشكل جمالي مؤقت ليظهر اختلاف بين القسمين
                          final recommendedProducts =
                              products.reversed.toList();
                          return VerticalCard(
                            width: cardWidth,
                            listing:
                                recommendedProducts[index], // استخدام الداتا الحقيقية
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox(); // Initial State
            },
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
