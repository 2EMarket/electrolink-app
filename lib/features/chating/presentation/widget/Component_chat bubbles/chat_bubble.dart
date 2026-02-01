import 'package:flutter/material.dart';
abstract class ChatBubbleBase extends StatelessWidget {
  final bool isSender;
  final Widget child;

  const ChatBubbleBase({
    super.key,
    required this.isSender,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isSender
        ? const Color(0xFF2563EB).withOpacity(0.1)
        : const Color(0xFF10B981).withOpacity(0.1);

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
