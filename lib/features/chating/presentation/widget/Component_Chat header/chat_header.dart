import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_Chat list item/device_info_row.dart';
import 'chat_subtitle_row.dart';
class ChatHeader extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isOnline;
  final String deviceName;

  const ChatHeader({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isOnline,
    required this.deviceName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB)),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // ⬅️ Back
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
          
              // 👤 Avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  if (isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
          
              const SizedBox(width: 10),
          
              // 📄 Name + Subtitle
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    ChatSubtitleRow(
                      isOnline: isOnline,
                    ),
                  ],
                ),
              ),
          
              //  Actions
              IconButton(
                icon: const Icon(Icons.call, size: 20),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.search, size: 20),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, size: 20),
                onPressed: () {},
              ),
            ],
          ),
          Row(
  children: [
    Expanded(
      child: ProductInfoRow(
        productName: deviceName,
        imageUrl: imageUrl,
      ),
    ),
    IconButton(
      icon: const Icon(Icons.arrow_forward_ios, size: 20),
      onPressed: () => Navigator.pop(context),
    ),
  ],
),

          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //         // DeviceInfoRow(deviceName: deviceName),
          //     ProductInfoRow(
          // productName: deviceName,
          // imageUrl: imageUrl,
          // ),
          
          //   ],
          // ),

        ],
      ),
    );
  }
}
