import 'package:flutter/material.dart';
class AttachmentButtons extends StatelessWidget {
  final VoidCallback onAttach;
  final VoidCallback onCamera;

  const AttachmentButtons({
    super.key,
    required this.onAttach,
    required this.onCamera,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // أيقونة المرفقات (المشبك)
        Transform.rotate(
          angle: -0.8,
          child: IconButton(
            onPressed: onAttach,
            icon: Icon(Icons.attach_file, size: 20, color: Colors.grey[600]),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        const SizedBox(width: 12),
        // أيقونة الكاميرا
        IconButton(
          onPressed: onCamera,
          icon: Icon(Icons.camera_alt_outlined, size: 20, color: Colors.grey[600]),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}