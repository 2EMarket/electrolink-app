import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_shadows.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_Chat header/chat_header.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/image_message_bubble.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/reply_message_bubble.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/text_message_bubble.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/typing_indicator_bubble.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/voice_message_chat_bubble.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_typing bar/chat_input_bar.dart';
class ChatingScreen extends StatelessWidget {
  const ChatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.greyFillButton,

      body: SafeArea(
        child: Column(
          children: [
            const ChatHeader(
              name: 'Ahmad Sami',
                            imageUrl: "https://via.placeholder.com/150",              
              isOnline: true,
              deviceName: "Redmi Note 12",
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: AppShadows.bottomSheet,
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  children: [
                    _buildDateDivider("Today"),

                    const SizedBox(height: 20),

                    const VoiceMessageBubble1(
                      isSender: false,
                      audioUrl: 'https://www.soundjay.com/buttons/beep-01a.mp3',
                      duration: '0:05',
                      time: '09:24',
                      isRead: true,
                    ),

                    const SizedBox(height: 12),

                     TextMessageBubble(
                      isSender: true,
                      message: "Hi, how are you? Is the device still available?",
                      time: "9:24 AM",
                      isRead: true,
                    ),

                    const SizedBox(height: 12),

                     ImageMessageBubble(
                      isSender: false,
                      imageUrl:
                          'https://images.unsplash.com/photo-1521939094609-93aba1af40d7',
                      time: '9:24 AM',
                    ),

                    const SizedBox(height: 12),

                     ReplyMessageBubble(
                      isSender: true,
                      repliedTo: 'The device is available!',
                      message: 'Great! Can we meet tomorrow?',
                      time: '9:25 AM',
                    ),

                    const SizedBox(height: 12),

                     TypingIndicatorBubble(isSender: false),

                  ],
                ),
              ),
            ),

            ChatInputBar(
              showSuggestions: true,
              onSend: (text) => debugPrint("Send text: $text"),
              onAttach: () => debugPrint("Attach file"),
              onCamera: () => debugPrint("Open camera"),
              onEmoji: () => debugPrint("Open emoji picker"),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildDateDivider(String date) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.neutral10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          date,
          style: AppTypography.caption12Regular.copyWith(
            color: AppColors.neutral,
          ),
        ),
      ),
    );
  }
}
