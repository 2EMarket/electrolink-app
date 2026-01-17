import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart'; // ✅ استدعاء المكتبة
import 'package:flutter_svg/svg.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/search_widget.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/widgets/location_bottomsheet.dart';

class CountrySelectionScreen extends StatefulWidget {
  const CountrySelectionScreen({super.key});

  @override
  State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  List<Country> _allCountries = [];
  List<Country> _filteredCountries = [];
  Country? _selectedCountry;
  final TextEditingController _searchController = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _allCountries = CountryService().getAll();
    _filteredCountries = _allCountries;

    _searchController.addListener(() {
      setState(() {
        _showClearButton = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _runFilter(String enteredKeyword) {
    List<Country> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allCountries;
    } else {
      results =
          _allCountries
              .where(
                (country) =>
                    country.name.toLowerCase().contains(
                      enteredKeyword.toLowerCase(),
                    ) ||
                    country.displayName.toLowerCase().contains(
                      enteredKeyword.toLowerCase(),
                    ),
              )
              .toList();
    }
    setState(() {
      _filteredCountries = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.country), leading: null),
        body: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.chooseYourCountry,
                style: AppTypography.h3_18Medium.copyWith(
                  color: context.colors.titles,
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),
              SearchWidget(
                controller: _searchController,
                onChanged: _runFilter,
              ),
              const SizedBox(height: AppSizes.paddingL),
              Expanded(
                child:
                    _filteredCountries.isEmpty
                        ? Center(
                          child: Text(
                            AppStrings.noCountry,
                            style: AppTypography.body16Regular.copyWith(
                              color: context.colors.text,
                            ),
                          ),
                        )
                        : ListView.separated(
                          itemCount: _filteredCountries.length,
                          separatorBuilder:
                              (context, index) =>
                                  const SizedBox(height: AppSizes.paddingM),
                          itemBuilder: (context, index) {
                            final country = _filteredCountries[index];
                            final isSelected =
                                _selectedCountry?.countryCode ==
                                country.countryCode;

                            return _buildCountryPickerItem(
                              country,
                              context,
                              isSelected,
                            );
                          },
                        ),
              ),

              if (_selectedCountry != null) ...[
                const SizedBox(height: AppSizes.paddingM),
                _buildConfirmButton(),
                const SizedBox(height: AppSizes.paddingM),
              ],
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          print("Selected Country: ${_selectedCountry!.name}");
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const LocationPermissionSheet(),
          );
        },
        child: Text(AppStrings.confirm),
      ),
    );
  }

  GestureDetector _buildCountryPickerItem(
    Country country,
    BuildContext context,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCountry = country;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingM,
          vertical: AppSizes.paddingS,
        ),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          border: Border.all(
            color:
                isSelected ? context.colors.mainColor : context.colors.border,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                country.name,
                style: AppTypography.body16Regular.copyWith(
                  color: isSelected ? context.colors.text : context.colors.hint,

                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected
                          ? context.colors.mainColor
                          : context.colors.placeholders,
                  width: 1.5,
                ),
              ),
              child:
                  isSelected
                      ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: context.colors.mainColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
