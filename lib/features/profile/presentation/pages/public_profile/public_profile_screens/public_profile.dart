import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import '../../../../../../configs/theme/app_typography.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/constants/app_strings.dart';
import '../../../../../../core/widgets/vertical_card.dart';
import '../../../../../../core/widgets/widgets_exports.dart';
import '../../../../../listing/data/listing_model.dart';
import '../../../../data/models/public_profile_view_data.dart';
import '../../../../data/models/user_model.dart';
import '../../../widgets/public_profile_widgets/public_header.dart';
import '../../../widgets/public_profile_widgets/trust_indicators_section.dart';

class PublicProfile extends StatelessWidget {
  PublicProfile({super.key});

  final mockUser = UserModel(
    id: '1',
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidthPercent = 0.55;
    final double cardWidth = screenWidth * cardWidthPercent;
    final double listHeight = cardWidth + 112;

    return Scaffold(
      appBar: AppBar(
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
            const EmptyListingsSection(),
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
          ],
        ),
      ),
    );
  }
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


