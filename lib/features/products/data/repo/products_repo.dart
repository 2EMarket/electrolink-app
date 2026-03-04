import 'package:dio/dio.dart';

import '../models/product_model.dart';

class ProductsRepository {
  final Dio dio;

  ProductsRepository({required this.dio});

  Future<List<ProductModel>> getAllProducts({
    int page = 1,
    int limit = 10,
    String? categoryId, // لو حبينا نفلتر حسب القسم
  }) async {
    try {
      // تمرير الـ Parameters اللي شفناها في الـ Swagger
      final response = await dio.get(
        '/products',
        options: Options(extra: {'noToken': true}), // 👈 ضيفي هذا السطر للتجربة
        queryParameters: {'page': page, 'limit': limit},
      );

      // الفحص والتأكد من نجاح الطلب
      if (response.data['success'] == true) {
        // لاحظي المسار: response -> data الأولى -> data الثانية (المصفوفة)
        List<dynamic> productsList = response.data['data']['data'];

        return productsList.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'حدث خطأ غير معروف');
      }
    } catch (e) {
      // التعامل مع أخطاء Dio
      if (e is DioException) {
        throw Exception(
          e.response?.data['message'] ?? 'خطأ في الاتصال بالخادم',
        );
      }
      throw Exception(e.toString());
    }
  }
}
