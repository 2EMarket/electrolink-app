import 'package:flutter/material.dart';

class ChatSubtitleRow extends StatelessWidget {
  final String subtitle;
  final IconData? icon;
  final Color? iconColor;

  const ChatSubtitleRow({
    super.key,
    required this.subtitle,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 16,
            color: iconColor ?? Colors.grey,
          ),
          const SizedBox(width: 4),
        ],
        Expanded(
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}