import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_strings.dart';
import 'package:second_hand_electronics_marketplace/features/location/data/models/location_model.dart';
import 'package:second_hand_electronics_marketplace/features/location/presentation/cubits/location_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/location/presentation/widgets/address_info_widget.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(27.6602292, 85.308027),
  );
  LatLng startLocation = const LatLng(27.6602292, 85.308027);
  String formatedAddress = "Location Name:";
  late double lat;
  late double lng;

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
    setState(() {});
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
                    ),
                  ),
                  Center(child: SvgPicture.asset(AppAssets.mapDetectorSvg)),
                  Positioned(
                    bottom: 115,
                    left: 15,
                    right: 15,
                    child: AddressInfoWindow(address: formatedAddress),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.paddingM),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  LocationModel? selectedLocation;
                  if (formatedAddress != 'Address not found' &&
                      formatedAddress != 'error getting address') {
                    selectedLocation = LocationModel(
                      lat,
                      lng,
                      formatedAddress,
                      '',
                      '',
                    );
                  }
                  if (selectedLocation != null) {
                    await locationCubit.setSelectedLocation(
                      selectedLocation.lat,
                      selectedLocation.lng,
                    );
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
