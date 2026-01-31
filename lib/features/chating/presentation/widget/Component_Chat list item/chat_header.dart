import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? avatarUrl;
  final VoidCallback? onTap;

  const ChatHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.avatarUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (avatarUrl != null)
              CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl!),
                radius: 20,
              )
            else
              const CircleAvatar(
                radius: 20,
                child: Icon(Icons.person),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.more_vert,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}