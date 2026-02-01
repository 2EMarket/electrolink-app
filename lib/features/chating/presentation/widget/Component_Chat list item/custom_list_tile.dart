import 'package:flutter/material.dart';

class BaseChatCard extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String imageUrl;
  final bool isSelected;
  final bool isOnline;
  final Widget? trailing; 
  final Widget? bottomContent; 
  final VoidCallback? onTap;

  const BaseChatCard({
    super.key,
    required this.title,
    this.subTitle,
    required this.imageUrl,
    this.isSelected = false,
    this.isOnline = false,
    this.trailing,
    this.bottomContent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                _buildAvatar(),
                const SizedBox(width: 12),
                
                // النصوص (الاسم والوصف)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      if (subTitle != null)
                        Text(
                          subTitle!,
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                
                // (زر، وقت، رقم)
                if (trailing != null) trailing!,
              ],
            ),
            if (bottomContent != null) ...[
              const Divider(height: 20),
              bottomContent!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
CircleAvatar(
  radius: 24,
  backgroundColor: Colors.grey[200], // لون احتياطي في حال فشل التحميل
  child: ClipOval(
    child: Image.network(
      imageUrl,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.person, color: Colors.grey); // عرض أيقونة بدل النص الأحمر
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const CircularProgressIndicator(strokeWidth: 2); // مؤشر تحميل
      },
    ),
  ),
),    
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12, height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}