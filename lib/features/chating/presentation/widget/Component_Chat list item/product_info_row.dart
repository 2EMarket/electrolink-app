import 'package:flutter/material.dart';

class ProductInfoRow extends StatelessWidget {
  final String productName;
  final String imageUrl;

  const ProductInfoRow({
    super.key,
    required this.productName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(height: 1, color: Color(0xFFF3F4F6)),
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                imageUrl,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 24, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                productName,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF374151),
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}