import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';

import '../../../../../../configs/theme/app_colors.dart';
import '../../../../../../configs/theme/app_typography.dart';
import '../../../../../../core/constants/app_assets.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/widgets/progress_indicator.dart';
import '../../../../../listing/data/listing_model.dart';
import '../../../../data/models/profile_view_data.dart';
import '../../../../data/models/user_model.dart';
import '../../../widgets/public_profile_widgets/profile_header.dart';
import '../../../widgets/public_profile_widgets/trust_indicators_section.dart';
import '../../public_profile/public_profile_screens/public_profile.dart';

class UserProfile extends StatefulWidget {
  UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
  double verificationProgress = 0.3; // 30% verified

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
            const SizedBox(height: AppSizes.paddingS),
            Container(
              decoration: BoxDecoration(
                color: context.colors.background,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius10),
                border: Border.all(color: context.colors.border, width: 0.3),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.border,
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingXS),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profile Completion',
                          style: AppTypography.body16Regular.copyWith(
                            color: context.colors.titles,
                          ),
                        ),
                        Text(
                          '${verificationProgress * 100}%',
                          style: AppTypography.body14Regular.copyWith(
                            color: context.colors.titles,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingS),
                    ProgressIndicatorWidget(
                      progressValue: verificationProgress,
                    ),
                    const SizedBox(height: AppSizes.paddingM),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit Profile',
                          style: AppTypography.body14Regular.copyWith(
                            color: context.colors.titles,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: AppSizes.paddingM,
                            color: context.colors.icons,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSizes.paddingM),
            Container(
              decoration: BoxDecoration(
                color: context.colors.background,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius10),
                border: Border.all(color: context.colors.border, width: 0.3),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.border,
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingXS),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trust Indicators',
                      style: AppTypography.body16Medium.copyWith(
                        color: context.colors.titles,
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingXS),
                    Text(
                      'Verify your identity, mobile and email to get “Verified” badge. Tap to verify missing items',
                      style: AppTypography.body14Regular.copyWith(
                        color: context.colors.neutral,
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingXS),
                    const TrustIndicatorsSection(),
                  ],
                ),
              ),
            ),
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
