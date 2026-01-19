import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/notification_toast.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/progress_indicator.dart';
import 'package:second_hand_electronics_marketplace/features/verification/data/enums/id_type.dart';
import 'package:second_hand_electronics_marketplace/features/verification/data/models/verification_form_data.dart';
import 'package:second_hand_electronics_marketplace/features/verification/presentation/pages/verification_camera_screen.dart';
import 'package:second_hand_electronics_marketplace/features/verification/presentation/pages/verification_preview_screen.dart';
import 'package:second_hand_electronics_marketplace/features/verification/presentation/widgets/steps/verification_type_selection_step.dart';
import 'package:second_hand_electronics_marketplace/features/verification/presentation/widgets/steps/verification_capture_step.dart';
import 'package:second_hand_electronics_marketplace/features/verification/presentation/widgets/steps/verification_selfie_step.dart';
import 'package:second_hand_electronics_marketplace/features/verification/presentation/widgets/steps/verification_success_step.dart';
import 'package:second_hand_electronics_marketplace/features/verification/presentation/widgets/verification_instruction_view.dart';
import 'package:second_hand_electronics_marketplace/features/verification/services/verification_service.dart';

enum VerificationStep { selectType, frontId, backId, selfie, success }

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final VerificationService _verificationService = VerificationService();

  final VerificationFormData _formData = VerificationFormData();
  VerificationStep currentStep = VerificationStep.selectType;
  double get progressValue {
    switch (currentStep) {
      case VerificationStep.selectType:
        return 0.25;
      case VerificationStep.frontId:
        return 0.50;
      case VerificationStep.backId:
        return 0.75;
      case VerificationStep.selfie:
        return 1.0;
      case VerificationStep.success:
        return 1.0;
    }
  }

  void nextStep() {
    setState(() {
      switch (currentStep) {
        case VerificationStep.selectType:
          currentStep = VerificationStep.frontId;
          break;
        case VerificationStep.frontId:
          currentStep = VerificationStep.backId;
          break;
        case VerificationStep.backId:
          currentStep = VerificationStep.selfie;
          break;
        case VerificationStep.selfie:
          currentStep = VerificationStep.success;
          break;
        case VerificationStep.success:
          context.pop();
          break;
      }
    });
  }

  void prevStep() {
    if (currentStep == VerificationStep.selectType) {
      context.pop();
      return;
    }
    setState(() {
      switch (currentStep) {
        case VerificationStep.frontId:
          currentStep = VerificationStep.selectType;
          break;
        case VerificationStep.backId:
          currentStep = VerificationStep.frontId;
          break;
        case VerificationStep.selfie:
          currentStep = VerificationStep.backId;
          break;
        default:
          break;
      }
    });
  }

  void _showErrorSnackBar(String message) {
    NotificationToast.show(
      context,
      'Please try again',
      message,
      ToastType.error,
    );
  }

  Future<void> _handleIdCardCapture({
    required String cameraTitle,
    required String cameraDescription,
    required String previewTitle,
    required String previewSubtitle,
    required Function(String) onValidated,
  }) async {
    final hasPermission = await _checkCameraPermission();
    if (!hasPermission) return; // إذا فشل، وقف الدالة فوراً

    // 2. Open camera (نكمل الكود عادي)
    if (!mounted) return; // تأكد إن الشاشة
    // 1. Open camera
    final imagePath = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => VerificationCameraScreen(
              title: cameraTitle,
              description: cameraDescription,
            ),
      ),
    );

    // 2. If we got an image, open preview
    if (imagePath != null) {
      final isConfirmed = await Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => VerificationPreviewScreen(
                imagePath: imagePath,
                title: previewTitle,
                subtitle: previewSubtitle,
              ),
        ),
      );

      // 3. If confirmed, validate AND compress
      if (isConfirmed == true) {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) => const Center(child: CircularProgressIndicator()),
        );

        // A. Validate using service
        final isValid = await _verificationService.validateIdCard(imagePath);

        // B. Compress if valid
        String finalPath = imagePath; // نفترض المسار الأصلي أولاً
        if (isValid) {
          final compressedPath = await _verificationService.compressImage(
            imagePath,
          );
          if (compressedPath != null) {
            finalPath = compressedPath; // نعتمد المسار المضغوط
          }
        }

        if (!mounted) return;
        Navigator.pop(context); // Hide loading

        // C. Handle result
        if (isValid) {
          onValidated(finalPath); // ✅ نمرر الصورة المضغوطة
        } else {
          _showErrorSnackBar("Please ensure the ID is clear and well-lit.");
        }
      }
    }
  }

  Future<void> _handleSelfieCapture({
    required Function(String) onValidated,
  }) async {
    // 1. Open camera (front-facing)
    final imagePath = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => const VerificationCameraScreen(
              title: "Take a Selfie",
              description: "Hold your ID and look at the camera.",
              cameraLensDirection: CameraLensDirection.front,
            ),
      ),
    );

    // 2. Preview
    if (imagePath != null) {
      final isConfirmed = await Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => VerificationPreviewScreen(
                imagePath: imagePath,
                title: "Check your Selfie",
                subtitle: "Is your face and ID clear?",
              ),
        ),
      );

      // 3. Validate AND compress
      if (isConfirmed == true) {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) => const Center(child: CircularProgressIndicator()),
        );

        // A. Validate using service
        final isValid = await _verificationService.validateSelfie(imagePath);

        // B. Compress if valid
        String finalPath = imagePath;
        if (isValid) {
          final compressedPath = await _verificationService.compressImage(
            imagePath,
          );
          if (compressedPath != null) {
            finalPath = compressedPath;
          }
        }

        if (!mounted) return;
        Navigator.pop(context); // Hide loading

        // C. Handle result
        if (isValid) {
          onValidated(finalPath); // ✅ نمرر الصورة المضغوطة
        } else {
          _showErrorSnackBar(
            "Face validation failed. Please ensure good lighting and look straight at the camera.",
          );
        }
      }
    }
  }

  Future<bool> _checkCameraPermission() async {
    // 1. فحص الحالة الحالية
    var status = await Permission.camera.status;

    // 2. إذا لم يتم طلبه من قبل، نطلبه الآن
    if (status.isDenied) {
      status = await Permission.camera.request();
    }

    // 3. إذا المستخدم اختار "Don't allow" بشكل نهائي (أو رفض مرتين)
    if (status.isPermanentlyDenied) {
      _showPermissionDialog(); // نعرض له رسالة توجيه للإعدادات
      return false;
    }

    // 4. نرجع النتيجة (true إذا وافق، false إذا رفض)
    return status.isGranted;
  }

  /// دالة تعرض نافذة تنبيه لفتح الإعدادات
  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Camera Permission Required"),
            content: const Text(
              "We need camera access to verify your identity. Please enable it in settings.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings(); // 👈 تفتح إعدادات التطبيق في الجوال
                },
                child: const Text("Open Settings"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.identityVerification)),
      body: Column(
        children: [
          if (currentStep != VerificationStep.success)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingM,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ProgressIndicatorWidget(
                      progressValue: progressValue,
                    ),
                  ),
                  const SizedBox(width: AppSizes.paddingM),
                  RichText(
                    text: TextSpan(
                      style: AppTypography.label12Regular,
                      children: [
                        TextSpan(
                          text: "${(progressValue * 4).toInt()}",
                          style: TextStyle(color: context.colors.mainColor),
                        ),

                        TextSpan(
                          text: " / 4",
                          style: TextStyle(color: context.colors.icons),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: AppSizes.paddingL),
          Expanded(child: _buildCurrentStepBody()),
        ],
      ),
    );
  }

  // تعريف هيكل البيانات لكل خطوة
  Map<String, dynamic> _getStepConfig(VerificationStep step) {
    switch (step) {
      case VerificationStep.frontId:
        return {
          "title": "Capture the Front of Your ID",
          "subtitle": "Follow the guidelines for best quality",
          "guidelines": [
            "Place the ID inside the frame",
            "Avoid glare, shadows, or blur",
            "Make sure details are readable",
          ],
          "cameraTitle": "Capture Front ID",
          "cameraDesc": "Place the front of your ID within the frame.",
          "previewTitle": "Check your Front ID",
          "previewSubtitle": "Make sure details are clear and readable.",
        };

      case VerificationStep.backId:
        return {
          "title": "Capture the Back of Your ID",
          "subtitle": "Follow the guidelines for best quality",
          "guidelines": [
            "Flip your ID card to the back side",
            "Avoid glare, shadows, or blur",
            "Make sure the image is clear",
          ],
          "cameraTitle": "Capture Back ID",
          "cameraDesc": "Place the back of your ID within the frame.",
          "previewTitle": "Check your Back ID",
          "previewSubtitle": "Make sure details are clear and readable.",
        };

      case VerificationStep.selfie:
        return {
          "title": "Take a Selfie With Your ID",
          "subtitle": "Follow the guidelines for best quality",
          "guidelines": [
            "Hold your ID near your face",
            "Ensure good lighting",
            "Look straight at the camera",
          ],
          // السيلفي لا يحتاج نصوص كاميرا إضافية لأنها ثابتة في الدالة الخاصة به
        };

      default:
        return {};
    }
  }

  Widget _buildCurrentStepBody() {
    switch (currentStep) {
      case VerificationStep.selectType:
        return VerificationTypeSelectionStep(
          selectedIdType: _formData.idType,
          onTypeSelected: (IdType value) {
            setState(() => _formData.idType = value);
          },
          onContinue: nextStep,
        );
      case VerificationStep.frontId:
        return VerificationInstructionView(
          title: "Capture the Front of Your ID",
          subtitle: "Follow the guidelines for best quality",
          guidelines: const [
            "Place the ID inside the frame",
            "Avoid glare, shadows, or blur",
            "Make sure the image is clear and details are readable",
          ],
          onTakePicture:
              () => _handleIdCardCapture(
                cameraTitle: "Capture Front ID",
                cameraDescription:
                    "Place the front of your ID within the frame.",
                previewTitle: "Check your Front ID",
                previewSubtitle: "Make sure details are clear and readable.",
                onValidated: (imagePath) {
                  setState(() => _formData.frontIdPath = imagePath); // ✅ للوجه
                  print("✅ Front ID Validated & Saved");
                  nextStep();
                },
              ),
        );

      case VerificationStep.backId:
        return VerificationInstructionView(
          title: "Capture the Back of Your ID",
          subtitle: "Follow the guidelines for best quality",
          guidelines: const [
            "Flip your ID card to the back side",
            "Avoid glare, shadows, or blur",
            "Make sure the image is clear",
          ],
          onTakePicture:
              () => _handleIdCardCapture(
                cameraTitle: "Capture Back ID",
                cameraDescription:
                    "Place the back of your ID within the frame.",
                previewTitle: "Check your Back ID",
                previewSubtitle: "Make sure details are clear and readable.",
                onValidated: (imagePath) {
                  setState(() => _formData.backIdPath = imagePath); // ✅ للظهر
                  print("✅ Back ID Validated & Saved");
                  nextStep();
                },
              ),
        );

      case VerificationStep.selfie:
        return VerificationInstructionView(
          title: "Take a Selfie With Your ID",
          subtitle: "Follow the guidelines for best quality",
          guidelines: const [
            "Hold your ID near your face",
            "Ensure good lighting on your face",
            "Look straight at the camera",
          ],
          onTakePicture:
              () => _handleSelfieCapture(
                onValidated: (imagePath) {
                  setState(() => _formData.selfiePath = imagePath); // ✅ للسيلفي
                  nextStep();
                },
              ),
        );

      case VerificationStep.success:
        return VerificationSuccessStep(onGoHome: () => Navigator.pop(context));
    }
  }
}
