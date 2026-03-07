import 'package:second_hand_electronics_marketplace/features/products/data/models/product_model.dart';

class WishlistResponseModel {
  final bool success;
  final List<WishlistItemModel> data;

  WishlistResponseModel({required this.success, required this.data});

  factory WishlistResponseModel.fromJson(Map<String, dynamic> json) {
    return WishlistResponseModel(
      success: json['success'] ?? false,
      data:
          json['data'] != null
              ? (json['data'] as List)
                  .map((e) => WishlistItemModel.fromJson(e))
                  .toList()
              : [],
    );
  }
}

class WishlistItemModel {
  final String id;
  final String userId;
  final String productId;
  final ProductModel? product;

  WishlistItemModel({
    required this.id,
    required this.userId,
    required this.productId,
    this.product,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      productId: json['productId']?.toString() ?? '',
      product:
          json['product'] != null
              ? ProductModel.fromJson(json['product'])
              : null,
    );
  }
}
