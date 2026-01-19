import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_routes.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/pages/country_selection_screen.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/pages/home_tab.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/pages/main_layout_screen.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/pages/onboarding_screen.dart';
import 'package:second_hand_electronics_marketplace/features/location/presentation/pages/location_page.dart';

import '../../features/home/presentation/pages/favorite_screen.dart';
import '../../features/home/presentation/pages/listings_screen.dart';
import '../../features/listing/data/listing_model.dart';
import '../../features/profile/presentation/pages/public_profile/public_profile_screens/public_profile.dart';
import '../../features/profile/presentation/pages/public_profile/report_user_screen/send_report_screen.dart';
import '../../features/verification/presentation/pages/verification_screen.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/${AppRoutes.publicProfile}',
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      // Check onboarding status first
      // final isOnboardingCompleted =
      //     await OnboardingService.isOnboardingCompleted();
      // final isOnboardingPage = state.fullPath == '/${AppRoutes.onboarding}';

      // if (!isOnboardingCompleted && !isOnboardingPage) {
      //   return '/${AppRoutes.onboarding}';
      // }

      // if (isOnboardingCompleted && isOnboardingPage) {
      //   return '/${AppRoutes.signIn}';
      // }

      // if (isOnboardingCompleted) {
      //   final authState = context
      //       .read<AuthCubit>()
      //       .state; //you can store this in shared pref
      //   final loggingIn =
      //       state.fullPath == '/${AppRoutes.signIn}' ||
      //       state.fullPath == '/${AppRoutes.signUp}';

      //   if (authState is AuthSignedIn && loggingIn) {
      //     return '/${AppRoutes.home}';
      //   }

      //   if (authState is AuthSignedOut && !loggingIn && !isOnboardingPage) {
      //     return '/${AppRoutes.signIn}';
      //   }
      // }

      // return null;
    },
    routes: [
      // Onboarding route
      GoRoute(
        path: '/${AppRoutes.onboarding}',
        name: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      //country selection
      GoRoute(
        path: '/${AppRoutes.countrySelection}',
        name: AppRoutes.countrySelection,
        builder: (context, state) => const CountrySelectionScreen(),
      ),
      //location route
      GoRoute(
        path: '/${AppRoutes.location}',
        name: AppRoutes.location,
        builder: (context, state) => LocationScreen(),
      ),
      GoRoute(
        path: '/${AppRoutes.verification}',
        name: AppRoutes.verification,
        builder: (context, state) => VerificationScreen(),
      ),
      // GoRoute(
      //   path: '/${AppRoutes.home}',
      //   name: AppRoutes.home,
      //   builder: (context, state) => HomeScreen(),
      // ),
      GoRoute(
        path: '/${AppRoutes.mainLayout}',
        name: AppRoutes.mainLayout,
        builder: (context, state) => MainLayoutScreen(),
        routes: [
          GoRoute(
            path: AppRoutes.listings,
            name: AppRoutes.listings,
            builder: (context, state) {
              final args = state.extra as Map<String, dynamic>;
              return ListingsScreen(
                title: args['title'] as String,
                listings: args['listings'] as List<ListingModel>,
              );
            },
          ),
          GoRoute(
            path: AppRoutes.favorite,
            name: AppRoutes.favorite,
            builder: (context, state) => FavoriteScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/${AppRoutes.publicProfile}',
        name: AppRoutes.publicProfile,
        builder: (context, state) => PublicProfile(),
      ),
      GoRoute(
        path: '/${AppRoutes.reportUser}',
        name: AppRoutes.reportUser,
        builder: (context, state) => SendReportScreen(),
      ),
      // // Auth routes
      // GoRoute(
      //   path: '/${AppRoutes.signIn}',
      //   name: AppRoutes.signIn,
      //   builder: (context, state) => SignInPage(),
      // ),
      // GoRoute(
      //   path: '/${AppRoutes.signUp}',
      //   name: AppRoutes.signUp,
      //   builder: (context, state) => SignUpPage(),
      // ),
    ],

    // Error page
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(child: Text('Page not found: ${state.error}')),
        ),
  );

  static GoRouter get router => _router;
}
