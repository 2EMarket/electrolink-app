import 'package:flutter/material.dart';
import 'dart:async';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart'; // تأكد من المسار
import 'package:second_hand_electronics_marketplace/core/constants/app_strings.dart';
import 'onboarding_screen.dart'; // تأكد من المسار

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 100,
              color: AppColors.white,
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.appName,
              style: AppTypography.h2_20SemiBold.copyWith(
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
