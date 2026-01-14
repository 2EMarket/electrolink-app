import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';

/// A single category item displaying an icon inside a circular container
/// with a label underneath.
/// 
/// Part of the Categories section on the home screen.
class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.title,
    required this.iconData,
    this.onTap,
    this.iconSize = 24.0,
    this.circleSize = 56.0,
    this.gap = 12.0,
  });

  /// The category label displayed below the icon
  final String title;

  /// The icon to display inside the circle
  final IconData iconData;

  /// Callback when the item is tapped
  final VoidCallback? onTap;

  /// Size of the icon (default: 24px as per design spec)
  final double iconSize;

  /// Size of the circular container (default: 56px as per design spec)
  final double circleSize;

  /// Gap between circle and text (default: 12px as per Figma spec)
  final double gap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // The Circular Icon Container
          // CSS: Width 56px, Height 56px, Background rgba(107, 114, 128, 0.05)
          Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              // Using neutral5 which is 5% opacity neutral color (similar to rgba(107, 114, 128, 0.05))
              color: colors.neutral5,
              borderRadius: BorderRadius.circular(circleSize), // Fully circular
            ),
            child: Center(
              child: Icon(
                iconData,
                size: iconSize,
                // Using icons color from theme (UI/Basic/Icons color in Figma)
                color: colors.icons,
              ),
            ),
          ),

          SizedBox(height: gap), // CSS: Gap 8px

          // The Label
          // CSS: Poppins, 12px, Color #3D3D3D
          Text(
            title,
            style: AppTypography.label12Regular.copyWith(
              color: colors.text, // #3D3D3D in light theme
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
