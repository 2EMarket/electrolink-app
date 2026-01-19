import 'package:flutter/material.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/widgets/custom_popup.dart';
import '../../../../../core/widgets/status_feedback_widget.dart';

class WarningPopup {
  static void show(
    BuildContext context, {
    required String title,
    required String description,
    String buttonText = 'OK',
  }) {
    CustomPopup.show(
      context,
      body: StatusFeedbackWidget(
        iconPath: AppAssets.popupWarning,
        title: title,
        description: description,
      ),
      primaryButtonText: buttonText,
      onPrimaryButtonPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      primaryButtonColor: Theme.of(context).colorScheme.error,
    );
  }
}
