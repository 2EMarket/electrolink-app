import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/notification_card.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/notifications_list.dart';
import 'configs/theme/theme_exports.dart';
import 'core/widgets/app_notification.dart';
import 'core/widgets/notification_overlay.dart';
import 'core/widgets/otp_input_field.dart';
import 'core/widgets/search&filter.dart';
import 'core/widgets/widgets_exports.dart';
import 'imports.dart';

class AmalsApp extends StatelessWidget {
  const AmalsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _descriptionController = TextEditingController();
    final _nameController = TextEditingController();
    final _phoneController = TextEditingController();
    //new change on my branch
    final service = NotificationService();

    final notification =    AppNotification(
      id: '2',
      title: 'email Verified',
      message: 'Your email has been verified',
      type: NotificationType.emailVerified,
    );

    final notification2 =    AppNotification(
      id: '1',
      title: 'New Message',
      message: 'You received a new message',
      type: NotificationType.newMessage,
    );
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home:  Builder(
        builder: (context) {
          return  Scaffold(
            body: Center(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {
                      service.addNotification(notification);
                      service.addNotification(notification2);

                      NotificationOverlay.show(context, notification2);
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ), /*
        Scaffold(
        appBar: AppBar(title: Text('Second Hand Electronics Marketplace')),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextInputsPhoneField(
                controller: _phoneController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'The number is wrong';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Only numbers are allowed';
                  }
                  if (value.length < 9) {
                    return 'The number is wrong';
                  }
                  return null;
                },
              ),
              TextAreaInputsDescriptionField(
                controller: _descriptionController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              TextInputsUsernameField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter Your Name';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // submit logic
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),)*/

      // body: Center(
      //   child: ElevatedButton(onPressed: () {}, child: Text('hi')),
      // ),
    );
  }
}
