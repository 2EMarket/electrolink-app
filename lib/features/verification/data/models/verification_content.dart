// تأكدي من مسار ملف IdType عندك
import '../../data/enums/id_type.dart';

enum VerificationStep { selectType, frontId, backId, selfie, success }

class VerificationStepContent {
  final String title;
  final String subtitle;
  final List<String> guidelines;
  final String cameraTitle;
  final String cameraDesc;
  final String previewTitle;
  final String previewSubtitle;

  const VerificationStepContent({
    required this.title,
    required this.subtitle,
    required this.guidelines,
    this.cameraTitle = "",
    this.cameraDesc = "",
    this.previewTitle = "",
    this.previewSubtitle = "",
  });
}

extension VerificationStepExtension on VerificationStep {
  VerificationStepContent getContent(IdType type) {
    String docName;
    switch (type) {
      case IdType.passport:
        docName = "Passport";
        break;
      case IdType.driverLicense:
        docName = "Driver's License";
        break;
      case IdType.idCard:
        docName = "ID Card";
        break;
    }

    switch (this) {
      case VerificationStep.frontId:
        return VerificationStepContent(
          title: "Capture the Front of Your $docName",
          subtitle:
              type == IdType.passport
                  ? "Open the photo page of your passport"
                  : "Follow the guidelines for best quality",
          guidelines: [
            "Place the $docName inside the frame",
            "Avoid glare, shadows, or blur",
            "Make sure details are readable",
          ],
          cameraTitle: "Capture Front $docName",
          cameraDesc:
              "Place the $docName inside the frame and make sure the image is clear.",
          previewTitle: "Check your Front $docName",
          previewSubtitle: "Make sure details are clear and readable.",
        );

      case VerificationStep.backId:
        return VerificationStepContent(
          title: "Capture the Back of Your $docName",
          subtitle: "Follow the guidelines for best quality",
          guidelines: [
            "Flip your $docName to the back side",
            "Avoid glare, shadows, or blur",
            "Make sure the image is clear",
          ],
          cameraTitle: "Capture Back $docName",
          cameraDesc: "Place the back of your $docName within the frame.",
          previewTitle: "Check your Back $docName",
          previewSubtitle: "Make sure details are clear and readable.",
        );

      case VerificationStep.selfie:
        return VerificationStepContent(
          title: "Take a Selfie With Your $docName",
          subtitle: "Follow the guidelines for best quality",
          guidelines: [
            "Hold your $docName near your face",
            "Ensure good lighting",
            "Look straight at the camera",
          ],
        );

      default:
        return const VerificationStepContent(
          title: "",
          subtitle: "",
          guidelines: [],
        );
    }
  }
}
