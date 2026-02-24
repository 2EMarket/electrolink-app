import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/bottom_sheet_header.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/category_item.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/search_widget.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/models/listing_field_config.dart';

class ListingCategorySheet extends StatefulWidget {
  const ListingCategorySheet({
    super.key,
    required this.categories,
    required this.selectedValue,
    required this.onSelected,
  });

  final List<ListingCategoryConfig> categories;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  @override
  State<ListingCategorySheet> createState() => _ListingCategorySheetState();
}

class _ListingCategorySheetState extends State<ListingCategorySheet> {
  late List<ListingCategoryConfig> _filtered;
  late TextEditingController _controller;
  String? _selected;

  @override
  void initState() {
    super.initState();
    _filtered = widget.categories;
    _controller = TextEditingController();
    _selected = widget.selectedValue.isEmpty ? null : widget.selectedValue;
  }

  void _runFilter(String value) {
    if (value.trim().isEmpty) {
      setState(() => _filtered = widget.categories);
      return;
    }
    setState(() {
      _filtered = widget.categories
          .where((c) => c.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingM,
        AppSizes.paddingM,
        AppSizes.paddingM,
        AppSizes.paddingL,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          BottomSheetHeader(
            title: 'Listing category',
            onClose: () => Navigator.pop(context),
          ),
          const SizedBox(height: AppSizes.paddingM),
          SearchWidget(controller: _controller, onChanged: _runFilter),
          const SizedBox(height: AppSizes.paddingM),
          Expanded(
            child: GridView.builder(
              itemCount: _filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: AppSizes.paddingS,
                crossAxisSpacing: AppSizes.paddingS,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final category = _filtered[index];
                return CategoryItem(
                  title: category.name,
                  iconPath: category.icon,
                  isSelected: _selected == category.name,
                  onTap: () => setState(() => _selected = category.name),
                );
              },
            ),
          ),
          const SizedBox(height: AppSizes.paddingM),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selected == null
                  ? null
                  : () {
                      widget.onSelected(_selected!);
                      Navigator.pop(context);
                    },
              child: const Text('Select Category'),
            ),
          ),
        ],
      ),
    );
  }
}
