// lib/core/models/message_model.dart
enum MessageType {
  text,
  voice,
  image,
}

class ChatMessage {
  final String id;
  final MessageType type;
  final String content; // للنص أو رابط الصوت/الصورة
  final DateTime timestamp;
  final bool isSender;
  final bool isRead;
  final String? senderName;
  final String? duration; // للمقاطع الصوتية
  final String? imageUrl; // للصور

  ChatMessage({
    required this.id,
    required this.type,
    required this.content,
    required this.timestamp,
    required this.isSender,
    this.isRead = false,
    this.senderName,
    this.duration,
    this.imageUrl,
  });

  String get formattedTime {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}