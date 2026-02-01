import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/chat_bubble.dart';
class ReplyMessageBubble extends ChatBubbleBase {
  ReplyMessageBubble({
    super.key,
    required super.isSender,
    required String repliedTo,
    required String message,
    required String time,
  }) : super(
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  repliedTo,
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        );
}
