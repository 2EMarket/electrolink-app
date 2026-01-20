import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import '../../../../../../configs/theme/app_typography.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/widgets/widgets_exports.dart';
import '../../../../../listing/data/listing_model.dart';
import '../../../../data/models/profile_view_data.dart';
import '../../../../data/models/user_model.dart';
import '../../../widgets/public_profile_widgets/profile_header.dart';
import '../../../widgets/public_profile_widgets/trust_indicators_section.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/widgets/listings_grid_view.dart';

class PublicProfile extends StatelessWidget {
  PublicProfile({super.key});

  final mockUser = UserModel(
    id: '2',
    name: 'Eleanor Vance',
    avatar: AppAssets.profilePic,
    location: 'Berlin',
    createdAt: DateTime(2023, 5, 1),
    lastSeen: DateTime.now().subtract(const Duration(hours: 1)),
    responseTimeMinutes: 60,
    isOnline: true,
  );

  @override
  Widget build(BuildContext context) {
    final profile = ProfileViewData.fromUser(
      mockUser,
      type: ProfileType.public,
    );
    final userListings =
        dummyListings
            .where((listing) => listing.ownerId == mockUser.id)
            .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(profile.name),
        actions: [
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingS),
              child: Icon(Icons.more_vert, color: context.colors.icons),
            ),
            onPressed:
                () => showCustomBottomSheet(
                  context,
                  const BottomSheetProfileOptions(),
                ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.paddingM,
          AppSizes.paddingM,
          AppSizes.paddingM,
          AppSizes.paddingL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(
              profile: profile, // ProfileViewData
              type: ProfileType.public,
            ),
            const SizedBox(height: AppSizes.paddingL),
            Text(
              'Trust Indicators',
              style: AppTypography.body16Medium.copyWith(
                color: context.colors.titles,
              ),
            ),
            const SizedBox(height: AppSizes.paddingXS),
            const TrustIndicatorsSection(),
            const SizedBox(height: AppSizes.paddingM),
            Text(
              'Active Listings',
              style: AppTypography.body16Medium.copyWith(
                color: context.colors.titles,
              ),
            ),
            const SizedBox(height: AppSizes.paddingM),
            //   const EmptyListingsSection(),
            ProfileListingsSection(listings: userListings),
          ],
        ),
      ),
    );
  }
}

class ProfileListingsSection extends StatelessWidget {
  final List<ListingModel> listings;

  const ProfileListingsSection({super.key, required this.listings});

  @override
  Widget build(BuildContext context) {
    if (listings.isEmpty) {
      return const EmptyListingsSection();
    }

    return ListingsGridView(
      listings: listings,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
