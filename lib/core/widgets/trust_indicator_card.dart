import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';

enum TrustIndicatorLayout { vertical, horizontal }

/// A card showing a trust indicator (icon + label + verification badge).
///
/// Supports two layouts:
/// - [TrustIndicatorLayout.vertical]: 139x100dp (Figma)
/// - [TrustIndicatorLayout.horizontal]: 227x64dp (Figma)
class TrustIndicatorCard extends StatelessWidget {
  const TrustIndicatorCard({
    super.key,
    required this.label,
    required this.icon,
    required this.verified,
    this.layout = TrustIndicatorLayout.vertical,

    // Sizing & spacing
    this.padding = const EdgeInsets.all(12),
    this.radius = 10, // Figma spec (from ActivitySummaryCard and general card usage)
    this.iconCircleSize = 40,
    this.iconSize = 20,
    this.gap = 10,

    // Colors (theme-friendly defaults)
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 2, // Matches other cards
    this.iconCircleColor,
    this.iconColor,
    this.labelStyle,
    this.labelColor,

    // Badge
    this.badgeSize = 24, // Default updated to 24
    this.badgeVerifiedColor, // Defaults to Success Green (Theme)
    this.badgeUnverifiedColor, // Defaults to Icons/Grey (Theme)
    this.badgeIconColor = Colors.white,

    // Interaction
    this.onTap,
    this.semanticsLabel,
  });

  final String label;
  final IconData icon;
  final bool verified;
  final TrustIndicatorLayout layout;

  final EdgeInsets padding;
  final double radius;
  final double iconCircleSize;
  final double iconSize;
  final double gap;

  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;

  final Color? iconCircleColor;
  final Color? iconColor;

  final TextStyle? labelStyle;
  final Color? labelColor;

  final double badgeSize;
  final Color? badgeVerifiedColor;
  final Color? badgeUnverifiedColor;
  final Color badgeIconColor;

  final VoidCallback? onTap;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    // Theme context
    final colors = context.colors;

    // 1. Resolve Colors
    final Color bg = backgroundColor ?? colors.surface;
    final Color bdr = borderColor ?? colors.border;
    
    // Icon Logic
    // Main color with 10% opacity (approx. 0.1) for circle background
    final Color effectiveIconBg = iconCircleColor ?? colors.mainColor.withOpacity(0.1);
    final Color effectiveIconColor = iconColor ?? colors.mainColor;

    // Text Logic
    // "text used is reg 16... verified is text, not verified is hint"
    final Color defaultLabelColor = verified ? colors.text : colors.hint;
    
    final TextStyle effectiveLabelStyle = labelStyle ??
        AppTypography.body16Regular.copyWith(
          color: labelColor ?? defaultLabelColor,
          height: 1.2, 
        );

    // Badge Logic
    // Success Green for verified, Grey (icons color) for unverified
    final Color effectiveBadgeColor = verified
        ? (badgeVerifiedColor ?? const Color(0xFF22C55E)) // Fallback if theme doesn't have explicit success
        : (badgeUnverifiedColor ?? colors.icons);

    // Unverified Opacity Logic
    // "when it not verified what should happen is that they will seem opacity less for the whole card"
    final double cardOpacity = verified ? 1.0 : 0.5;

    final badgeWidget = _StatusBadge(
      size: badgeSize,
      color: effectiveBadgeColor,
      iconColor: badgeIconColor,
      icon: verified ? Icons.check : Icons.check, // Both use check, just different color/opacity
    );

    // Badge Widget Size Calculation
    // _StatusBadge has 2px padding on all sides -> total width/height = size + 4
    final double badgeWidgetSize = badgeSize + 4.0;
    
    // Position Logic:
    // "bottom left quarter... inside the card and the other quarter outside"
    final double badgeOffset = -(badgeWidgetSize / 2);

    // 2. Build Content based on Layout
    Widget content;
    
