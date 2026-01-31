import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/chat_bubble.dart';
class TextMessageBubble extends ChatBubbleBase {
  TextMessageBubble({
    super.key,
    required super.isSender,
    required String message,
    required String time,
    bool isRead = false,
  }) : super(
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    time,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(width: 4),
                  if (isSender)
                    Icon(
                      isRead ? Icons.done_all : Icons.done,
                      size: 14,
                      color: isRead ? const Color(0xFF2563EB) : Colors.grey,
                    ),
                ],
              ),
            ],
          ),
        );
}
