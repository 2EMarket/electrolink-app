import 'package:flutter/material.dart';
import '../../configs/theme/theme_exports.dart';
import '../constants/constants_exports.dart';

class TextAreaInputsDescriptionField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isRequired;
  final int maxChars;
  final int maxLines;
  final String? Function(String?)? validator;
  final void Function(String value)? onChanged;

  const TextAreaInputsDescriptionField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isRequired = false,
    this.maxChars = 500,
    this.maxLines = 6,
    this.validator,
    this.onChanged,
  });

  @override
  State<TextAreaInputsDescriptionField> createState() =>
      _TextAreaInputsDescriptionFieldState();
}

class _TextAreaInputsDescriptionFieldState
    extends State<TextAreaInputsDescriptionField> {
  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      borderSide: BorderSide(width: 1, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: EdgeInsets.all(AppSizes.paddingM),
      child: Container(
        height: 187,
        width: 358,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(widget.label, style: AppTypography.body14Regular),
                if (widget.isRequired) ...[
                  SizedBox(width: AppSizes.paddingXXS),
                  Text('*', style: TextStyle(color: colors.error)),
                ],
              ],
            ),
            SizedBox(height: AppSizes.paddingXS),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                SizedBox(
                  height: 135,
                  child: TextFormField(
                    controller: widget.controller,
                    maxLines: widget.maxLines,
                    maxLength: widget.maxChars,
                    validator: widget.validator,
                    onChanged: (value) {
                      setState(() {});
                      widget.onChanged?.call(value);
                    },
                    /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },*/
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      contentPadding: EdgeInsets.all(AppSizes.paddingM),
                      filled: true,
                      fillColor: colors.surface,
                      counterText: '',
                      // Borders
                      border: _border(colors.border),
                      enabledBorder: _border(colors.border),
                      focusedBorder: _border(colors.mainColor),
                      errorBorder: _border(colors.error),
                      focusedErrorBorder: _border(colors.error),
                    ),
                  ),
                ),
                Positioned(
                  left: 385 - 110,
                  bottom: 2.1 * AppSizes.paddingS,
                  right: AppSizes.paddingM,
                  child: Container(
                    height: 15,
                    width: 326,
                    child: Column(
                      children: [
                        Text(
                          '(${widget.controller.text.length} / ${widget.maxChars})',
                          style: AppTypography.label10Regular,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
