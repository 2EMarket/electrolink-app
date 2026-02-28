import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:second_hand_electronics_marketplace/core/constants/cache_keys.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/custom_bottom_navbar.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_routes.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/pages/home_tab.dart';
import 'package:second_hand_electronics_marketplace/features/profile/presentation/pages/user_profile/user_profile_screens/profile_screen.dart';
import 'package:second_hand_electronics_marketplace/features/profile/presentation/widgets/profile_widgets/profile_error_screen.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/widgets/notification_toast.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../../../auth/presentation/cubits/auth_states.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'not_logged_in.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen:
          (previous, current) => ModalRoute.of(context)?.isCurrent == true,
      listener: (context, state) {
        if (state is AuthLoading) {
          EasyLoading.show();
        } else {
          EasyLoading.dismiss();
        }

        if (state is AuthSuccess) {
          NotificationToast.show(
            context,
            AppStrings.welcomeBack,
            AppStrings.loggedInSuccess,
            ToastType.success,
          );
          context.goNamed(AppRoutes.mainLayout);
        } else if (state is AuthFailure) {
          NotificationToast.show(
            context,
            AppStrings.loginFailed,
            state.message,
            ToastType.error,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(body: SizedBox());
        }

        final authUser = state is AuthSuccess ? state.response.user : null;

        final screens = [
          HomeTab(), // Home
          Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () async {
                  // logout
                  context.read<AuthCubit>().logout();
                  context.goNamed(AppRoutes.login);

                  //just in case we want to test something
                },
                child: Text('Logout'),
              ),
            ),
          ), // Search/Listings - Replace when built
          HomeTab(), // Favorites - Replace when built
          authUser != null
              ? ProfileScreen(authUser: authUser, isMe: true)
              : const NotLoggedInScreen(),
        ];

        return Scaffold(
          body: screens[_currentIndex],

          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            onAddTap: () {
              context.pushNamed(AppRoutes.addListing);
            },
          ),
        );
      },
    );
  }
}
