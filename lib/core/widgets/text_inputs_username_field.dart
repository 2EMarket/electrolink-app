import 'package:flutter/material.dart';
import '../../configs/theme/theme_exports.dart';

class TextInputsUsernameField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  final int maxChars;

  const TextInputsUsernameField({
    super.key,
    required this.controller,
    this.maxChars = 50,
    this.validator,
  });

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 1, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Username', style: AppTypography.body14Regular),
              SizedBox(width: 5),
              Text('*', style: TextStyle(color: AppColors.error)),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextFormField(
              controller: controller,
              maxLength: maxChars,
              validator: validator,
              /*
               validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please Enter Your Name';
            }
            return null;
          },
                */
              decoration: InputDecoration(
                hintText: 'Enter your Name',
                contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                filled: true,
                fillColor: Colors.white,
                counterText: '',
                // Borders
                border: _border(Colors.grey),
                enabledBorder: _border(Colors.grey),
                focusedBorder: _border(Colors.blue),
                errorBorder: _border(Colors.red),
                focusedErrorBorder: _border(Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
