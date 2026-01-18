import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/features/profile/presentation/widgets/public_profile_widgets/public_profile_info_row.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../data/models/public_profile_view_data.dart';

class ProfileHeader extends StatelessWidget {
  final PublicProfileViewData profile;

  const ProfileHeader({super.key, required this.profile});

  static const double _avatarSize = 90;
  static const double _onlineIndicatorSize = 15;
  static const double _borderRadius = 10;
  static const double _topBorderWidth = 5;
  static const double _sideBorderWidth = 1;

  Border _buildBorder(Color color) {
    return Border(
      top: BorderSide(color: color, width: _topBorderWidth),
      left: BorderSide(color: color, width: _sideBorderWidth),
      right: BorderSide(color: color, width: _sideBorderWidth),
      bottom: BorderSide(color: color, width: _sideBorderWidth),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelLarge;
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        border: _buildBorder(context.colors.secondaryColor),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(_avatarSize / 2),
            child: Container(
              width: _avatarSize,
              height: _avatarSize,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    profile.avatar,
                    width: _avatarSize,
                    height: _avatarSize,
                    fit: BoxFit.cover,
                  ),
                  if (profile.isOnline)
                    Positioned(
                      bottom: _avatarSize * 0.15,
                      right: _avatarSize * 0.15,
                      child: Container(
                        width: _onlineIndicatorSize,
                        height: _onlineIndicatorSize,
                        decoration: BoxDecoration(
                          color: context.colors.success,
                          shape: BoxShape.circle,
                          //    border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(width: AppSizes.paddingXS),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile.name, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: AppSizes.paddingXS),
              PublicProfileInfoRow(
                icon: AppAssets.locationOutlinedIcon,
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
      ),
    );
  }
}
