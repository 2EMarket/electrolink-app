import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/screens/chating_screen.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/te/chating_screen_fixed.dart';
import 'imports.dart';
void main() {
 runApp( DevicePreview( enabled: true, builder: (context) => MaterialApp( useInheritedMediaQuery: true, debugShowCheckedModeBanner: false, locale: DevicePreview.locale(context), builder: DevicePreview.appBuilder,
// ChatScreen()  
  // ChatingScreen()
home:  ChatingScreen1(), 

    // ListingsScreen(title: 'Listings', listings: []),
  //  CustomerServiceChatScreen() 
 )),
  );
}
