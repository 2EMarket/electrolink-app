import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/categories_chip.dart';

class FilterModel extends StatefulWidget {
  FilterModel({super.key});

  List<String> categories = [
    'All',
    'Phones',
    'Smartwatches',
    'PC Parts',
    'Networking',
    'Accessories',
    'Tablets',
    'Audio',
    'Cameras',
    'Smart Home',
    'Laptops',
    'Gaming',
    'TV & Monitors',
  ];
  List<String> conditions = [
    'All',
    'Brand New',
    'Like New',
    'Excellent',
    'Good',
    'Fair',
  ];

  @override
  State<FilterModel> createState() => _FilterModelState();
}

class _FilterModelState extends State<FilterModel> {
  RangeValues priceRange = const RangeValues(0, 500);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset('assets/svgs/Close Square.svg'),
              ),
            ],
          ),
          Gap(20),
          Text('Categories'),
          Gap(10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var category in widget.categories)
                CategoriesChip(label: category, onSelected: (isSelected) {}),
            ],
          ),
          Gap(20),
          Text('Price'),
          Gap(10),
          RangeSlider(
            values: priceRange,
            min: 0,
            max: 500,
            divisions: 100,
            labels: RangeLabels(
              '\$${priceRange.start.toInt()}',
              '\$${priceRange.end.toInt()}',
            ),
            onChanged: (values) {
              setState(() {
                priceRange = values;
              });
            },
          ),
          Gap(20),
          Text('Condition'),
          Gap(10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var condition in widget.conditions)
                CategoriesChip(label: condition, onSelected: (isSelected) {}),
            ],
          ),
          Gap(40),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Reset filters
                  },
                  child: Text('Reset', style: TextStyle(color: Colors.black54)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
              ),
              Gap(10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
