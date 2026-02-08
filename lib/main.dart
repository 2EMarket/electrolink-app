import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/screens/all_chats_screen.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/screens/chating_screen.dart';
import 'imports.dart';
void main() {
  runApp(
    DevicePreview(enabled: true, builder: (context) => const
    ElectroLinkApp()
    // ChatsScreen(),
    // ListingsScreen(title: 'Listings', listings: []),
    ),
  );
}
