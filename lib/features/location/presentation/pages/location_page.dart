import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_routes.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_strings.dart';
import 'package:second_hand_electronics_marketplace/features/location/data/models/location_model.dart';
import 'package:second_hand_electronics_marketplace/features/location/presentation/cubits/location_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/location/presentation/widgets/address_info_widget.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({
    super.key,
    required this.initialLat,
    required this.initialLng,
    required this.fallbackCountry,
    required this.fallbackCity,
  });
  final double initialLat;
  final double initialLng;
  final String fallbackCountry;
  final String fallbackCity;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? mapController;
  late CameraPosition cameraPosition;
  late LatLng startLocation;
  String formatedAddress = "getting address ...";
  late double lat;
  late double lng;

  @override
  void initState() {
    super.initState();
    startLocation = LatLng(widget.initialLat, widget.initialLng);
    cameraPosition = CameraPosition(target: startLocation, zoom: 12);
    lat = widget.initialLat;
    lng = widget.initialLng;
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  formattedAdderss(Placemark p) {
    return [
      if (p.subLocality?.isNotEmpty ?? false) p.subLocality,
      if (p.thoroughfare?.isNotEmpty ?? false) p.thoroughfare,
      if (p.subThoroughfare?.isNotEmpty ?? false) p.subThoroughfare,
      if (p.postalCode?.isNotEmpty ?? false) p.postalCode,
      if (p.subAdministrativeArea?.isNotEmpty ?? false) p.subAdministrativeArea,
      if (p.administrativeArea?.isNotEmpty ?? false) p.administrativeArea,
      if (p.country?.isNotEmpty ?? false) p.country,
    ].join(', ').trim();
  }

  Future<void> _updateAddress() async {
    lat = cameraPosition.target.latitude;
    lng = cameraPosition.target.longitude;
    setState(() {
      formatedAddress = "getting address ...";
    });
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        formatedAddress = formattedAdderss(p);
        print('Address: $formatedAddress');
      } else {
        formatedAddress = 'Address not found';
      }
    } catch (_) {
      formatedAddress = 'error getting address';
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final locationCubit = context.read<LocationCubit>();

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.location)),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          children: [
            Flexible(
              child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(AppSizes.borderRadius),
                      ),
                    ),
                    child: GoogleMap(
                      zoomGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: startLocation,
                        zoom: 2,
                      ),
                      mapType: MapType.normal,
                      onMapCreated: (controller) => mapController = controller,
                      onCameraMove: (pos) => cameraPosition = pos,
                      onCameraIdle: _updateAddress,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: false,
                    ),
                  ),
                  Center(
                    child: SvgPicture.asset(
                      AppAssets.mapDetectorSvg,
                      width: 84,
                      height: 84,
                    ),
                  ),
                  Positioned(
                    bottom: 115,
                    left: 15,
                    right: 15,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AddressInfoWindow(address: formatedAddress),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.paddingM),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // onPressed: () async {
                //   LocationModel? selectedLocation;
                //   if (formatedAddress != 'Address not found' &&
                //       formatedAddress != 'error getting address') {
                //     selectedLocation = LocationModel(
                //       lat,
                //       lng,
                //       formatedAddress,
                //       '',
                //       '',
                //     );
                //   }
                //   if (selectedLocation != null) {
                //     await locationCubit.setSelectedLocation(
                //       selectedLocation.lat,
                //       selectedLocation.lng,
                //     );
                //   }
                // },
                onPressed: () async {
                  // 1. حساب المسافة بين مركز المدينة (اللي إجت من السواجر) ومكان الدبوس الحالي
                  double distanceInMeters = Geolocator.distanceBetween(
                    widget.initialLat,
                    widget.initialLng,
                    lat,
                    lng,
                  );

                  // 2. تحديد النطاق المسموح (مثلاً 70 كيلو متر = 70000 متر)
                  // بتقدري تكبريها أو تصغريها حسب حجم المدن عندك
                  if (distanceInMeters > 70000) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'You are too far from ${widget.fallbackCity}',
                        ),
                        backgroundColor:
                            context.colors.error, // لون أحمر للإيرور لو عندك
                      ),
                    );
                    return; // 🛑 بنوقف العملية وما بنحفظ إشي!
                  }

                  // 3. إذا المسافة تمام، بنكمل عملية الحفظ الطبيعية
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (_) => const Center(child: CircularProgressIndicator()),
                  );

                  String finalAddress = formatedAddress;
                  if (formatedAddress == 'Address not found' ||
                      formatedAddress == 'error getting address') {
                    finalAddress = 'Custom Location, ${widget.fallbackCity}';
                  }

                  await locationCubit.setLocationDirectly(
                    lat: lat,
                    lng: lng,
                    country: widget.fallbackCountry,
                    city: widget.fallbackCity,
                    address: finalAddress,
                  );

                  if (mounted) {
                    Navigator.pop(context); // إغلاق اللودينج
                    context.pushReplacementNamed(AppRoutes.mainLayout);
                  }
                },
                child: Text('Use this location'),
              ),
            ),
            SizedBox(height: AppSizes.paddingL),
          ],
        ),
      ),
    );
  }
}
