import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/chat_bubble.dart';

class ImageMessageBubble extends ChatBubbleBase {
  ImageMessageBubble({
    super.key,
    required super.isSender,
    required String imageUrl,
    required String time,
  }) : super(
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 200,
                  height: 150,
                  fit: BoxFit.cover,
                  // ✅ إضافة Loading Spinner أثناء التحميل
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    width: 200,
                    height: 150,
                    child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                },
                // ✅ إضافة أيقونة خطأ في حال فشل الرابط
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 200,
                    height: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
                ),
              ),
              const SizedBox(height: 6),
              Text(
                time,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        );
}
