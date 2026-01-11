import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';

import '../../configs/theme/app_colors.dart';
import '../constants/app_assets.dart';

class FilterSearch extends StatefulWidget {
  const FilterSearch({super.key});

  @override
  State<FilterSearch> createState() => _FilterSearchState();
}

class _FilterSearchState extends State<FilterSearch> {
  final TextEditingController _controller = TextEditingController();

  final List<String> allItems = [
    'iPhone',
    'iPhone 14 Pro Max',
    'iPhone 13',
    'Samsung S23',
    'Pixel 8',
  ];

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    final filteredItems =
        allItems
            .where(
              (e) =>
                  e.toLowerCase().contains(_controller.text.toLowerCase()) &&
                  !selectedItems.contains(e),
            )
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 56,
          width: 294,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextField(
                    controller: _controller,
                    onChanged: (_) => setState(() {}),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          AppAssets.searchSvg,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      hintText: 'Search...',
                      hintStyle: AppTypography.body16RegularGery,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius,
                        ),
                        borderSide: BorderSide(
                          color:
                              _controller.text.isNotEmpty
                                  ? (filteredItems.isNotEmpty
                                      ? AppColors.mainColor
                                      : Colors.red)
                                  : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,

                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                ),
                child: IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      AppAssets.filterSvg,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  onPressed: () {
                    // open filter modal
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children:
              selectedItems
                  .map(
                    (item) => Chip(
                      label: Text(item),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () {
                        setState(() {
                          selectedItems.remove(item);
                        });
                      },
                    ),
                  )
                  .toList(),
        ),

        if (_controller.text.isNotEmpty && filteredItems.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: filteredItems.length,
              separatorBuilder:
                  (_, __) => Divider(height: 1, color: Colors.grey.shade200),
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      selectedItems.add(item);
                      _controller.clear();
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
