
import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/features/profile/presentation/widgets/public_profile_widgets/public_profile_info_row.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../data/models/public_profile_view_data.dart';

class ProfileHeader extends StatelessWidget {
  final PublicProfileViewData profile;

  const ProfileHeader({super.key, required this.profile});

  static const double _avatarSize = 90;
  static const double _onlineIndicatorSize = 16;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelLarge;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(_avatarSize / 2),
              child: Image.asset(
                profile.avatar,
                width: _avatarSize,
                height: _avatarSize,
              ),
            ),
            if (profile.isOnline)
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  width: _onlineIndicatorSize,
                  height: _onlineIndicatorSize,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: AppSizes.paddingXS),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(profile.name, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: AppSizes.paddingXS),
            PublicProfileInfoRow(
              icon: AppAssets.locationIcon,
              text: profile.location,
              textStyle: textStyle,
            ),
            PublicProfileInfoRow(
              icon: AppAssets.calendarIcon,
              text: 'Member Since ${profile.memberSince}',
              textStyle: textStyle,
            ),
            PublicProfileInfoRow(
              icon: AppAssets.timeCircleIcon,
              text: 'Last Seen ${profile.lastSeen}',
              textStyle: textStyle,
            ),
            PublicProfileInfoRow(
              icon: AppAssets.chatOutlineIcon,
              text: profile.responseTime,
              textStyle: textStyle,
            ),
          ],
        ),
      ],
    );
  }
}
