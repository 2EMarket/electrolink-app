import 'package:flutter/material.dart';
import 'configs/theme/theme_exports.dart';
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

    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Second Hand Electronics Marketplace')),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextInputsPhoneField(
                controller: _phoneController,
                validator: (value) {
                  if ( value == null || value.trim().isEmpty) {
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
        ),
      ),

      // body: Center(
      //   child: ElevatedButton(onPressed: () {}, child: Text('hi')),
      // ),
    );
  }
}
