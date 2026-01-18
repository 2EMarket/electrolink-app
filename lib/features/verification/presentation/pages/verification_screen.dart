import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/features/verification/presentation/pages/verification_camera_screen.dart';
import 'package:second_hand_electronics_marketplace/features/verification/presentation/pages/verification_instruction_view.dart';
import 'package:second_hand_electronics_marketplace/features/verification/presentation/pages/verification_preview_screen.dart';

// 1. Enum عشان نعرف شو الخطوة الحالية
enum VerificationStep { selectType, frontId, backId, selfie, success }

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // ... داخل _VerificationScreenState
  String? frontIdPath;
  String? backIdPath;
  String? selfiePath;
  VerificationStep currentStep = VerificationStep.selectType;
  String? selectedIdType; // 'id_card', 'passport', 'driver_license'

  // دالة لحساب نسبة التقدم (Progress Bar)
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

  // دالة الانتقال للخطوة التالية
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
          Navigator.pop(context); // الرجوع للبروفايل
          break;
      }
    });
  }

  // دالة الرجوع للخطوة السابقة
  void prevStep() {
    if (currentStep == VerificationStep.selectType) {
      Navigator.pop(context);
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

  // ...

  Future<bool> _validateIdCard(String imagePath) async {
    // 1. تعريف المتغيرات
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage = InputImage.fromFilePath(imagePath);

    try {
      // 2. استخراج النصوص من الصورة
      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );

      // تنظيف الذاكرة (مهم جداً)
      await textRecognizer.close();

      // 3. تحليل النتائج (اللوجيك)
      String text = recognizedText.text.trim();

      // الشرط الأول: هل الصورة فارغة تماماً؟ (سوداء أو بدون أي تفاصيل)
      if (text.isEmpty) {
        _showErrorSnackBar(
          "No text detected! Please ensure the ID is clear and well-lit.",
        );
        return false;
      }

      // الشرط الثاني: هل كمية النص قليلة جداً؟
      // الهوية عادة فيها اسم، تاريخ، أرقام.. يعني لازم يكون فيها حروف كثيرة.
      // إذا لقينا أقل من 10 حروف، غالباً الصورة مهزوزة جداً أو بعيدة.
      if (text.length < 10) {
        _showErrorSnackBar(
          "Image is blurry or invalid. Please hold the camera steady.",
        );
        return false;
      }

      // (اختياري) الشرط الثالث: ممكن تطبعي النص عشان تشوفي شو قرأ
      print(
        "✅ ID Text Detected: ${text.substring(0, text.length > 50 ? 50 : text.length)}...",
      );

      return true; // الصورة مقبولة
    } catch (e) {
      print("Error in ID validation: $e");
      _showErrorSnackBar("Validation failed. Please try again.");
      return false;
    }
  }

  Future<bool> _validateSelfie(String imagePath) async {
    // 1. تجهيز الكاشف (Detector)
    final options = FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true, // عشان يشوف العيون والانف (مهم للوضوح)
    );
    final faceDetector = FaceDetector(options: options);

    // 2. تحويل الصورة لصيغة بيفهمها الـ AI
    final inputImage = InputImage.fromFilePath(imagePath);

    try {
      // 3. معالجة الصورة
      final List<Face> faces = await faceDetector.processImage(inputImage);

      // 4. إغلاق الكاشف عشان الذاكرة
      await faceDetector.close();

      // --- الشروط (اللوجيك) ---

      // الشرط أ: هل يوجد وجه أصلاً؟ (بيحل مشكلة الصورة السوداء أو صورة الحيطة)
      if (faces.isEmpty) {
        _showErrorSnackBar(
          "No face detected! Please ensure good lighting and face the camera.",
        );
        return false;
      }

      // الشرط ب: هل يوجد أكثر من وجه؟ (ممنوع حدا يتصور معك)
      if (faces.length > 1) {
        _showErrorSnackBar(
          "Multiple faces detected. Please take a selfie alone.",
        );
        return false;
      }

      // الشرط ج: التحقق من "زاوية الوجه" (عشان نتأكد إنه بتطلع عالكاميرا مش عالجنب)
      final Face face = faces.first;
      if (face.headEulerAngleY! > 15 || face.headEulerAngleY! < -15) {
        _showErrorSnackBar("Please look straight at the camera.");
        return false;
      }

      // إذا عدى كل الشروط -> الصورة ممتازة ✅
      return true;
    } catch (e) {
      print("Error in face detection: $e");
      return false;
    }
  }

  // دالة مساعدة لإظهار رسالة خطأ
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: prevStep, // ربطنا زر الرجوع باللوجيك
        ),
        title: const Text("Identity Verification"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. شريط التقدم (Progress Bar)
          if (currentStep != VerificationStep.success)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingM,
                vertical: AppSizes.paddingS,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progressValue,
                        minHeight: 8,
                        backgroundColor: context.colors.neutral5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.colors.mainColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${(progressValue * 4).toInt()}/4",
                    style: AppTypography.label12Regular.copyWith(
                      color: context.colors.neutral,
                    ),
                  ),
                ],
              ),
            ),

          // 2. محتوى الصفحة المتغير
          Expanded(child: _buildCurrentStepBody()),
        ],
      ),
    );
  }

  // دالة بتعرض الـ Widget المناسب حسب الخطوة
  Widget _buildCurrentStepBody() {
    // داخل دالة _buildCurrentStepBody
    switch (currentStep) {
      // ---------------------------------------------------------
      // الخطوة 1: اختيار نوع الهوية (جاهزة من قبل)
      // ---------------------------------------------------------
      case VerificationStep.selectType:
        return _buildSelectTypeStep();

      // ---------------------------------------------------------
      // الخطوة 2: تصوير وجه الهوية (Front ID)
      // ---------------------------------------------------------
      case VerificationStep.frontId:
        return VerificationInstructionView(
          title: "Capture the Front of Your ID",
          subtitle: "Follow the guidelines for best quality",
          guidelines: const [
            "Place the ID inside the frame",
            "Avoid glare, shadows, or blur",
            "Make sure the image is clear and details are readable",
          ],
          onTakePicture: () async {
            // 1. فتح الكاميرا
            final imagePath = await Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => const VerificationCameraScreen(
                      title: "Capture Front ID",
                      description:
                          "Place the front of your ID within the frame.",
                    ),
              ),
            );

            // 2. إذا رجعنا بصورة -> نفتح المعاينة (Preview)
            if (imagePath != null) {
              final isConfirmed = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => VerificationPreviewScreen(
                        imagePath: imagePath,
                        title: "Check your Front ID",
                        subtitle: "Make sure details are clear and readable.",
                      ),
                ),
              );

              // داخل case VerificationStep.frontId:

              // ... (كود فتح الكاميرا نفسه) ...

              if (imagePath != null) {
                // ... (كود فتح المعاينة نفسه) ...
                final isConfirmed = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => VerificationPreviewScreen(
                          imagePath: imagePath,
                          title: "Check your Front ID",
                          subtitle: "Make sure details are clear and readable.",
                        ),
                  ),
                );

                // 👇👇 هنا اللوجيك الجديد
                if (isConfirmed == true) {
                  // 1. إظهار لودينج (عشان المستخدم يعرف إننا بنفحص)
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (c) => const Center(child: CircularProgressIndicator()),
                  );

                  // 2. استدعاء فحص النصوص
                  final isValid = await _validateIdCard(imagePath);

                  Navigator.pop(context); // إخفاء اللودينج

                  // 3. النتيجة
                  if (isValid) {
                    setState(() => frontIdPath = imagePath); // ✅ حفظنا الصورة
                    print("✅ Front ID Validated & Saved");
                    nextStep(); // للي بعده
                  } else {
                    // ❌ مرفوضة: الـ SnackBar طلعت من الدالة، والمستخدم لسه في مكانه يعيد التصوير
                  }
                }
              }
            }
          },
        );

      // ---------------------------------------------------------
      // الخطوة 3: تصوير ظهر الهوية (Back ID)
      // ---------------------------------------------------------
      case VerificationStep.backId:
        return VerificationInstructionView(
          title: "Capture the Back of Your ID",
          subtitle: "Follow the guidelines for best quality",
          guidelines: const [
            "Flip your ID card to the back side",
            "Avoid glare, shadows, or blur",
            "Make sure the image is clear",
          ],
          onTakePicture: () async {
            // 1. فتح الكاميرا (بنفس الطريقة)
            final imagePath = await Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => const VerificationCameraScreen(
                      title: "Capture Back ID", // 👈 تغيير العنوان
                      description:
                          "Place the back of your ID within the frame.",
                    ),
              ),
            );

            // 2. المعاينة
            if (imagePath != null) {
              final isConfirmed = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => VerificationPreviewScreen(
                        imagePath: imagePath,
                        title: "Check your Back ID", // 👈 تغيير العنوان
                        subtitle: "Make sure details are clear and readable.",
                      ),
                ),
              );

              // داخل case VerificationStep.frontId:

              // ... (كود فتح الكاميرا نفسه) ...

              if (imagePath != null) {
                // ... (كود فتح المعاينة نفسه) ...
                final isConfirmed = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => VerificationPreviewScreen(
                          imagePath: imagePath,
                          title: "Check your Front ID",
                          subtitle: "Make sure details are clear and readable.",
                        ),
                  ),
                );

                // 👇👇 هنا اللوجيك الجديد
                if (isConfirmed == true) {
                  // 1. إظهار لودينج (عشان المستخدم يعرف إننا بنفحص)
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (c) => const Center(child: CircularProgressIndicator()),
                  );

                  // 2. استدعاء فحص النصوص
                  final isValid = await _validateIdCard(imagePath);

                  Navigator.pop(context); // إخفاء اللودينج

                  // 3. النتيجة
                  if (isValid) {
                    setState(() => backIdPath = imagePath); // ✅ حفظنا الصورة
                    print("✅ Back ID Validated & Saved");
                    nextStep(); // للي بعده
                  } else {
                    // ❌ مرفوضة: الـ SnackBar طلعت من الدالة، والمستخدم لسه في مكانه يعيد التصوير
                  }
                }
              }
            }
          },
        );

      // ---------------------------------------------------------
      // الخطوة 4: تصوير السيلفي (Selfie)
      // ---------------------------------------------------------
      case VerificationStep.selfie:
        return VerificationInstructionView(
          title: "Take a Selfie With Your ID",
          subtitle: "Follow the guidelines for best quality",
          guidelines: const [
            "Hold your ID near your face",
            "Ensure good lighting on your face",
            "Look straight at the camera",
          ],
          onTakePicture: () async {
            // 1. فتح الكاميرا (مع تحديد أنها أمامية)
            final imagePath = await Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => const VerificationCameraScreen(
                      title: "Take a Selfie",
                      description: "Hold your ID and look at the camera.",
                      cameraLensDirection:
                          CameraLensDirection.front, // 👈 🤳 هنا السحر!
                    ),
              ),
            );
            // 2. المعاينة
            if (imagePath != null) {
              final isConfirmed = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => VerificationPreviewScreen(
                        imagePath: imagePath,
                        title: "Check your Selfie", // 👈 تغيير العنوان
                        subtitle: "Is your face and ID clear?",
                      ),
                ),
              );

              // 3. الحفظ
              if (isConfirmed == true) {
                // 1. إظهار لودينج بسيط للمستخدم (اختياري بس حلو)
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder:
                      (c) => const Center(child: CircularProgressIndicator()),
                );

                // 2. استدعاء الفحص
                final isValid = await _validateSelfie(imagePath);

                Navigator.pop(context); // إخفاء اللودينج

                // 3. اتخاذ القرار
                if (isValid) {
                  setState(() => selfiePath = imagePath);
                  nextStep(); // ✅ الصورة مقبولة
                } else {
                  // ❌ الصورة مرفوضة (الـ SnackBar رح تطلع وتوضح السبب)
                  // المستخدم رح يضل في نفس الصفحة عشان يعيد التصوير
                }
              }
            }
          },
        );

      // ---------------------------------------------------------
      // الخطوة 5: شاشة النجاح (Under Review)
      // ---------------------------------------------------------
      case VerificationStep.success:
        return _buildSuccessScreen();
    }
  }

  // شاشة النجاح المؤقتة
  Widget _buildSuccessScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, size: 80, color: Colors.green),
          SizedBox(height: 16),
          Text("Under Review", style: AppTypography.h3_18Medium),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Go Home"),
          ),
        ],
      ),
    );
  }

  // --------- تصميم الخطوة الأولى: اختيار النوع ---------
  Widget _buildSelectTypeStep() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select your ID type", style: AppTypography.body16Medium),
          const SizedBox(height: AppSizes.paddingM),

          _buildRadioOption("ID Card", "id_card"),
          const SizedBox(height: AppSizes.paddingS),
          _buildRadioOption("Passport", "passport"),
          const SizedBox(height: AppSizes.paddingS),
          _buildRadioOption("Driver's License", "driver_license"),

          const Spacer(),

          // زر المتابعة
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  selectedIdType != null
                      ? nextStep
                      : null, // معطل إذا لم يتم الاختيار

              child: Text("Continue"),
            ),
          ),
          const SizedBox(height: AppSizes.paddingL),
        ],
      ),
    );
  }

  // ويدجت صغير لخيارات الراديو
  Widget _buildRadioOption(String label, String value) {
    final isSelected = selectedIdType == value;
    return GestureDetector(
      onTap: () => setState(() => selectedIdType = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? context.colors.mainColor : context.colors.neutral5,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTypography.body14Medium),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color:
                  isSelected
                      ? context.colors.mainColor
                      : context.colors.neutral,
            ),
          ],
        ),
      ),
    );
  }
}
