import 'package:flutter/material.dart';

import '../../../../../core/widgets/circle_button.dart';

class ToggleCircleButton extends StatefulWidget {
  final bool value;
  final VoidCallback? onTap;
  final double size;
  final bool isActive;

  final String activeIcon;
  final String inactiveIcon;
  final Color activeColor;
  final Color inactiveColor;

  const ToggleCircleButton({
    super.key,
    required this.value,
    required this.size,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.activeColor,
    required this.inactiveColor,
    this.onTap,
    this.isActive = true,
  });

  @override
  State<ToggleCircleButton> createState() => _ToggleCircleButtonState();
}

class _ToggleCircleButtonState extends State<ToggleCircleButton> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant ToggleCircleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
  }

  void _toggle() {
    if (widget.isActive) {
      setState(() {
        _value = !_value;
      });
    }
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      onTap: _toggle,
      size: widget.size - 5,
      iconPath: _value ? widget.activeIcon : widget.inactiveIcon,
      iconColor: _value ? widget.activeColor : widget.inactiveColor,
    );
  }
}
