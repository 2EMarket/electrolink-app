import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/custom_tab_controller.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/faq_tile_widget.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTabController(
      length: 2,
      title: 'Help Center',
      tabs: [Tab(text: "FAQ"), Tab(text: "Contact us")],
      children: [FaqContent(), ContactUsContent()],
    );
  }
}

class FaqContent extends StatelessWidget {
  const FaqContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.paddingM), // 16.0
      children: const [
        FaqTileWidget(
          title: "What is this app?",
          answer:
              "This app is a marketplace for buying and selling used electronics. It allows users to list their devices, connect with nearby buyers or sellers.",
        ),
        FaqTileWidget(
          title: "How does it work?",
          answer:
              "You can create an account, take photos of your item, set a price, and publish. Buyers can then contact you directly.",
        ),
        FaqTileWidget(
          title: "How do I post a listing?",
          answer:
              "Go to the 'Add' tab in the bottom navigation bar, fill in the details, upload images, and click submit.",
        ),
      ],
    );
  }
}

// --- مجرد ودجت تجريبي للمحتوى الثاني ---
class ContactUsContent extends StatelessWidget {
  const ContactUsContent({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(
          leading: Icon(Icons.headset_mic, color: Colors.blue),
          title: Text("Customer Service"),
        ),
        ListTile(
          leading: Icon(Icons.facebook, color: Colors.blue),
          title: Text("Facebook"),
        ),
        ListTile(
          leading: Icon(Icons.language, color: Colors.blue),
          title: Text("Website"),
        ),
      ],
    );
  }
}
