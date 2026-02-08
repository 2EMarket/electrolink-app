import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_routes.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/pages/country_selection_screen.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/pages/main_layout_screen.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/pages/onboarding_screen.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/pages/my_listings/my_listings_screen.dart';
import 'package:second_hand_electronics_marketplace/features/location/presentation/pages/location_page.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/models/add_listing_draft.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/bloc/add_listing_draft_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/bloc/add_listing_media_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/bloc/add_listing_submit_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/pages/add_listing/add_listing_screen.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/pages/no_internet_screen.dart';
import 'package:second_hand_electronics_marketplace/features/profile/presentation/pages/user_profile/settings_screen/help_center_screen.dart';
import '../../features/home/presentation/pages/favorite_screen.dart';
import '../../features/home/presentation/pages/listings_screen.dart';
import '../../features/listing/data/listing_model.dart';
import '../../features/profile/presentation/pages/user_profile/settings_screen/currency_screen.dart';
import '../../features/profile/presentation/pages/user_profile/settings_screen/language_currency_screen.dart';
import '../../features/profile/presentation/pages/user_profile/settings_screen/language_screen.dart';
import '../../features/profile/presentation/pages/user_profile/settings_screen/notification_settings_screen.dart';
import '../../features/profile/presentation/pages/user_profile/user_profile_screens/edit_user_profile.dart';
import '../../features/profile/profile_exports.dart';
import '../../features/verification/presentation/pages/verification_screen.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/${AppRoutes.mainLayout}',
  /*  debugLogDiagnostics: true,
    redirect: (context, state) async {
      return null;
    
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
    },*/
    routes: [
      // Onboarding route
      GoRoute(
        path: '/${AppRoutes.onboarding}',
        name: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/${AppRoutes.mylistings}',
        name: AppRoutes.mylistings,
        builder: (context, state) => MyListingScreen(),
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
        path: '/${AppRoutes.userProfile}',
        name: AppRoutes.userProfile,
        builder:
            (context, state) => ProfileScreen(
              userId: state.uri.queryParameters['userId'] ?? '1',
              isMe: state.uri.queryParameters['isMe'] == 'true',
            ),
        routes: [
          // Edit User Profile
          GoRoute(
            path: '/${AppRoutes.editUserProfile}',
            name: AppRoutes.editUserProfile,
            builder:
                (context, state) => EditUserProfile(
                  userId: state.uri.queryParameters['userId'] ?? '1',
                  isMe: state.uri.queryParameters['isMe'] == 'true',
                ),
          ),
          GoRoute(
            path: '/${AppRoutes.reportUser}',
            name: AppRoutes.reportUser,
            builder: (context, state) => SendReportScreen(),
          ),
          GoRoute(
            path: '/${AppRoutes.settingsScreen}',
            name: AppRoutes.settingsScreen,
            builder: (context, state) => SettingsScreen(),
            routes: [
              GoRoute(
                path: '/${AppRoutes.notificationSettings}',
                name: AppRoutes.notificationSettings,
                builder: (context, state) => NotificationSettingsScreen(),
              ),
              GoRoute(
                path: '/${AppRoutes.languageCurrency}',
                name: AppRoutes.languageCurrency,
                builder: (context, state) => const LanguageCurrencyScreen(),
                routes: [
                  GoRoute(
                    path: '/${AppRoutes.language}',
                    name: AppRoutes.language,
                    builder: (context, state) => const LanguageScreen(),
                  ),
                  GoRoute(
                    path: '/${AppRoutes.currency}',
                    name: AppRoutes.currency,
                    builder: (context, state) => const CurrencyScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: '/${AppRoutes.helpCenter}',
                name: AppRoutes.helpCenter,
                builder: (context, state) => HelpCenterScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/${AppRoutes.addListing}',
        name: AppRoutes.addListing,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => AddListingDraftCubit()..loadDraft(),
                ),
                BlocProvider(
                  create: (_) => AddListingMediaCubit(),
                ),
                BlocProvider(
                  create: (_) => AddListingSubmitCubit(),
                ),
              ],
              child: const AddListingScreen(),
            ),
      ),
      /*GoRoute(
        path: '/${AppRoutes.addListingPreview}',
        name: AppRoutes.addListingPreview,
        builder: (context, state) {
          final draft = state.extra as AddListingDraft;
          return ListingPreviewScreen(draft: draft);
        },
      ),*/
      GoRoute(
        path: '/${AppRoutes.noInternet}',
        name: AppRoutes.noInternet,
        builder: (context, state) => const NoInternetScreen(),
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
