import 'package:flutter/material.dart';
import '../../configs/theme/theme_exports.dart';
import '../constants/constants_exports.dart';

class TextInputsUsernameField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final String hint;
  final bool isRequired;
  final int maxChars;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;

  const TextInputsUsernameField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isRequired = false,
    this.maxChars = 50,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
  });

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      borderSide: BorderSide(width: 1, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: AppSizes.paddingM,
        left: AppSizes.paddingM,
        top: AppSizes.paddingM,
        bottom: AppSizes.paddingM,
      ),
      child: Container(
        height: 115.0,
        width: 358,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(label, style: AppTypography.body14Regular),
                if (isRequired) ...[
                  SizedBox(width: AppSizes.paddingXXS),
                  Text('*', style: TextStyle(color: AppColors.error)),
                ],
              ],
            ),
            SizedBox(height: AppSizes.paddingXS),
            SizedBox(
              child: TextFormField(
                controller: controller,
                maxLength: maxChars,
                validator: validator,
                keyboardType: keyboardType,
                onChanged: onChanged,

                /*
                 validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please Enter Your Name';
              }
              return null;
            },
                  */
                decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: const EdgeInsets.all(AppSizes.paddingM),
                  filled: true,
                  fillColor: AppColors.white,
                  counterText: '',
                  border: _border(AppColors.border),
                  enabledBorder: _border(AppColors.border),
                  focusedBorder: _border(AppColors.mainColor),
                  errorBorder: _border(AppColors.error),
                  focusedErrorBorder: _border(AppColors.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
