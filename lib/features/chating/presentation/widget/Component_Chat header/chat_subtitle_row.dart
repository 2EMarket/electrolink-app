import 'package:flutter/material.dart';

class ChatSubtitleRow extends StatelessWidget {
  final bool isOnline;

  const ChatSubtitleRow({
    super.key,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: isOnline ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          isOnline ? 'Online' : 'Offline',
          style: TextStyle(
            fontSize: 12,
            color: isOnline ? Colors.green : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
