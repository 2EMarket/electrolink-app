import 'package:dio/dio.dart';
import 'package:second_hand_electronics_marketplace/core/constants/api_constants.dart';
import 'package:second_hand_electronics_marketplace/core/constants/cache_keys.dart';
import 'package:second_hand_electronics_marketplace/core/helpers/cache_helper.dart';
import 'package:second_hand_electronics_marketplace/core/mock/mock_data.dart';

class WishlistService {
  final Dio dio;

  WishlistService({required this.dio});

  Future<Map<String, dynamic>> getWishlist() async {
    try {
      final token = CacheHelper.getData(key: CacheKeys.token);
      print("📡 Fetching Wishlist from: ${ApiEndpoints.wishlist}");
      print("🔑 Token: $token");

      final response = await dio.get(
        ApiEndpoints.wishlist,
        options: Options(
          headers: {
            ApiKeys.authorization: '${ApiKeys.bearer}$token',
            'Accept': 'application/json',
          },
        ),
      );
      print("✅ Wishlist Response: ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioException) {
        print('🚨 Wishlist Error: ${e.response?.statusCode}');
        print('📦 Error Data: ${e.response?.data}');
      }
      print('🧪 [DEMO MODE] فشل تحميل المفضلة، استخدام بيانات وهمية');
      return MockData.mockWishlistResponse;
    }
  }

  Future<bool> addToWishlist(String productId) async {
    try {
      final token = CacheHelper.getData(key: CacheKeys.token);
      print("📡 Adding to Wishlist: $productId");
      final response = await dio.post(
        ApiEndpoints.wishlist,
        data: {ApiKeys.productId: productId},
        options: Options(
          headers: {
            ApiKeys.authorization: '${ApiKeys.bearer}$token',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data['success'] ?? false;
    } catch (e) {
      print('🧪 [DEMO MODE] فشل إضافة للمفضلة، استخدام نجاح وهمي');
      return true;
    }
  }

  Future<bool> removeFromWishlist(String productId) async {
    try {
      final token = CacheHelper.getData(key: CacheKeys.token);
      print("📡 Removing from Wishlist: $productId");
      final response = await dio.delete(
        ApiEndpoints.removeFromWishlist(productId),
        options: Options(
          headers: {
            ApiKeys.authorization: '${ApiKeys.bearer}$token',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data['success'] ?? false;
    } catch (e) {
      print('🧪 [DEMO MODE] فشل حذف من المفضلة، استخدام نجاح وهمي');
      return true;
    }
  }
}
