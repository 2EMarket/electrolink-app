// import 'package:flutter/material.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
// import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
// import 'package:second_hand_electronics_marketplace/core/widgets/search_widget.dart';
// import 'package:second_hand_electronics_marketplace/core/widgets/custom_radio_button_item.dart';
// import 'package:second_hand_electronics_marketplace/features/home/presentation/widgets/location_bottomsheet.dart';

// class CountrySelectionScreen extends StatefulWidget {
//   const CountrySelectionScreen({super.key});

//   @override
//   State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
// }

// class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
//   List<Country> _allCountries = [];
//   List<Country> _filteredCountries = [];
//   Country? _selectedCountry;
//   final TextEditingController _searchController = TextEditingController();
//   bool _showClearButton = false;

//   @override
//   void initState() {
//     super.initState();
//     _allCountries = CountryService().getAll();
//     _filteredCountries = _allCountries;

//     _searchController.addListener(() {
//       setState(() {
//         _showClearButton = _searchController.text.isNotEmpty;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _runFilter(String enteredKeyword) {
//     List<Country> results = [];
//     if (enteredKeyword.isEmpty) {
//       results = _allCountries;
//     } else {
//       results =
//           _allCountries
//               .where(
//                 (country) =>
//                     country.name.toLowerCase().contains(
//                       enteredKeyword.toLowerCase(),
//                     ) ||
//                     country.displayName.toLowerCase().contains(
//                       enteredKeyword.toLowerCase(),
//                     ),
//               )
//               .toList();
//     }
//     setState(() {
//       _filteredCountries = results;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(title: Text(AppStrings.country), leading: null),
//         body: Padding(
//           padding: const EdgeInsets.all(AppSizes.paddingM),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 AppStrings.chooseYourCountry,
//                 style: AppTypography.h3_18Medium.copyWith(
//                   color: context.colors.titles,
//                 ),
//               ),
//               const SizedBox(height: AppSizes.paddingM),
//               SearchWidget(
//                 controller: _searchController,
//                 onChanged: _runFilter,
//               ),
//               const SizedBox(height: AppSizes.paddingL),
//               Expanded(
//                 child:
//                     _filteredCountries.isEmpty
//                         ? Center(
//                           child: Text(
//                             AppStrings.noCountry,
//                             style: AppTypography.body16Regular.copyWith(
//                               color: context.colors.text,
//                             ),
//                           ),
//                         )
//                         : ListView.separated(
//                           itemCount: _filteredCountries.length,
//                           separatorBuilder:
//                               (context, index) =>
//                                   const SizedBox(height: AppSizes.paddingM),
//                           itemBuilder: (context, index) {
//                             final country = _filteredCountries[index];
//                             final isSelected =
//                                 _selectedCountry?.countryCode ==
//                                 country.countryCode;

//                             return CustomRadioButtonItem(
//                               label: country.name,
//                               isSelected: isSelected,
//                               onTap: () {
//                                 setState(() {
//                                   _selectedCountry = country;
//                                 });
//                               },
//                             );
//                           },
//                         ),
//               ),

//               if (_selectedCountry != null) ...[
//                 const SizedBox(height: AppSizes.paddingM),
//                 _buildConfirmButton(),
//                 const SizedBox(height: AppSizes.paddingM),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   SizedBox _buildConfirmButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           print("Selected Country: ${_selectedCountry!.name}");
//           showModalBottomSheet(
//             context: context,
//             isScrollControlled: true,
//             builder: (context) => const LocationPermissionSheet(),
//           );
//         },
//         child: Text(AppStrings.confirm),
//       ),
//     );
//   }

// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/search_widget.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/custom_radio_button_item.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/pages/city_selection_screen.dart';
import 'package:second_hand_electronics_marketplace/features/location/data/models/country_model.dart';
import 'package:second_hand_electronics_marketplace/features/location/presentation/cubits/countries_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/location/presentation/cubits/countries_states.dart';

class CountrySelectionScreen extends StatefulWidget {
  const CountrySelectionScreen({super.key});

  @override
  State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  CountryModel? _selectedCountry;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 1. أول ما تفتح الشاشة بنطلب من الكيوبت يجيب الداتا من السواجر
    context.read<CountriesCubit>().fetchCountries();

    // 2. بنعمل ريفريش للشاشة كل ما اليوزر يكتب حرف في البحث
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

              SearchWidget(controller: _searchController, onChanged: (val) {}),
              const SizedBox(height: AppSizes.paddingL),

              Expanded(
                child: BlocBuilder<CountriesCubit, CountriesState>(
                  builder: (context, state) {
                    if (state is CountriesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is CountriesError) {
                      return Center(child: Text('error: ${state.message}'));
                    }

                    if (state is CountriesLoaded) {
                      final keyword =
                          _searchController.text.trim().toLowerCase();

                      // 4. فلترة ذكية مباشرة وقت العرض (عربي وإنجليزي)
                      final displayedCountries =
                          keyword.isEmpty
                              ? state.countries
                              : state.countries.where((country) {
                                return country.nameEn.toLowerCase().contains(
                                      keyword,
                                    ) ||
                                    country.nameAr.contains(keyword);
                              }).toList();

                      if (displayedCountries.isEmpty) {
                        return Center(
                          child: Text(
                            AppStrings.noCountry,
                            style: AppTypography.body16Regular.copyWith(
                              color: context.colors.text,
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: displayedCountries.length,
                        separatorBuilder:
                            (context, index) =>
                                const SizedBox(height: AppSizes.paddingM),
                        itemBuilder: (context, index) {
                          final country = displayedCountries[index];
                          final isSelected = _selectedCountry?.id == country.id;

                          return CustomRadioButtonItem(
                            label:
                                country
                                    .nameEn, // تقدري تغيريها لـ nameEn حسب لغة التطبيق
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _selectedCountry = country;
                              });
                            },
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),

              // 5. زر التأكيد (يظهر فقط إذا اختار دولة)
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      CitySelectionScreen(selectedCountry: _selectedCountry!),
            ),
          );
        },
        child: Text(AppStrings.confirm),
      ),
    );
  }
}
