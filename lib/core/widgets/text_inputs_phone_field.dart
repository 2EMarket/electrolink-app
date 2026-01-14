import 'package:flutter/material.dart';
import '../../configs/theme/theme_exports.dart';
import '../../imports.dart';
import '../constants/constants_exports.dart';

class TextInputsPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isRequired;
  final int maxChars;
  final Country? initialCountry;
  final String? Function(String?)? validator;
  final void Function(Country country)? onCountryChanged;
  final void Function(String value)? onChanged;

  TextInputsPhoneField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isRequired = false,
    this.maxChars = 9,
    this.initialCountry,
    this.onChanged,
    this.validator,
    this.onCountryChanged,
  });

  @override
  State<TextInputsPhoneField> createState() => _TextInputsPhoneFieldState();
}

class _TextInputsPhoneFieldState extends State<TextInputsPhoneField> {
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry ?? Country.parse('PS');
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      showSearch: true,
      onSelect: (Country country) {
        setState(() => _selectedCountry = country);
        widget.onCountryChanged?.call(country);
      },
    );
  }

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
                Text(widget.label, style: AppTypography.body14Regular),
                if (widget.isRequired) ...[
                  const SizedBox(width: AppSizes.paddingXXS),
                  Text('*', style: TextStyle(color: AppColors.error)),
                ],
              ],
            ),
            SizedBox(height: AppSizes.paddingXS),
            SizedBox(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: widget.controller,
                maxLength: widget.maxChars,
                validator: widget.validator,
                onChanged: widget.onChanged,
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
                        ],
                      ),
                    ),
                  ),

                  hintText: widget.hint,
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
