import 'package:flutter/material.dart';

import '../../../../../../configs/theme/app_colors.dart';
import '../../../../../../configs/theme/app_typography.dart';
import '../../../../../../core/constants/app_assets.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../listing/data/listing_model.dart';
import '../../../../data/models/profile_view_data.dart';
import '../../../../data/models/user_model.dart';
import '../../../widgets/public_profile_widgets/profile_header.dart';
import '../../../widgets/public_profile_widgets/public_profile_info_row.dart';
import '../../../widgets/public_profile_widgets/trust_indicators_section.dart';
import '../../public_profile/public_profile_screens/public_profile.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

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
    final profile = ProfileViewData.fromUser(
      mockUser,
      type: ProfileType.private,
    );
    final userListings =
        dummyListings
            .where((listing) => listing.ownerId == mockUser.id)
            .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingS),
              child: Icon(Icons.settings_rounded, color: context.colors.icons),
            ),
            onPressed: () {},
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProfileHeader(
              profile: profile, // ProfileViewData
              type: ProfileType.private,
            ),
            const SizedBox(height: AppSizes.paddingXS),
            const TrustIndicatorsSection(),
            const SizedBox(height: AppSizes.paddingM),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Listings',
                  style: AppTypography.body16Medium.copyWith(
                    color: context.colors.titles,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'See All',
                    style: AppTypography.label12Regular.copyWith(
                      color: context.colors.titles,
                    ),
                  ),
                ),
              ],
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
