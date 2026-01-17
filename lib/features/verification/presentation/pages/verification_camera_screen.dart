import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'camera_overlay_painter.dart'; // استدعاء الرسام

class VerificationCameraScreen extends StatefulWidget {
  final String title;
  final String description;
  final CameraLensDirection cameraLensDirection;
  const VerificationCameraScreen({
    super.key,
    required this.title,
    required this.description,
    this.cameraLensDirection = CameraLensDirection.back,
  });

  @override
  State<VerificationCameraScreen> createState() =>
      _VerificationCameraScreenState();
}

class _VerificationCameraScreenState extends State<VerificationCameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isTakingPicture = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    // نختار الكاميرا بناءً على المتغير الذي مررناه (أمامية أو خلفية)
    final selectedCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == widget.cameraLensDirection,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      selectedCamera, // 👈 استخدام الكاميرا المختارة
      ResolutionPreset.high,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // دالة التقاط الصورة
  Future<void> _takePicture() async {
    if (_isTakingPicture ||
        _controller == null ||
        !_controller!.value.isInitialized)
      return;

    try {
      setState(() => _isTakingPicture = true);

      final image = await _controller!.takePicture();

      // هنا: الصورة التقطت! سنرجع المسار للشاشة السابقة
      if (mounted) {
        Navigator.pop(context, image.path);
      }
    } catch (e) {
      print(e);
    } finally {
      if (mounted) setState(() => _isTakingPicture = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              _controller != null) {
            return Stack(
              fit: StackFit.expand,
              children: [
                // 1. بث الكاميرا (يملأ الشاشة)
                CameraPreview(_controller!),

                // 2. طبقة الرسم (Overlay)
                CustomPaint(painter: CameraOverlayPainter()),

                // 3. واجهة المستخدم (أزرار ونصوص)
                SafeArea(
                  child: Column(
                    children: [
                      // زر إغلاق في الأعلى
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // العناوين
                      Text(
                        widget.title,
                        style: AppTypography.h3_18Medium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          widget.description,
                          textAlign: TextAlign.center,
                          style: AppTypography.body14Regular.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ),

                      const Spacer(),

                      // منطقة التصوير
                      if (_isTakingPicture)
                        const CircularProgressIndicator(color: Colors.white)
                      else
                        GestureDetector(
                          onTap: _takePicture,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
