import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
<<<<<<< HEAD
=======
import 'package:second_hand_electronics_marketplace/core/constants/app_routes.dart';
>>>>>>> 99c4b78366eb600f65ee24d30c1a01cfa052635d
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/features/location/data/models/location_model.dart';
import 'package:second_hand_electronics_marketplace/features/location/presentation/cubits/location_cubit.dart';

class LocationPermissionSheet extends StatelessWidget {
  const LocationPermissionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final locationCubit = context.read<LocationCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppAssets.locationFilledIcon),
          const SizedBox(height: AppSizes.paddingL),
          Text(
            'Set your exact location to find nearby products',
            // AppStrings.locationPermissionTitle,
            textAlign: TextAlign.center,
            style: AppTypography.h3_18Medium.copyWith(
              color: context.colors.text,
            ),
          ),
          const SizedBox(height: AppSizes.paddingL),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed<LocationModel>(AppRoutes.location);
              },

              child: Text('Pick a place'),
              // child: Text(AppStrings.allowWhileUsingApp),
            ),
          ),

          const SizedBox(height: AppSizes.paddingM),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                await locationCubit.getCurrentLocation();
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: context.colors.mainColor),
                foregroundColor: context.colors.mainColor,
              ),
              child: Text('Setup GPS'),
              // child: Text(AppStrings.allowThisTime),
            ),
          ),

          const SizedBox(height: AppSizes.paddingS),

          TextButton(
            onPressed: () {
              context.pushReplacementNamed(AppRoutes.mainLayout);
              print("Deny");
            },
            child: Text('Skip'),
            // child: Text(AppStrings.deny),
          ),
        ],
      ),
    );
  }
}
