import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/widgets/trust_indicator_card.dart';
import '../../../../data/models/public_profile_view_data.dart';
import '../../../../data/models/user_model.dart';
import '../../../widgets/public_profile_widgets/public_header.dart';

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

    return Scaffold(
      appBar: AppBar(title: Text(profile.name)),
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
            // Header المستخدم
            ProfileHeader(profile: profile),
            const SizedBox(height: AppSizes.paddingL),

            // عنوان القسم
            Text(
              'Trust Indicators',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppSizes.paddingM),

            // Row من الكاردات
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TrustIndicatorCard(
                    label: "Verified Phone",
                    iconSvgPath: AppAssets.verifiedPhoneSvg,
                    verified: true,
                    onTap: () {
                      print("Verified Phone tapped");
                    },
                  ),
                  const SizedBox(width: AppSizes.paddingXS),
                  TrustIndicatorCard(
                    label: "Verified Identity",
                    iconSvgPath: AppAssets.verifiedIdentityCardSvg,
                    verified: false,
                  ),
                  const SizedBox(width: AppSizes.paddingXS),
                  TrustIndicatorCard(
                    label: "Verified Email",
                    iconSvgPath: AppAssets.verifiedMessageSvg,
                    verified: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
