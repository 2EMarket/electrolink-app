// import 'package:flutter/material.dart';
// import 'package:second_hand_electronics_marketplace/chat_input_bar_modified.dart';
// import 'chat_input_bar_complete.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chat Input Bar Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const ChatScreen(),
//     );
//   }
// }

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final List<ChatMessage> _messages = [];

//   void _handleSendText(String text) {
//     setState(() {
//       _messages.add(
//         ChatMessage(
//           text: text,
//           isAudio: false,
//           timestamp: DateTime.now(),
//         ),
//       );
//     });
//     print('Text message sent: $text');
//   }

//   void _handleSendAudio(String filePath) {
//     setState(() {
//       _messages.add(
//         ChatMessage(
//           text: filePath,
//           isAudio: true,
//           timestamp: DateTime.now(),
//         ),
//       );
//     });
//     print('Audio message sent: $filePath');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat Demo'),
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           // Messages list
//           Expanded(
//             child: _messages.isEmpty
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.chat_bubble_outline,
//                           size: 64,
//                           color: Colors.grey[300],
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'No messages yet',
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Start a conversation by sending a message or recording audio',
//                           style: TextStyle(
//                             color: Colors.grey[500],
//                             fontSize: 14,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   )
//                 : ListView.builder(
//                     reverse: true,
//                     itemCount: _messages.length,
//                     itemBuilder: (context, index) {
//                       final message = _messages[_messages.length - 1 - index];
//                       return _buildMessageBubble(message);
//                     },
//                   ),
//           ),
//           // Chat input bar
//           ChatInputBar(
//             showSuggestions: true,
//             onSend: _handleSendText,
//             onSendAudio: _handleSendAudio,
//             onAttach: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Attach file tapped')),
//               );
//             },
//             onCamera: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Camera tapped')),
//               );
//             },
//             onEmoji: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Emoji picker tapped')),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageBubble(ChatMessage message) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: Container(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width * 0.7,
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               if (message.isAudio)
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       Icons.mic,
//                       color: Colors.white,
//                       size: 16,
//                     ),
//                     const SizedBox(width: 8),
//                     const Text(
//                       'Audio message',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 )
//               else
//                 Text(
//                   message.text,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                   ),
//                 ),
//               const SizedBox(height: 4),
//               Text(
//                 _formatTime(message.timestamp),
//                 style: TextStyle(
//                   color: Colors.white.withOpacity(0.7),
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String _formatTime(DateTime dateTime) {
//     final hour = dateTime.hour.toString().padLeft(2, '0');
//     final minute = dateTime.minute.toString().padLeft(2, '0');
//     return '$hour:$minute';
//   }
// }

// class ChatMessage {
//   final String text;
//   final bool isAudio;
//   final DateTime timestamp;

//   ChatMessage({
//     required this.text,
//     required this.isAudio,
//     required this.timestamp,
//   });
// }
