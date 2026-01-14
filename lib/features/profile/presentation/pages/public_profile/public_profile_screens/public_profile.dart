import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';

import '../../../../../../configs/theme/theme_exports.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../data/models/public_profile_view_data.dart';
import '../../../../data/models/user_model.dart';

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
  );

  @override
  Widget build(BuildContext context) {
    final profile = PublicProfileViewData.fromUser(mockUser);

    return Scaffold(
      appBar: AppBar(title: Text(profile.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.paddingM,
          AppSizes.paddingM,
          AppSizes.paddingM,
          AppSizes.paddingL,
        ),
        child: ProfileHeader(profile: profile),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final PublicProfileViewData profile;

  const ProfileHeader({super.key, required this.profile});

  static const double _iconSize = 14.5;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelLarge;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(profile.avatar, width: 90, height: 90),
        const SizedBox(width: AppSizes.paddingXS),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(profile.name, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: AppSizes.paddingXS),
            _InfoRow(
              icon: AppAssets.locationIcon,
              text: profile.location,
              textStyle: textStyle,
            ),
            _InfoRow(
              icon: AppAssets.calendarIcon,
              text: 'Member Since ${profile.memberSince}',
              textStyle: textStyle,
            ),
            _InfoRow(
              icon: AppAssets.timeCircleIcon,
              text: 'Last Seen ${profile.lastSeen}',
              textStyle: textStyle,
            ),
            _InfoRow(
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

class _InfoRow extends StatelessWidget {
  final String icon;
  final String text;
  final TextStyle? textStyle;

  const _InfoRow({required this.icon, required this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.paddingXS),
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 14.5, height: 14.5),
          const SizedBox(width: AppSizes.paddingXS),
          Text(text, style: textStyle),
        ],
      ),
    );
  }
}
