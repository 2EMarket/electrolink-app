import 'dart:ui'; // ضروري عشان PathMetric
import 'package:flutter/material.dart';

class CameraOverlayPainter extends CustomPainter {
  final Color overlayColor;

  CameraOverlayPainter({
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 255), // أسود شفاف 70%
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 👇👇 هنا التعديلات (كبرنا المساحة)
    final double margin = 12.0; // قللنا الهوامش الجانبية
    final double width = size.width - (margin * 2);
    final double height =
        width * 0.80; // زدنا الطول (نسبة 0.80 ممتازة للوجه والهوية)

    // تحديد مكان المستطيل في المنتصف
    final Rect cutoutRect = Rect.fromCenter(
      center: Offset(
        size.width / 2,
        size.height / 2 - 40,
      ), // -40 لرفعه قليلاً للأعلى
      width: width,
      height: height,
    );

    // 2. رسم الخلفية السوداء مع "قص" المستطيل
    final Path backgroundPath =
        Path()..addRect(
          Rect.fromLTWH(0, 0, size.width, size.height),
        ); // الشاشة كاملة

    final Path cutoutPath =
        Path()..addRRect(
          RRect.fromRectAndRadius(cutoutRect, const Radius.circular(12)),
        ); // المستطيل المقصوص

    // عملية الطرح: خلفية - مستطيل = خلفية بفتحة
    final Path finalPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final Paint paint =
        Paint()
          ..color = overlayColor
          ..style = PaintingStyle.fill;

    canvas.drawPath(finalPath, paint);

    // 3. رسم الإطار الأبيض المتقطع (Dashed Border)
    final Paint borderPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    _drawDashedRect(
      canvas,
      borderPaint,
      RRect.fromRectAndRadius(cutoutRect, const Radius.circular(12)),
    );
  }

  // دالة مساعدة لرسم الخط المتقطع
  void _drawDashedRect(Canvas canvas, Paint paint, RRect rrect) {
    Path path = Path()..addRRect(rrect);

    // خوارزمية التقطيع
    Path dashPath = Path();
    double dashWidth = 10.0;
    double dashSpace = 5.0;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
