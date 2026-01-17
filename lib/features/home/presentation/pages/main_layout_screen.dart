import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/custom_bottom_navbar.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/pages/home_tab.dart';
import 'package:second_hand_electronics_marketplace/features/profile/presentation/pages/public_profile/public_profile_screens/public_profile.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [HomeTab(), HomeTab(), HomeTab(),  PublicProfile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onAddTap: () {
          print("Add button tapped");
        },
      ),
    );
  }
}
