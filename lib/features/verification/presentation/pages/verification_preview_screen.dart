import 'dart:io';
import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/features/verification/presentation/widgets/camera_overlay_painter.dart';

class VerificationPreviewScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  VerificationPreviewScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. الصورة الملتقطة (بدل الكاميرا)
          Image.file(File(imagePath), fit: BoxFit.cover),

          // 2. طبقة الرسم (Overlay) والإطار
          CustomPaint(painter: CameraOverlayPainter()),

          // 3. الأزرار والنصوص
          SafeArea(
            child: Column(
              children: [
                // زر إغلاق (اختياري)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed:
                        () => Navigator.pop(
                          context,
                        ), // رجوع (كأننا كبسنا Capture Again)
                  ),
                ),

                const SizedBox(height: 20),

                // العناوين
                Text(
                  title,
                  style: AppTypography.h3_18Medium.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: AppTypography.body14Regular.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ),

                const Spacer(),

                // 4. أزرار التحكم (Continue & Capture Again)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingM,
                  ),
                  child: Column(
                    children: [
                      // زر المتابعة
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // نرجع true للشاشة الرئيسية (يعني وافقنا)
                            Navigator.pop(context, true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.colors.mainColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Continue to Next Step",
                            style: AppTypography.body16Medium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // زر إعادة التصوير
                      TextButton(
                        onPressed: () {
                          // نرجع null أو false (يعني بدنا نعيد)
                          Navigator.pop(context, null);
                        },
                        child: Text(
                          "Capture again",
                          style: AppTypography.body14Medium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
