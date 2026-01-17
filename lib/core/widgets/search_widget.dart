import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;

  const SearchWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = AppStrings.searchHint,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      setState(() {
        _showClearButton = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,

        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.paddingM,
            right: AppSizes.paddingS,
          ),
          child: SvgPicture.asset(AppAssets.searchSvg),
        ),

        suffixIcon:
            _showClearButton
                ? IconButton(
                  icon: SvgPicture.asset(AppAssets.cancelIcon),
                  onPressed: () {
                    widget.controller.clear();
                    widget.onChanged('');
                  },
                )
                : null,
      ),
    );
  }
}
