import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/constants/constants_exports.dart';
import '../../../widgets/settings_widgets/language_currency_decorated_tile.dart';

class LanguageCurrencyScreen extends StatefulWidget {
  const LanguageCurrencyScreen({super.key});

  @override
  State<LanguageCurrencyScreen> createState() => _LanguageCurrencyScreenState();
}

class _LanguageCurrencyScreenState extends State<LanguageCurrencyScreen> {
  String selectedLanguage = 'English';
  String selectedCurrency = 'ILS';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Language & Currency')),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          children: [
            LanguageCurrencyDecoratedListTile(
              title: 'App language',
              trailingValue: selectedLanguage,
              onTap: () async {
                final result = await context.pushNamed(AppRoutes.language);
                if (result != null) {
                  setState(() {
                    selectedLanguage = _mapLanguage(result as String);
                  });
                }
              },
            ),
            const SizedBox(height: AppSizes.paddingS),
            LanguageCurrencyDecoratedListTile(
              title: 'Currency display',
              trailingValue: selectedCurrency,
              onTap: () async {
                final result = await context.pushNamed(AppRoutes.currency);
                if (result != null) {
                  setState(() {
                    selectedCurrency = result as String;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String _mapLanguage(String value) {
    switch (value) {
      case 'ar':
        return 'Arabic';
      case 'en':
        return 'English';
      default:
        return 'System';
    }
  }
}
