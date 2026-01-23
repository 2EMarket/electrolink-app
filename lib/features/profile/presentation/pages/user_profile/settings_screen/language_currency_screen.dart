import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../configs/theme/theme_exports.dart';
import '../../../../../../core/constants/constants_exports.dart';

/// ---------------------------
/// Reusable Decorated ListTile
/// ---------------------------
class _DecoratedListTile extends StatelessWidget {
  final String title;
  final String trailingValue;
  final VoidCallback onTap;

  const _DecoratedListTile({
    required this.title,
    required this.trailingValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _tileDecoration(context),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: AppSizes.paddingXS,
          horizontal: AppSizes.paddingS,
        ),
        title: Text(
          title,
          style: AppTypography.body16Regular.copyWith(
            color: context.colors.text,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              trailingValue,
              style: AppTypography.body14Regular.copyWith(
                color: context.colors.hint,
              ),
            ),
            const SizedBox(width: AppSizes.paddingXS),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: onTap,
              icon: Icon(
                Icons.arrow_forward_ios,
                size: AppSizes.paddingL,
                color: context.colors.icons,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _tileDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.colors.background,
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      border: Border.all(color: context.colors.border, width: 0.1),
      boxShadow: [
        BoxShadow(
          color: context.colors.border,
          blurRadius: 2,
          spreadRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }
}

/// ---------------------------
/// Language & Currency Screen
/// ---------------------------
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
            _DecoratedListTile(
              title: 'App language',
              trailingValue: selectedLanguage, // ✅ هنا مربوط بالـ state
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
            _DecoratedListTile(
              title: 'Currency display',
              trailingValue: selectedCurrency, // ✅ مرتبط بالـ state
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

/// ---------------------------
/// Selection Tile
/// ---------------------------
class SelectionTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const SelectionTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.paddingS,
          horizontal: AppSizes.paddingM,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          border: Border.all(
            color: selected ? context.colors.mainColor : context.colors.border,
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Text(title, style: AppTypography.body16Regular)),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? context.colors.mainColor : context.colors.icons,
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------
/// Language Screen
/// ---------------------------
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'system';

  @override
  Widget build(BuildContext context) {
    return _BaseSelectionScreen(
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
    return SelectionTile(
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

/// ---------------------------
/// Currency Screen
/// ---------------------------
class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String selectedCurrency = 'ILS';

  @override
  Widget build(BuildContext context) {
    return _BaseSelectionScreen(
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
    return SelectionTile(
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

/// ---------------------------
/// Base Selection Screen
/// ---------------------------
class _BaseSelectionScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  const _BaseSelectionScreen({
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: AppTypography.h3_18Medium.copyWith(
                color: context.colors.titles,
              ),
            ),
            const SizedBox(height: AppSizes.paddingM),
            ...children,
          ],
        ),
      ),
    );
  }
}
