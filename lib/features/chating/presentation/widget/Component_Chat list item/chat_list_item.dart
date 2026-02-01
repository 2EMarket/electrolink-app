import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_shadows.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_Chat list item/device_info_row.dart';

class ChatListItem extends StatelessWidget {
  final String name;
  final String lastMsg;
  final String time;
  final int unread;
  final String productName;
  final String imageUrl; 
  final bool isSelected;

  const ChatListItem({
    super.key,
    required this.name,
    required this.lastMsg,
    required this.time,
    this.unread = 0,
    this.productName = '',
    this.imageUrl = 'https://via.placeholder.com/150',
    this.isSelected = false, required bool isPinned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
color: AppColors.white,        borderRadius: BorderRadius.circular(12),
       boxShadow: AppShadows.card, 
        border: Border.all(
          color: isSelected ? AppColors.mainColor : AppColors.border,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
CircleAvatar(
  radius: 24,
  backgroundColor: Colors.grey[200], 
  child: ClipOval(
    child: Image.network(
      imageUrl,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.person, color: Colors.grey);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const CircularProgressIndicator(strokeWidth: 2); 
      },
    ),
  ),
),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E), 
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                
                // 2. الاسم، الرسالة، والوقت
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          // دائرة الإشعارات الزرقاء
                          if (unread > 0)
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF2563EB),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                unread.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lastMsg,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
              // 3. قسم المنتج (الخط الفاصل + صورة واسم المنتج)
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: 8),
              //   child: Divider(height: 1, color: Color(0xFFF3F4F6)),
              // ),
              // Row(
              //   children: [
              //     ClipRRect(
              //       borderRadius: BorderRadius.circular(4),
              //       child: Image.network(
              //         'data:image/jpeg;base64,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', // صورة المنتج
              //         width: 32,
              //         height: 32,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //     const SizedBox(width: 8),
              //     Text(
              //       productName,
              //       style: const TextStyle(
              //         fontSize: 13,
              //         color: Color(0xFF374151),
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ],
              // ),
                 ProductInfoRow(
          productName: productName,
          imageUrl: imageUrl,
        ),
            ],
          ),
        ),
      
    );
  }
}