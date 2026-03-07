import '../models/wishlist_model.dart';
import '../services/wishlist_service.dart';

class WishlistRepository {
  final WishlistService service;

  WishlistRepository({required this.service});

  Future<List<WishlistItemModel>> getWishlist() async {
    final response = await service.getWishlist();
    return response.data;
  }

  Future<bool> addToWishlist(String productId) async {
    return await service.addToWishlist(productId);
  }

  Future<bool> removeFromWishlist(String productId) async {
    return await service.removeFromWishlist(productId);
  }
}
