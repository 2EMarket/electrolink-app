import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';

/// Widget displayed when verification is successfully completed
class VerificationSuccessStep extends StatelessWidget {
  /// Callback when user taps "Go Home" button
  final VoidCallback onGoHome;

  const VerificationSuccessStep({super.key, required this.onGoHome});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, size: 80, color: Colors.green),
          SizedBox(height: 16),
          Text("Under Review", style: AppTypography.h3_18Medium),
          TextButton(onPressed: onGoHome, child: Text("Go Home")),
        ],
      ),
    );
  }
}
