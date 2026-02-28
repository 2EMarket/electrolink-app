import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/te/reply_message_bubble0.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/te/reply_message_model.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_Chat header/chat_header.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_Voice/voice_message_bubble_fixed.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/image_message_bubble.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/text_message_bubble.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/typing_indicator_bubble.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_typing%20bar/chat_input_bar_final.dart';
class ChatingScreen extends StatelessWidget {
  const ChatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  children: [
                    _buildDateDivider("Today"),

                    const SizedBox(height: 20),
// VoiceMessageBuble1(
//                       isSender: true,
//                       audioUrl: 'https://www.soundjay.com/buttons/beep-01a.mp3',
//                       duration: '0:10',
//                       time: '09:20',
//                       isRead: true,
//                     ),
// ChatInputBarFinal1(),
                    VoiceMessageBubble1(
  isSender: true,
  audioUrl: 'https://www.soundjay.com/buttons/beep-01a.mp3',
  duration: '0:10',
  time: '09:20',
  isRead: true,
 )
,

                    const SizedBox(height: 12),
// VoiceMessageBuble1(
//                       isSender: true,
//                       audioUrl: 'https://www.soundjay.com/buttons/beep-01a.mp3',
//                       duration: '0:10',
//                       time: '09:20',
//                       isRead: true,
// ),

                    const SizedBox(height: 12),

                     TextMessageBubble(
                      isSender: true,
                      message: "Hi, how are you? Is the device still available?",
                      time: "9:24 AM",
                      isRead: true, id: 1,
                    ),

                    const SizedBox(height: 12),

                     ImageMessageBubble(
                      isSender: false,
                      imageUrl:
                          'https://images.unsplash.com/photo-1521939094609-93aba1af40d7',
                      time: '9:24 AM',
                    ),
                    const SizedBox(height: 12),
ReplyMessageBubble3(
  isSender: false,
  time: '10:45 م',
  isRead: false,
  isDelivered: true,
  contentType: ReplyBubbleContentType.text,
  message: 'هل يمكنك إرسال صور أوضح من الجانب الآخر؟',
  replyTo: ReplyMessageModel(
    id: 'msg_002',
    senderName: 'أنت',
    type: ReplyMessageType.image,
    imageUrl: 'https://example.com/laptop.jpg',
    imageCaption: 'صور اللابتوب',
  ),),


// ─────────────────────────────────────────────────────────────
// مثال 3: رد على رسالة صوتية بصورة
// ─────────────────────────────────────────────────────────────
 ReplyMessageBubble3(
  isSender: true,
  time: '11:00 م',
  isRead: true,
  contentType: ReplyBubbleContentType.image,
  imageUrl: 'https://example.com/receipt.jpg',
  imageCaption: 'إيصال الدفع',
  replyTo: ReplyMessageModel(
    id: 'msg_003',
    senderName: 'سارة',
    type: ReplyMessageType.audio,
    audioDuration: const Duration(seconds: 42),
  ),
),

// ─────────────────────────────────────────────────────────────
// مثال 4: رد بصوت على رسالة نصية
// ─────────────────────────────────────────────────────────────
 ReplyMessageBubble3(
  isSender: false,
  time: '11:10 م',
  isRead: false,
  contentType: ReplyBubbleContentType.audio,
  audioDuration: const Duration(seconds: 15),
  audioProgress: 0.6,
  isAudioPlaying: false,
  onAudioPlayPause: () {/* تشغيل/إيقاف */},
  replyTo: ReplyMessageModel(
    id: 'msg_004',
    senderName: 'أنت',
    type: ReplyMessageType.text,
    text: 'ما هو رأيك في السعر النهائي؟',
  ),),

                    //  ReplyMessageBubble(
                    //   isSender: false,
                    //   repliedTo: 'The device is available!',
                    //   message: 'Great! Can we meet tomorrow?',
                    //   time: '9:25 AM', isRead: false,
                    // ),

                    const SizedBox(height: 12),

                     TypingIndicatorBubble(isSender: false),

                  ],
                ),
              ),
            ),
            // VoiceMessageBubble1(
            //   isSender: true,
            //   audioUrl: 'https://www.soundjay.com/buttons/beep-01a.mp3',
            //   duration: '0:10',
            //   time: '09:20',
            //   isRead: true,
            // ),
// RealTimeRecordingBubble(
//               onCancel: () => debugPrint("Recording cancelled"),
//               onSend: (path) => debugPrint("Recording sent: $path"),
// ),
            ChatInputBarFinal(onCancelReply: () {  },),
// RealTimeRecordingBubble(
//               onCancel: () => debugPrint("Recording cancelled"),
//               onSend: (path) => debugPrint("Recording sent: $path"),
//             ),
            // ChatInputBar(
            //   showSuggestions: true,
            //   onSend: (text) => debugPrint("Send text: $text"),
            //   onAttach: () => debugPrint("Attach file"),
            //   onCamera: () => debugPrint("Open camera"),
            //   onEmoji: () => debugPrint("Open emoji picker"),
            // ),
          ],
        ),
      ));
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
