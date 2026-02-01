
import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/chat_bubble.dart';
class TypingIndicatorBubble extends ChatBubbleBase {
  TypingIndicatorBubble({
    super.key,
    required super.isSender,
  }) : super(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 4),
              const Text(
                'Typing ...',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
              const SizedBox(width: 4),
              // const SizedBox(
              //   width: 12,
              //   height: 12,
              //   child: CircularProgressIndicator(
              //     strokeWidth: 1.5,
              //     valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              //   ),
              // ),
            ],
          ),
        );
}
