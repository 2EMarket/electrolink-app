import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_theme.dart';
import 'package:second_hand_electronics_marketplace/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/bloc/selection_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/bloc/view_type.dart';
import 'package:second_hand_electronics_marketplace/features/location/data/repos/countries_service.dart';
import 'package:second_hand_electronics_marketplace/features/location/presentation/cubits/countries_cubit.dart';
import 'configs/routes/router.dart';
import 'features/auth/data/services/auth_service.dart';
import 'features/home/presentation/pages/splash_screen.dart';
import 'features/listing/presentation/pages/my_listings/my_listings_screen.dart';
import 'features/location/presentation/cubits/location_cubit.dart';
import 'imports.dart';

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
    final dioOptions = BaseOptions(
      baseUrl: 'https://gsg-project-group-6.onrender.com',
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
    );

    final myDio = Dio(dioOptions);
    return MultiBlocProvider(
      providers: [
        BlocProvider<CountriesCubit>(
          create:
              (context) =>
                  CountriesCubit(CountriesService(myDio))..fetchCountries(),
        ),
        BlocProvider<LocationCubit>(create: (context) => LocationCubit()),
        BlocProvider<SelectionCubit>(create: (context) => SelectionCubit()),
        BlocProvider<ViewTypeCubit>(create: (context) => ViewTypeCubit()),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(AuthService(myDio)),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        locale: DevicePreview.locale(context),
        builder: EasyLoading.init(
          builder: (context, widget) {
            return DevicePreview.appBuilder(context, widget!);
          },
        ),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
