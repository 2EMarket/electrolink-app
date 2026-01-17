import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';

class TrustIndicatorCard extends StatelessWidget {
  const TrustIndicatorCard({
    super.key,
    required this.label,
    required this.iconSvgPath,
    required this.verified,
    this.width = 103.33,
    this.height = 86,
    this.iconSize = 40,
    this.badgeSize = 24,
    this.onTap,
  });

  final String label;
  final String iconSvgPath;
  final bool verified;
  final double width;
  final double height;
  final double iconSize;
  final double badgeSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;


    Widget cardContent = Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconSvgPath,
              width: iconSize,
              height: iconSize,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: AppTypography.label12Regular.copyWith(color: colors.text),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );

    if (!verified) {
      cardContent = Opacity(opacity: 0.5, child: cardContent);
    }

    if (onTap != null) {
      cardContent = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: cardContent,
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        cardContent,
        if (verified)
          Positioned(
            top: -8,
            right: -5,
            child: SvgPicture.asset(
              AppAssets.verifiedBadgeSvg,
              width: badgeSize,
              height: badgeSize,
            ),
          ),
      ],
    );
  }
}
