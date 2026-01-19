import 'package:flutter/material.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/widgets/custom_popup.dart';
import '../../../../../core/widgets/status_feedback_widget.dart';

class SuccessPopup {
  static void show(
    BuildContext context, {
    required String title,
    required String description,
    String buttonText = 'Back',
    VoidCallback? onBack,
  }) {
    CustomPopup.show(
      context,
      body: StatusFeedbackWidget(
        iconPath: AppAssets.popupDone,
        title: title,
        description: description,
      ),
      primaryButtonText: buttonText,
      onPrimaryButtonPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        if (onBack != null) onBack();
      },
    );
  }
}
