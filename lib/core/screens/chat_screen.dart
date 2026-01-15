import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_typing%20bar/chat_input_bar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                resizeToAvoidBottomInset: true, // الافتراضي

      backgroundColor: const Color(0xFFF9FAFB),

      appBar: AppBar(
        title: const Text("Chat"),
        centerTitle: true,
      ),

      // 👇 هنا الرسائل
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 20,
        itemBuilder: (_, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text("Message $index"),
          );
        },
      ),

      // 👇 هنا ChatInputBar
      bottomNavigationBar: ChatInputBar(
        showSuggestions: true,

        onSend: (text) {
          debugPrint("Send text: $text");
        },

        onAttach: () {
          debugPrint("Attach file");
        },

        onCamera: () {
          debugPrint("Open camera");
        },

        onEmoji: () {
          debugPrint("Open emoji picker");
        },
      ),
      
    );
  }
}
