import 'package:flutter/material.dart';

/// Design system shadows exported from Figma
class AppShadows {
  AppShadows._();

  /// Cards shadow: 0px 1px 4px 0px rgba(0, 0, 0, 0.1)
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x1A000000), // 10% opacity
      offset: Offset(0, 1),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  /// Cards 2 shadow: 0px 1px 4px 0px rgba(255, 255, 255, 0.3)
  static const List<BoxShadow> card2 = [
    BoxShadow(
      color: Color(0x4DFFFFFF), // 30% opacity
      offset: Offset(0, 1),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  /// Bottom sheet shadow: 0px 0px 2px 0px rgba(0, 0, 0, 0.15)
  static const List<BoxShadow> bottomSheet = [
    BoxShadow(
      color: Color(0x26000000), // 15% opacity
      offset: Offset(0, 0),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  /// UX Drop Shadow: 0px 1px 8px 0px rgba(0, 0, 0, 0.2)
  static const List<BoxShadow> dropShadow = [
    BoxShadow(
      color: Color(0x33000000), // 20% opacity
      offset: Offset(0, 1),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];
}
