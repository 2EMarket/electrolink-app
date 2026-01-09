import 'package:flutter/material.dart';
import '../../configs/theme/theme_exports.dart';

class TextAreaInputsDescriptionField extends StatefulWidget {
  const TextAreaInputsDescriptionField({
    super.key,
    this.validator,
    required this.controller,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  State<TextAreaInputsDescriptionField> createState() =>
      _TextAreaInputsDescriptionFieldState();
}

class _TextAreaInputsDescriptionFieldState
    extends State<TextAreaInputsDescriptionField> {
  static const maxChars = 500;

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
          const SizedBox(height: 50),
          Text('Description', style: AppTypography.body14Regular),
          const SizedBox(height: 8),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 140,
                child: TextFormField(
                  controller: widget.controller,

                  onChanged: (_) => setState(() {}),
                  maxLines: 6,
                  maxLength: maxChars,
                  validator: widget.validator,
                  /*  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },*/
                  decoration: InputDecoration(
                    hintText: 'Enter your description',
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
              Positioned(
                bottom: 12,
                right: 14,
                child: Column(
                  children: [
                    Text(
                      '(${widget.controller.text.length} / $maxChars)',
                      style: AppTypography.label10Regular,
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
