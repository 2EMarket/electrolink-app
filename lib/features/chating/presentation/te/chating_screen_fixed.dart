import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/te/chat_input_bar_final4.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/te/reply_input_bar.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/te/reply_message_bubble.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/te/reply_message_bubble0.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/te/reply_message_model.dart';


import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_Chat header/chat_header.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_Voice/voice_message_bubble_fixed.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/image_message_bubble.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/text_message_bubble.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/typing_indicator_bubble.dart';
import 'package:second_hand_electronics_marketplace/imports.dart';

class ChatingScreen1 extends StatefulWidget {
  const ChatingScreen1({super.key});

  @override
  State<ChatingScreen1> createState() => _ChatingScreen1State();
}

class _ChatingScreen1State extends State<ChatingScreen1> {
  // الرسالة المحددة للرد عليها حالياً (null = لا يوجد رد نشط)
  ReplyMessageModel? _activeReply;

  // ── تشغيل الرد ────────────────────────────────────────────
  void _startReply(ReplyMessageModel message) {
    setState(() => _activeReply = message);
  }

  // ── إلغاء الرد ────────────────────────────────────────────
  void _cancelReply() {
    setState(() => _activeReply = null);
  }

  // ── إرسال الرسالة ─────────────────────────────────────────
  void _onSend(String text) {
    if (text.trim().isEmpty) return;
    // TODO:  منطق الإرسال هنا مع _activeReply 
    debugPrint('Send: $text | reply to: ${_activeReply?.id}');
    _cancelReply(); // امسح الرد بعد الإرسال
  }

  @override
  Widget build(BuildContext context) {
return MaterialApp( useInheritedMediaQuery: true, debugShowCheckedModeBanner: false, locale: DevicePreview.locale(context), builder: DevicePreview.appBuilder, home: Scaffold(      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.greyFillButton,
      body:
       SafeArea(
        child: Column(
          children: [
            // ── هيدر المحادثة ──────────────────────────────
            const ChatHeader(
              name: 'Ahmad Sami',
              imageUrl: "https://via.placeholder.com/150",
              isOnline: true,
              deviceName: "Redmi Note 12",
            ),

            // ── قائمة الرسائل ──────────────────────────────
            Expanded(
              child: Container(
                color: AppColors.white,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 20),
                  children: [
                    _buildDateDivider("Today"),
                    const SizedBox(height: 20),

                    // ── رسالة صوتية ──────────────────────
                    GestureDetector(
                      onLongPress: () => _startReply(
                        const ReplyMessageModel(
                          id: 'msg_voice_001',
                          senderName: 'you',
                          type: ReplyMessageType.audio,
                          audioDuration: Duration(seconds: 10),
                        ),
                      ),
                      child: VoiceMessageBubble1(
                        isSender: true,
                        audioUrl:
                            'https://www.soundjay.com/buttons/beep-01a.mp3',
                        duration: '0:10',
                        time: '09:20',
                        isRead: true,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── رسالة نصية ───────────────────────
                    GestureDetector(
                      onLongPress: () => _startReply(
                        const ReplyMessageModel(
                          id: 'msg_001',
                          senderName: 'you',
                          type: ReplyMessageType.text,
                          text:
                              'Hi, how are you? Is the device still available?',
                        ),
                      ),
                      child: TextMessageBubble(
                        isSender: true,
                        message:
                            'Hi, how are you? Is the device still available?',
                        time: '9:24 AM',
                        isRead: true,
                        id: 1,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── رسالة صورة ───────────────────────
                    GestureDetector(
                      onLongPress: () => _startReply(
                        const ReplyMessageModel(
                          id: 'msg_002',
                          senderName: 'Ahmad',
                          type: ReplyMessageType.image,
                          imageUrl:
                              'https://images.unsplash.com/photo-1521939094609-93aba1af40d7',
                        ),
                      ),
                      child: ImageMessageBubble(
                        isSender: false,
                        imageUrl:
                            'https://images.unsplash.com/photo-1521939094609-93aba1af40d7',
                        time: '9:24 AM',
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── رد على صورة بنص ──────────────────
                    ReplyMessageBubble3(
                      isSender: false,
                      time: '10:45 PM',
                      isRead: false,
                      isDelivered: true,
                      contentType: ReplyBubbleContentType.text,
                      message: "Could you send clearer photos from the other side?",
                      replyTo: const ReplyMessageModel(
                        id: 'msg_002',
                        senderName: 'you',
                        type: ReplyMessageType.image,
                        imageUrl:
                            'https://images.unsplash.com/photo-1521939094609-93aba1af40d7',
                        imageCaption: 'laptop photos',
                      ),
                    ),
                    ReplyMessageBubble4(
  isSender: true,
  time: '09:20',
  isRead: true,
  contentType: ReplyBubbleContentType4.audio,
  audioUrl: 'https://www.soundjay.com/buttons/beep-01a.mp3',
  audioDurationLabel: '0:10',
  replyTo: const ReplyMessageModel(
    id: 'msg_voice_001',
    senderName: 'you',
    type: ReplyMessageType.audio,
    audioDuration: Duration(seconds: 10),
  ),
),

                    const SizedBox(height: 12),

                    // ── رد على صوت بصورة ─────────────────
                    ReplyMessageBubble3(
                      time: '11:00 PM',
                      isRead: true,
                      contentType: ReplyBubbleContentType.image,
                      imageUrl:
                          'https://images.unsplash.com/photo-1488590528505-98d2b5aba04b',
                      imageCaption: "Payment receipt",
                      replyTo: const ReplyMessageModel(
                        id: 'msg_003',
                        senderName: 'Ahmad',
                        type: ReplyMessageType.audio,
                        audioDuration: Duration(seconds: 42),
                      ), isSender: false,
                    ),

                    const SizedBox(height: 12),

                    // ── رد بصوت على نص ───────────────────
                    ReplyMessageBubble3(
                      isSender: true,
                      time: '09:20',
                      isRead: true,
                      contentType: ReplyBubbleContentType.audio,
                      audioDuration: const Duration(seconds: 10),
                      audioProgress: 0.0,
                      isAudioPlaying: false,
                      onAudioPlayPause: () {}          
                        ,            replyTo: const ReplyMessageModel(
                        id: 'msg_voice_001',
                        senderName: 'you',
                        type: ReplyMessageType.audio,
                        audioDuration: Duration(seconds: 10),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── مؤشر الكتابة ─────────────────────
                     TypingIndicatorBubble(isSender: false),
                  ],
                ),
              ),
            ),

            // ── شريط الرد (يظهر فقط عند اختيار رسالة للرد) ──
            if (_activeReply != null)
              ReplyInputBar(
                replyTo: _activeReply!,
                onCancel: _cancelReply,
              ),

            ChatInputBarFinal4(
              onCancelReply: _cancelReply,
              // لا نمرر replyingTo هنا لأننا عرضناه في الأعلى باستخدام ReplyInputBar
            ),
            // ── شريط الإدخال ───────────────────────────────
            // ChatInputBarFinal4(
            //   onCancelReply: _cancelReply,
            //   // مرر _activeReply لـ ChatInputBarFinal إذا كان يقبله
            //   // activeReply: _activeReply,
            // ),
          ],
        ),
      ),
 ) );
  }

  Widget _buildDateDivider(String date) {
    return Center(
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
