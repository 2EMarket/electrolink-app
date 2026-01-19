import 'package:flutter/material.dart';
import '../../../../../core/constants/app_assets.dart';
import 'custom_popup.dart';
import 'status_feedback_widget.dart';

class ErrorPopup {
  static void show(
    BuildContext context, {
    required String title,
    required String description,
    String primaryText = 'Try again',
    String secondaryText = 'Cancel',
    required VoidCallback onRetry,
  }) {
    CustomPopup.show(
      context,
      body: StatusFeedbackWidget(
        iconPath: AppAssets.popupWarning,
        title: title,
        description: description,
      ),
      primaryButtonText: primaryText,
      onPrimaryButtonPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        onRetry();
      },
      secondaryButtonText: secondaryText,
      onSecondaryButtonPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      primaryButtonColor: Theme.of(context).colorScheme.error,
    );
  }
}
