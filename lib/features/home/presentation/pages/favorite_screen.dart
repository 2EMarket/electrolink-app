import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_strings.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/status_feedback_widget.dart';
import 'package:second_hand_electronics_marketplace/features/wishlist/presentation/cubits/wishlist_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/wishlist/presentation/cubits/wishlist_state.dart';
import '../widgets/listings_grid_view.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.favorite)),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WishlistSuccess) {
            final wishlist = state.wishlistItems;

            if (wishlist.isEmpty) {
              return _buildEmptyState(context);
            }

            // Extract ProductModels from WishlistItems
            final products =
                wishlist
                    .where((item) => item.product != null)
                    .map((item) => item.product!)
                    .toList();

            return Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: ListingsGridView(listings: products),
            );
          }

          if (state is WishlistFailure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          return _buildEmptyState(context);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StatusFeedbackWidget(
              iconPath: AppAssets.favoriteSvg,
              title: 'Save your favorites',
              description: 'Favorites some items and find them here',
            ),
            const SizedBox(height: AppSizes.paddingL),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to home or browse
                  Navigator.pop(context);
                },
                child: const Text('Browse'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
