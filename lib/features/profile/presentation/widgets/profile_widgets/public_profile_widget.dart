import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/features/profile/presentation/widgets/profile_widgets/profile_listing_section.dart';
import 'package:second_hand_electronics_marketplace/features/profile/presentation/widgets/profile_widgets/trust_indicators_section.dart';
import '../../../../../configs/theme/app_colors.dart';
import '../../../../../configs/theme/app_typography.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../listing/data/listing_model.dart';

class PublicProfileWidget extends StatelessWidget {
  const PublicProfileWidget({super.key, required this.userListings});

  final List<ListingModel> userListings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Trust Indicators', style: AppTypography.body16Medium),
        const SizedBox(height: AppSizes.paddingXS),
        const TrustIndicatorsSection(),
        // const SizedBox(height: AppSizes.paddingS),
        Text(
          'Active Listings',
          style: AppTypography.body16Medium.copyWith(
            color: context.colors.titles,
          ),
        ),
        const SizedBox(height: AppSizes.paddingS),
        //   const EmptyListingsSection(),
        ProfileListingsSection(listings: userListings),
      ],
    );
  }
}
