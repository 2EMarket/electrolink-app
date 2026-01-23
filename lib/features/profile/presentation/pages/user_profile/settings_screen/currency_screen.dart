import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/settings_widgets/language_currency_base_selection.dart';
import '../../../widgets/settings_widgets/language_currency_section_tile.dart';
class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String selectedCurrency = 'ILS';

  @override
  Widget build(BuildContext context) {
    return LanguageCurrencyBaseSelectionWidget(
      title: 'Currency display',
      subtitle: 'Select your currency',
      children: [
        _currencyTile('ILS'),
        _currencyTile('USD'),
        _currencyTile('JOD'),
      ],
    );
  }

  Widget _currencyTile(String value) {
    return LanguageCurrencySelectionTile(
      title: value,
      selected: selectedCurrency == value,
      onTap: () {
        setState(() => selectedCurrency = value); // نحدد العنصر
        Future.delayed(const Duration(milliseconds: 600), () {
          context.pop(value); // ترجع القيمة بعد 0.3 ثانية
        });
      },
    );
  }
}

