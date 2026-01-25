import 'package:flutter/material.dart';

class CategoriesChip extends StatefulWidget {
  CategoriesChip({
    super.key,
    required this.label,
    this.isSelected = false,
    required this.onSelected,
  });

  final String label;
  bool isSelected;
  final ValueChanged<bool> onSelected;

  @override
  State<CategoriesChip> createState() => _CategoriesChipState();
}

class _CategoriesChipState extends State<CategoriesChip> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
        widget.onSelected(widget.isSelected);
      },
      child: Text(
        widget.label,
        style: TextStyle(
          fontSize: 13,
          color: widget.isSelected ? Colors.white : Theme.of(context).hintColor,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor:
            widget.isSelected
                ? const Color.fromRGBO(37, 99, 235, 1)
                : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color:
                widget.isSelected
                    ? const Color.fromRGBO(37, 99, 235, 1)
                    : const Color.fromARGB(255, 171, 172, 172),
          ),
        ),
      ),
    );
  }
}
