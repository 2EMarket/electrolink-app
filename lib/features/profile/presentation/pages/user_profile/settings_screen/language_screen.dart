import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/settings_widgets/language_currency_base_selection.dart';
import '../../../widgets/settings_widgets/language_currency_section_tile.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'system';

  @override
  Widget build(BuildContext context) {
    return LanguageCurrencyBaseSelectionWidget(
      title: 'App language',
      subtitle: 'Select your app language',
      children: [
        _languageTile('Follow system language', 'system'),
        _languageTile('Arabic', 'ar'),
        _languageTile('English', 'en'),
      ],
    );
  }

  Widget _languageTile(String title, String value) {
    return LanguageCurrencySelectionTile(
      title: title,
      selected: selectedLanguage == value,
      onTap: () {
        setState(() => selectedLanguage = value); // نحدد العنصر
        Future.delayed(const Duration(milliseconds: 600), () {
          context.pop(value); // ترجع القيمة بعد 0.3 ثانية
        });
      },
    );
  }
}
