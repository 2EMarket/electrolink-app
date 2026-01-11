import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_theme.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/custom_popup.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/notification_toast.dart';
// تأكد من عمل import لملف الودجت الذي أنشأناه
// import 'package:second_hand_electronics_marketplace/widgets/dynamic_notification_toast.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('ElectroLink')),
        body: Center(
          child: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  NotificationToast.show(
                    context,
                    "Image too large",
                    "Please upload an image smaller than 5 MB",
                    ToastType.error,
                  );
                  // CustomPopup.show(
                  //   context,
                  //   iconPath: AppAssets.popupWarning,
                  //   title: "Leave this listing?",
                  //   description:
                  //   "Your changes are saved automatically. You can continue editing later.",
                  //   primaryText: "Leave",
                  //   onPrimaryPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   secondaryText: "Continue editing",
                  // );
                },
                child: const Text('Show Toast'),
              );
            },
          ),
        ),
      ),
    );
  }
}