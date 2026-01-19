import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../../../configs/theme/app_colors.dart';
import '../../../../../../configs/theme/app_typography.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../widgets/report_user_widgets/report_reson_selector.dart';
import '../../../widgets/report_user_widgets/custom_popup.dart';
import '../../../widgets/report_user_widgets/status_feedback_widget.dart';
import '../../../../../../core/constants/app_assets.dart';

class SendReportScreen extends StatefulWidget {
  const SendReportScreen({super.key});

  @override
  State<SendReportScreen> createState() => _SendReportScreenState();
}

class _SendReportScreenState extends State<SendReportScreen> {
  int _selectedOptionIndex = -1;
  final TextEditingController _textController = TextEditingController();
  static const _warningIcon = AppAssets.popupWarning;
  static const _successIcon = AppAssets.popupDone;

  // The list of reasons to display
  final List<String> _reasons = [
    "Scam or fraudulent behavior",
    "Harassment or abusive behavior",
    "Suspicious activity",
    "Spam or fake account",
    "Impersonation",
    "Other reason", // This is index 5
  ];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report User')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.paddingM,
          0,
          AppSizes.paddingM,
          AppSizes.paddingL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.paddingXXS),
            Text(
              'Help us keep the community safe. Please select the reason that best describes the issue with this user.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.paddingXS),
            ReportReasonSelector(
              reasons: _reasons,
              selectedIndex: _selectedOptionIndex,
              textController: _textController,
              onChanged:
                  (value) => setState(() => _selectedOptionIndex = value),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: EasyLoading.isShow ? null : _submitReport,
                child: const Text("Submit"),
              ),
            ),
            const SizedBox(height: AppSizes.paddingM),
            Center(
              child: Text(
                "The reported user will not be notified.",
                style: AppTypography.label12Regular.copyWith(
                  color: context.colors.titles,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReport() async {
    EasyLoading.show(status: 'Waiting...');
    await Future.delayed(const Duration(milliseconds: 500));

    if (_selectedOptionIndex == -1) {
      EasyLoading.dismiss();
      _showStatusPopup(
        icon: _warningIcon,
        title: 'No reason selected',
        description: 'Please select a reason before submitting.',
        primaryText: 'OK',
        primaryColor: Theme.of(context).colorScheme.error,
      );
      return;
    }

    if (_selectedOptionIndex == _reasons.length - 1 &&
        _textController.text.trim().isEmpty) {
      EasyLoading.dismiss();
      _showStatusPopup(
        icon: _warningIcon,
        title: 'Missing description',
        description: 'Please describe the issue in the text field.',
        primaryText: 'OK',
        primaryColor: Theme.of(context).colorScheme.error,
      );
      return;
    }

    try {
      await Future.delayed(const Duration(seconds: 2));
      EasyLoading.dismiss();
      _showStatusPopup(
        icon: _successIcon,
        title: 'Report Submitted',
        description:
            'Thanks for helping keep our community safe.\nWe’ll review this report shortly.',
        primaryText: 'Back',
      );
    } catch (_) {
      EasyLoading.dismiss();
      _showStatusPopup(
        icon: _warningIcon,
        title: 'Something went wrong',
        description: 'We couldn’t submit your report.\nPlease try again.',
        primaryText: 'Try again',
        secondaryText: 'Cancel',
        onPrimary: _submitReport,
        primaryColor: Theme.of(context).colorScheme.error,
      );
    }
  }

  void _showStatusPopup({
    required String icon,
    required String title,
    required String description,
    required String primaryText,
    VoidCallback? onPrimary,
    String? secondaryText,
    VoidCallback? onSecondary,
    Color? primaryColor,
  }) {
    CustomPopup.show(
      context,
      body: StatusFeedbackWidget(
        iconPath: icon,
        title: title,
        description: description,
      ),
      primaryButtonText: primaryText,
      secondaryButtonText: secondaryText,
      onSecondaryButtonPressed: onSecondary,
      primaryButtonColor: primaryColor,
      onPrimaryButtonPressed:
          onPrimary ?? () => Navigator.of(context, rootNavigator: true).pop(),
    );
  }
}