    if (layout == TrustIndicatorLayout.vertical) {
      // VERTICAL: Badge is floating outside (Stack)
       Widget cardVisuals = _VerticalLayout(
            width: 139, 
            height: 100, 
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            radius: radius,
            bg: bg,
            border: bdr,
            borderWidth: borderWidth,
            iconBg: effectiveIconBg,
            icon: icon,
            iconColor: effectiveIconColor,
            iconCircleSize: iconCircleSize,
            iconSize: iconSize,
            label: label,
            labelStyle: effectiveLabelStyle,
            gap: gap,
          );
      
      // Apply Opacity to visuals if unverified
      if (!verified) cardVisuals = Opacity(opacity: cardOpacity, child: cardVisuals);

      // Wrap Interaction
      if (onTap != null) {
        cardVisuals = Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(radius),
              onTap: onTap,
              child: cardVisuals,
            ));
      }

      // Return Stack for Floating Badge
      content = Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          cardVisuals,
          Positioned(
            top: badgeOffset, 
            right: badgeOffset, 
            child: badgeWidget,
          ),
        ],
      );

    } else {
      // HORIZONTAL: Badge is INLINE (Row)
      // We pass the badge widget into the layout
      Widget cardVisuals = _HorizontalLayout(
            width: 227, 
            height: 64, 
            padding: padding,
            radius: radius,
            bg: bg,
            border: bdr,
            borderWidth: borderWidth,
            iconBg: effectiveIconBg,
            icon: icon,
            iconColor: effectiveIconColor,
            iconCircleSize: iconCircleSize,
            iconSize: iconSize,
            label: label,
            labelStyle: effectiveLabelStyle,
            gap: gap,
            badge: badgeWidget, // Pass badge inside
          );
      
      // Apply Opacity
      if (!verified) cardVisuals = Opacity(opacity: cardOpacity, child: cardVisuals);

       // Wrap Interaction
      if (onTap != null) {
        cardVisuals = Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(radius),
              onTap: onTap,
              child: cardVisuals,
            ));
      }
      
      content = cardVisuals;
    }

    return Semantics(
      label: semanticsLabel ?? label,
      value: verified ? 'Verified' : 'Not verified',
      button: onTap != null,
      child: content,
    );
  }
}

// ================= INTERNAL LAYOUT WIDGETS (VISUALS ONLY) =================

class _VerticalLayout extends StatelessWidget {
  const _VerticalLayout({
    required this.width,
    required this.height,
    required this.padding,
    required this.radius,
    required this.bg,
    required this.border,
    required this.borderWidth,
    required this.iconBg,
    required this.icon,
    required this.iconColor,
    required this.iconCircleSize,
    required this.iconSize,
    required this.label,
    required this.labelStyle,
    required this.gap,
  });

  final double width;
  final double height;
  final EdgeInsets padding;
  final double radius;
  final Color bg;
  final Color border;
  final double borderWidth;

  final Color iconBg;
  final IconData icon;
  final Color iconColor;
  final double iconCircleSize;
  final double iconSize;

  final String label;
  final TextStyle labelStyle;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: border, width: borderWidth),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _IconCircle(
            size: iconCircleSize,
            bg: iconBg,
            icon: icon,
            iconSize: iconSize,
            iconColor: iconColor,
          ),
           SizedBox(height: gap), 
          Text(
            label, 
            style: labelStyle, 
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _HorizontalLayout extends StatelessWidget {
  const _HorizontalLayout({
     required this.width,
    required this.height,
    required this.padding,
    required this.radius,
    required this.bg,
    required this.border,
    required this.borderWidth,
    required this.iconBg,
    required this.icon,
    required this.iconColor,
    required this.iconCircleSize,
    required this.iconSize,
    required this.label,
    required this.labelStyle,
    required this.gap,
    required this.badge, // Add Badge
  });

  final double width;
  final double height;
  final EdgeInsets padding;
  final double radius;
  final Color bg;
  final Color border;
  final double borderWidth;

  final Color iconBg;
  final IconData icon;
  final Color iconColor;
  final double iconCircleSize;
  final double iconSize;

  final String label;
  final TextStyle labelStyle;
  final double gap;
  final Widget badge; // Badge widget

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: border, width: borderWidth),
      ),
      child: Row(
        children: [
          _IconCircle(
            size: iconCircleSize,
            bg: iconBg,
            icon: icon,
            iconSize: iconSize,
            iconColor: iconColor,
          ),
          SizedBox(width: gap),
          Expanded( // Use Expanded to push badge to the end or share space
            child: Text(
              label,
              style: labelStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: gap),
          badge, // Inline Badge
        ],
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  const _IconCircle({
    required this.size,
    required this.bg,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
  });

  final double size;
  final Color bg;
  final IconData icon;
  final double iconSize;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Icon(icon, size: iconSize, color: iconColor),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.size,
    required this.color,
    required this.iconColor,
    required this.icon,
  });

  final double size;
  final Color color;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // White ring around badge to separate it from border/content if it overlaps
    return Container(
      padding: const EdgeInsets.all(2), // White border width
      decoration: const BoxDecoration(
        color: Colors.white, 
        shape: BoxShape.circle
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Icon(icon, size: size * 0.65, color: iconColor),
      ),
    );
  }
}
