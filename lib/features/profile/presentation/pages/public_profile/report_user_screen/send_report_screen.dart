import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/constants/app_routes.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../widgets/report_user_widgets/error_popup.dart';
import '../../../widgets/report_user_widgets/report_reson_selector.dart';
import '../../../widgets/report_user_widgets/success_popup.dart';
import '../../../widgets/report_user_widgets/warning_popup.dart';

class SendReportScreen extends StatefulWidget {
  const SendReportScreen({super.key});

  @override
  State<SendReportScreen> createState() => _SendReportScreenState();
}

class _SendReportScreenState extends State<SendReportScreen> {
  int _selectedOptionIndex = -1;
  final TextEditingController _textController = TextEditingController();

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
      appBar: AppBar(
        title: Text('Report User'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              context.pop();
            } else {
              context.goNamed(AppRoutes.publicProfile); // أو أي شاشة افتراضية تريد الرجوع لها
            }
          },
        ),
      ),
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
                style: Theme.of(context).textTheme.labelLarge,
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
      WarningPopup.show(
        context,
        title: 'No reason selected',
        description: 'Please select a reason before submitting.',
      );
      return;
    }

    if (_selectedOptionIndex == _reasons.length - 1 &&
        _textController.text.trim().isEmpty) {
      EasyLoading.dismiss();
      WarningPopup.show(
        context,
        title: 'Missing description',
        description: 'Please describe the issue in the text field.',
      );
      return;
    }

    try {
      await Future.delayed(const Duration(seconds: 2));
      EasyLoading.dismiss();
      SuccessPopup.show(
        context,
        title: 'Report Submitted',
        description:
            'Thanks for helping keep our community safe.  We’ll review this report shortly.',
        onBack: () {
          // Optional: return to previous screen
          // Navigator.of(context).pop();
        },
      );
    } catch (_) {
      EasyLoading.dismiss();
      ErrorPopup.show(
        context,
        title: 'Something went wrong',
        description: 'We couldn’t submit your report.\nPlease try again.',
        onRetry: _submitReport,
      );
    }
  }
}
