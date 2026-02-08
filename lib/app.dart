import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_theme.dart';

import 'package:second_hand_electronics_marketplace/features/listing/presentation/bloc/selection_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/bloc/view_type.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/pages/my_listings/my_listings_screen.dart';
import 'configs/routes/router.dart';
import 'features/location/presentation/cubits/location_cubit.dart';

class ElectroLinkApp extends StatelessWidget {
  const ElectroLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..indicatorSize = 50.0
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.transparent
      ..indicatorColor =
          isDark ? context.colors.mainColor : context.colors.background
      ..textColor =
          isDark ? context.colors.mainColor : context.colors.background
      ..maskColor = Colors.black.withOpacity(isDark ? 0.9 : 0.75)
      ..userInteractions = false
      ..dismissOnTap = false
      ..boxShadow = [];

    return MultiBlocProvider(
      providers: [
        //BlocProvider<LocationCubit>(create: (context) => LocationCubit()),
        BlocProvider<SelectionCubit>(create: (context) => SelectionCubit()),
        BlocProvider<ViewTypeCubit>(create: (context) => ViewTypeCubit()),
      ],
      child: MaterialApp(
        //routerConfig: AppRouter.router,
        //locale: DevicePreview.locale(context),
        // builder: (context, widget) {
        //   widget = DevicePreview.appBuilder(context, widget);
        //   return FlutterEasyLoading(child: MyListingScreen());
        // },
        home: SplashScreen(),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
