import 'package:flutter_image_compress/flutter_image_compress.dart'; // 👈 1. ضفنا مكتبة الضغط
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// Service class responsible for identity verification validation logic.
/// Handles ML Kit operations for ID card and selfie validation.
class VerificationService {
  /// Validates an ID card image by checking if it contains readable text.
  Future<bool> validateIdCard(String imagePath) async {
    // 1. Initialize text recognizer
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage = InputImage.fromFilePath(imagePath);

    try {
      // 2. Extract text from the image
      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );

      // Clean up memory (important)
      await textRecognizer.close();

      // 3. Analyze results (logic)
      String text = recognizedText.text.trim();

      // Condition 1: Is the image completely empty?
      if (text.isEmpty) {
        return false;
      }

      // Condition 2: Is the text amount too little? (Blurry or too far)
      if (text.length < 10) {
        return false;
      }

      // (Optional) Print text for debugging
      print(
        "✅ ID Text Detected: ${text.substring(0, text.length > 50 ? 50 : text.length)}...",
      );

      return true; // Image is accepted
    } catch (e) {
      print("Error in ID validation: $e");
      return false;
    }
  }

  /// Validates a selfie image by checking for face detection and quality.
  Future<bool> validateSelfie(String imagePath) async {
    // 1. Prepare the detector
    final options = FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    );
    final faceDetector = FaceDetector(options: options);

    // 2. Convert image to format understood by AI
    final inputImage = InputImage.fromFilePath(imagePath);

    try {
      // 3. Process the image
      final List<Face> faces = await faceDetector.processImage(inputImage);

      // 4. Close detector for memory
      await faceDetector.close();

      // --- Conditions (Logic) ---

      // Condition A: Is there a face at all?
      if (faces.isEmpty) {
        return false;
      }

      // Condition B: Is there more than one face?
      if (faces.length > 1) {
        return false;
      }

      // Condition C: Check "face angle"
      final Face face = faces.first;
      if (face.headEulerAngleY! > 15 || face.headEulerAngleY! < -15) {
        return false;
      }

      // If all conditions passed -> image is excellent ✅
      return true;
    } catch (e) {
      print("Error in face detection: $e");
      return false;
    }
  }

  /// 👇👇 2. دالة ضغط الصور الجديدة
  /// Compresses the image file to reduce size before uploading.
  /// Returns the path of the compressed image, or null if compression fails.
  Future<String?> compressImage(String path) async {
    // Create a new path with '_compressed' suffix
    final targetPath = path.replaceFirst('.jpg', '_compressed.jpg');

    try {
      var result = await FlutterImageCompress.compressAndGetFile(
        path,
        targetPath,
        quality: 70, // Keep 70% quality (Good balance)
        minWidth: 1024, // Resize to decent width
        minHeight: 1024,
      );

      return result?.path;
    } catch (e) {
      print("Error compressing image: $e");
      return null; // Return null or original path based on your preference
    }
  }
}
