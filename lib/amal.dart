import 'package:flutter/material.dart';
import 'configs/theme/theme_exports.dart';
import 'imports.dart';

class AmalsApp extends StatelessWidget {
  const AmalsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
     // home: Scaffold(body: ()),

      /* final _formKey = GlobalKey<FormState>();
    final _descriptionController = TextEditingController();
    final usernameController = TextEditingController();
    final _phoneController = TextEditingController();
    //new change on my branch
    final service = NotificationService();

    final notification = AppNotification(
      id: '2',
      title: 'email Verified',
      message: 'Your email has been verified',
      type: NotificationType.emailVerified,
    );

    final notification2 = AppNotification(
      id: '1',
      title: 'New Message',
      message: 'You received a new message',
      type: NotificationType.newMessage,
    );*/

      /*Builder(
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
      ), */
      /*    Scaffold(
        appBar: AppBar(title: Text('Second Hand Electronics Marketplace')),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                OtpInputField(),
                TextInputsPhoneField(
                  controller: _phoneController,
                  label: 'Phone number',
                  hint: 'Enter your phone number',
                  isRequired: true,
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
                  onCountryChanged: (country) {
                    print('Country code: +${country.phoneCode}');
                  },
                  onChanged: (value) {
                    print('Phone without code: $value');
                  },
                ),
                TextAreaInputsDescriptionField(
                  controller: _descriptionController,
                  label: 'Description',
                  hint: 'Enter your description',
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                TextInputsUsernameField(
                  controller: usernameController,
                  label: 'Username',
                  hint: 'Enter your name',
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your username';
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
          ),
        ),
      ), */
    );
  }
}
