import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_Chat%20list%20item/chat_list_item.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_Chat%20list%20item/custom_list_tile.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_Voice/recording_bubble.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_chat%20bubbles/image_message_bubble.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_chat%20bubbles/reply_message_bubble.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_chat%20bubbles/text_message_bubble.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_chat%20bubbles/typing_indicator_bubble.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_typing%20bar/chat_input_bar.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_Voice/chat_input_bar_modified.dart';
import 'package:second_hand_electronics_marketplace/theme/app_theme.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_chat%20bubbles/voice_message_chat_bubble.dart.dart';
void main() {

  runApp(
    DevicePreview(
      enabled: true, // تفعيل المعاينة
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
                    bool _isRecording = false;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      useInheritedMediaQuery: true, // ضروري لـ DevicePreview
      locale: DevicePreview.locale(context), // ضبط اللغة
      builder: DevicePreview.appBuilder, // ربط الـ builder
      debugShowCheckedModeBanner: false,
      title: 'Empty App with DevicePreview',
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: 
        Expanded(
          child: SingleChildScrollView(
            // لضمان سلاسة السكرول حتى لو كان المحتوى بسيطاً
            physics: const BouncingScrollPhysics(), 
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row(
            //   children: [
              
            //   ],
            // ),

            const SizedBox(height: 80),
       ChatInputBarFigma(),
       RecordingBubble(seconds: 0, onDelete: () {}, onConfirm: () {}),
            // AttachmentButtons(onAttach: () {  }, onCamera: () {  },),
//    ChatInputBar(
//   onSend: (message) {
//     print("تم إرسال: $message");
//   },
//   onCamera: () {
//     print("فتح الكاميرا");
//   },
//   onAttach: () {
//     print("فتح الملفات");
//   },
// ),

// أو استخدام SuggestionsCips لوحدها في مكان آخر
// SuggestionChips(
//   suggestions: ["Option 1", "Option 2", "Option 3"],
//   onSelected: (selected) {
//     print("تم اختيار: $selected");
//   }, 
// ),
            BaseChatCard(
  title: "Yara Yaseen",
  imageUrl: "...",
  trailing: ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2563EB)),
    child: const Text("Unblock"),
  ),
),
//             BaseChatCard(
//   title: "Yara Yaseen",
//   subTitle: "Is it still available?",
//   imageUrl: "...",
//   isOnline: true,
//   trailing: Column(
//     children: [
//       const Text("28m", style: TextStyle(fontSize: 12)),
//       const SizedBox(height: 4),
//       CircleAvatar(radius: 10, child: Text("1", style: TextStyle(fontSize: 10))),
//     ],
//   ),
//   bottomContent: Row(
//     children: [
//       Image.asset("assets/laptop.png", width: 20),
//       const Text(" Dell XPS 15"),
//     ],
//   ),
// ),
            ChatListItem(
              name: 'John Doe',
              lastMsg: 'Hello, how are you?',
              time: '10:30 AM',
              unread: 2,
              productName: 'iPhone 12',
              imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
              isSelected: true,
            ),
// VerticalAudioControl(),
            VoiceMessageBubble1(
              isSender: true,
              audioUrl: 'https://www.soundjay.com/buttons/beep-01a.mp3',
              duration: '0:05',
              time: '09:24',
              isRead: true,
            ),
            // VoiceMessageDesktop(
            //   isSender: true,
            //   audioUrl: 'https://www.soundjay.com/buttons/beep-01a.mp3',
            //   time: '09:24',
            //   isRead: true,
            // ),
            // // رسالة صوتية من المرسل (أزرق) 
            // VoiceMessageMobile(
            //   isSender: true,
            //   audioUrl: 'https://www.soundjay.com/buttons/beep-01a.mp3',
            //   time: '09:24',
            //   isRead: true, duration: '0:05',
            // ),
            // const SizedBox(height: 20),
            // // رسالة صوتية من المرسل (أزرق)
            // VoiceMessageMobile(
            //     isSender: true,
            //     audioUrl: 'https://www.soundjay.com/buttons/beep-01a.mp3',
            //     time: '09:24',
            //     isRead: true, duration: '0:05',
            //   ),
              
              
              // رسالة صوتية من المستقبل (أخضر)
              // VoiceMessageMobile(
              //   isSender: false,
              //   audioUrl: 'https://www.soundjay.com/buttons/beep-01a.mp3',
              //   time: '09:20',
              //   isRead: false, duration: '0:10',
              // ),
            TextMessageBubble(
              isSender: true,
              message: "Hi How are you?",
              time: "9:24",
              isRead: true,
            ),
            TypingIndicatorBubble(isSender: false),
            ImageMessageBubble(
              isSender: true,
              imageUrl: 'https://via.placeholder.com/200x150',
              time: '9:24',
            ),
            ReplyMessageBubble(
              isSender: false,
              repliedTo: 'Hi How are you?',
              message: 'I’m good, thanks!',
              time: '9:25',
            ),
            // ChatInputBar(showSuggestions: true),

// في build method:
ChatInputBar(
  isRecording: _isRecording,
  onStartRecording: () {
    setState(() {
      _isRecording = true;
    });
    // ابدأ تسجيل الصوت هنا
  },
  onStopRecording: () {
    setState(() {
      _isRecording = false;
    });
    // أوقف تسجيل الصوت هنا
  },
  // باقي الباراميترات...
)
          ],
        ),
        ))),
    );
  }
}
