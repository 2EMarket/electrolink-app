import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/widgets/widgets_exports.dart';
import '../../../../../listing/data/listing_model.dart';
import '../../../../data/models/public_profile_view_data.dart';
import '../../../../data/models/user_model.dart';
import '../../../widgets/public_profile_widgets/public_header.dart';
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
    final profile = PublicProfileViewData.fromUser(mockUser);
    final userListings =
        dummyListings
            .where((listing) => listing.ownerId == mockUser.id)
            .toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () {},
        ),
        title: Text(profile.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingS),
              child: Icon(Icons.more_vert, color: context.colors.icons),
            ),
            onPressed: () => showCustomBottomSheet(context),
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
            ProfileHeader(profile: profile),
            const SizedBox(height: AppSizes.paddingL),
            Text(
              'Trust Indicators',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppSizes.paddingXS),
            const TrustIndicatorsSection(),
            const SizedBox(height: AppSizes.paddingM),
            Text('Add Listings', style: Theme.of(context).textTheme.titleSmall),
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
