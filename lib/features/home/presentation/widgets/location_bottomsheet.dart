import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/features/location/data/models/city_model.dart';
import 'package:second_hand_electronics_marketplace/features/location/data/models/country_model.dart';
// تأكدي من مسار المودلز
import 'package:second_hand_electronics_marketplace/features/location/presentation/cubits/location_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/location/presentation/cubits/location_states.dart';

class LocationPermissionSheet extends StatelessWidget {
  // ✅ 1. ضفنا هدول عشان نستقبل المدينة من الشاشة السابقة
  final CountryModel selectedCountry;
  final CityModel selectedCity;

  const LocationPermissionSheet({
    super.key,
    required this.selectedCountry,
    required this.selectedCity,
  });

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
            textAlign: TextAlign.center,
            style: AppTypography.h3_18Medium.copyWith(
              color: context.colors.text,
            ),
          ),
          const SizedBox(height: AppSizes.paddingL),

          // 📍 زر الخريطة
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.pushNamed(
                  AppRoutes.location,
                  extra: {
                    'initialLat': selectedCity.latitude,
                    'initialLng': selectedCity.longitude,
                    'fallbackCountry': selectedCountry.nameEn, // English
                    'fallbackCity': selectedCity.nameEn, // English
                  },
                );
              },
              child: const Text('Pick a place'),
            ),
          ),

          const SizedBox(height: AppSizes.paddingM),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder:
                      (_) => const Center(child: CircularProgressIndicator()),
                );

                await locationCubit.getCurrentLocation();

                if (context.mounted) {
                  Navigator.pop(context); // إغلاق اللودينج

                  // إذا نجح الـ GPS
                  if (locationCubit.state is LocationLoaded) {
                    context.pushReplacementNamed(AppRoutes.mainLayout);
                  } else {
                    await locationCubit.setLocationDirectly(
                      lat: selectedCity.latitude,
                      lng: selectedCity.longitude,
                      country: selectedCountry.nameEn, // English
                      city: selectedCity.nameEn, // English
                    );
                    context.pushReplacementNamed(AppRoutes.mainLayout);
                  }
                }
              },
              child: const Text('Setup GPS'),
            ),
          ),

          TextButton(
            onPressed: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder:
                    (_) => const Center(child: CircularProgressIndicator()),
              );

              await locationCubit.setLocationDirectly(
                lat: selectedCity.latitude,
                lng: selectedCity.longitude,
                country: selectedCountry.nameEn, // English
                city: selectedCity.nameEn, // English
              );

              if (context.mounted) {
                Navigator.pop(context);
                context.pushReplacementNamed(AppRoutes.mainLayout);
              }
            },
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }
}
