import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/horizontal_card.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/search_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/vertical_card.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/widgets/search_with_filter.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/listing_model.dart';

class ListingsScreen extends StatefulWidget {
  final String title;
  final List<ListingModel> listings;

  const ListingsScreen({
    super.key,
    required this.title,
    required this.listings,
  });

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          children: [
            SearchWithFilterWidget(),

            const SizedBox(height: AppSizes.paddingM),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.swapIcon),
                    const SizedBox(width: 4),
                    Text(
                      AppStrings.sort,
                      style: AppTypography.body14Regular.copyWith(
                        color: context.colors.titles,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => isGridView = false),
                      child: SvgPicture.asset(
                        !isGridView
                            ? AppAssets.documentColoredIcon
                            : AppAssets.documentUnColoredIcon,
                      ),
                    ),
                    SizedBox(width: AppSizes.paddingXS),
                    GestureDetector(
                      onTap: () => setState(() => isGridView = true),
                      child: SvgPicture.asset(
                        isGridView
                            ? AppAssets.categoryColoredIcon
                            : AppAssets.categoryUnColoredIcon,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: AppSizes.paddingM),

            Expanded(child: isGridView ? _buildGridView() : _buildListView()),
          ],
        ),
      ),
    );
  }

  // دالة بناء الشبكة (Grid)
  Widget _buildGridView() {
    return GridView.builder(
      clipBehavior: Clip.none,

      itemCount: widget.listings.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // عمودين
        mainAxisSpacing: AppSizes.paddingS,
        crossAxisSpacing: AppSizes.paddingS,
        childAspectRatio: 0.60,
        // mainAxisExtent: 290,
      ),
      itemBuilder: (context, index) {
        // نستخدم الفيرتكال كارد اللي صممتيه
        return VerticalCard(listing: widget.listings[index]);
      },
    );
  }

  // دالة بناء القائمة (List)
  Widget _buildListView() {
    return ListView.separated(
      clipBehavior: Clip.none,

      itemCount: widget.listings.length,
      separatorBuilder: (c, i) => const SizedBox(height: AppSizes.paddingS),
      itemBuilder: (context, index) {
        return HorizontalCard(listing: widget.listings[index]);
      },
    );
  }
}
