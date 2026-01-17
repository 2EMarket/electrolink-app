import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_electronics_marketplace/amal.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_theme.dart';

import 'configs/routes/router.dart';
import 'features/home/presentation/pages/main_layout_screen.dart';
import 'features/location/presentation/cubits/location_cubit.dart';

class ElectroLinkApp extends StatelessWidget {
  const ElectroLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(create: (context) => LocationCubit()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
