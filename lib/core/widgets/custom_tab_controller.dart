import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';

class CustomTabController extends StatelessWidget {
  final int length;
  final List<Tab> tabs;
  final List<Widget> children;

  const CustomTabController({
    Key? key,
    required this.length,
    required this.tabs,
    required this.children,
  }) : assert(tabs.length == length),
       assert(children.length == length),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: length,
      child: Column(
        children: [
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                border: Border.all(color: AppColors.border),
              ),
              child: TabBar(tabs: tabs),
            ),
          ),

          const SizedBox(height: 24),

          Expanded(child: TabBarView(children: children)),
        ],
      ),
    );
  }
}
