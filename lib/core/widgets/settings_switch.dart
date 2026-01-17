import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';

/// Settings row with:
/// - title
/// - subtitle/description
/// - trailing switch
///
/// Matches a common "settings item" pattern.
///
/// Android Spec:
/// - Width: 315dp (flexible)
/// - Height: 74dp (content driven)
/// - Margin Left: 16dp
/// - Top Margin: 16dp
///
/// Theme Usage:
/// - Title: [AppTypography.body16Regular]
/// - Description: [AppTypography.body14Regular]
/// - Colors: [AppColors] via context.colors
class SettingsSwitchTile extends StatelessWidget {
  const SettingsSwitchTile({
    super.key,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSizes.paddingM,
      vertical: 14,
    ),
    this.titleStyle,
    this.descriptionStyle,
    this.titleColor,
    this.descriptionColor,
    this.activeColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.titleDescriptionGap = 6,
    this.switchScale = 1.0,
    this.onTapToggles = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.backgroundColor,
  });

  final String title;
  final String description;

  /// Background color of the tile.
  final Color? backgroundColor;

  /// Switch state.
  final bool value;

  /// Called when toggled.
  final ValueChanged<bool> onChanged;

  /// If false, greys out and disables interaction.
  final bool enabled;

  /// Outer padding for the whole tile.
  final EdgeInsets padding;

  /// Style overrides (wins over *Color* overrides).
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  /// Optional color overrides used only if style overrides are null.
  final Color? titleColor;
  final Color? descriptionColor;

  /// Switch colors (optional; defaults to theme).
  final Color? activeColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;

  /// Space between title and description.
  final double titleDescriptionGap;

  /// Scale the switch (useful to match Figma sizing).
  final double switchScale;

  /// If true, tapping anywhere on the tile toggles the switch.
  final bool onTapToggles;

  /// Optional rounding for tap ripple.
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    // Use theme-aware colors
    final colors = context.colors;

    final effectiveTitleStyle =
        titleStyle ??
        AppTypography.body16Regular.copyWith(
          color:
              (enabled
                  ? (titleColor ??
                      colors.text) // Title defaults to 'text' color
                  : (titleColor ?? colors.text).withOpacity(0.45)),
        );

    final effectiveDescStyle =
        descriptionStyle ??
        AppTypography.body14Regular.copyWith(
          color:
              (enabled
                  ? (descriptionColor ??
                      colors.hint) // Subtitle defaults to 'hint' color
                  : (descriptionColor ?? colors.hint).withOpacity(0.45)),
          height: 1.25,
        );

    final switchWidget = Transform.scale(
      scale: switchScale,
      child: Switch(
        value: value,
        onChanged: enabled ? onChanged : null,
        // Thumb (Ball) is always white
        thumbColor: WidgetStateProperty.resolveWith((states) {
          return Colors.white;
        }),
        // Track color logic
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            // ON: Blue (Main Color)
            return activeColor ?? colors.mainColor;
          }
          // OFF: Grey (Icons Color)
          return inactiveTrackColor ?? colors.icons;
        }),
        // Remove outline in M3 for cleaner look if needed, or keep default
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );

    Widget content = Container(
      constraints: const BoxConstraints(
        minHeight: 74,
      ), // Match XML layout_height="74dp"
      padding: padding, //
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surface, // Default to Surface (White)
        borderRadius: borderRadius,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Vertically center the content
        children: [
          // Texts
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Hug content
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: effectiveTitleStyle),
                if (description.isNotEmpty) ...[
                  SizedBox(height: titleDescriptionGap),
                  Text(description, style: effectiveDescStyle),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Switch
          switchWidget,
        ],
      ),
    );

    if (onTapToggles) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: enabled ? () => onChanged(!value) : null,
          child: content,
        ),
      );
    }

    return content;
  }
}
