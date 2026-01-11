import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../configs/theme/theme_exports.dart';

class TextInputsPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  final int maxChars;

  const TextInputsPhoneField({
    super.key,
    required this.controller,
    this.maxChars = 9,
    this.validator,
  });

  @override
  State<TextInputsPhoneField> createState() => _TextInputsPhoneFieldState();
}

class _TextInputsPhoneFieldState extends State<TextInputsPhoneField> {
  Country _selectedCountry = Country.parse('PS'); // فلسطين افتراضي
  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      showSearch: true,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });
      },
    );
  }

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
              Text('Phone number', style: AppTypography.body14Regular),
              SizedBox(width: 5),
              Text('*', style: TextStyle(color: AppColors.error)),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: widget.controller,
              maxLength: widget.maxChars,
              validator: widget.validator,
              /*
                   validator: (value) {
                  if ( value == null || value.trim().isEmpty) {
                    return 'The number is wrong';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Only numbers are allowed';
                  }
                  return null;
                },
                    */
              decoration: InputDecoration(
                prefixIcon: GestureDetector(
                  onTap: _openCountryPicker,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_selectedCountry.flagEmoji),
                        const SizedBox(width: 6),
                        Text(
                          '+${_selectedCountry.phoneCode}',
                          style: AppTypography.body15Regular,
                        ),
                        const Icon(Icons.keyboard_arrow_down, size: 18),
                      ],
                    ),
                  ),
                ),

                hintText: 'Enter your phone number',
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
