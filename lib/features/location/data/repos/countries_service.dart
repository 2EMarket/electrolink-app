import 'package:dio/dio.dart';
import 'package:second_hand_electronics_marketplace/core/mock/mock_data.dart';
import 'package:second_hand_electronics_marketplace/features/location/data/models/country_model.dart';

class CountriesService {
  final Dio _dio;
  CountriesService(this._dio);

  Future<List<CountryModel>> getActiveCountries() async {
    try {
      final response = await _dio.get('/countries');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List data = response.data['data'] ?? [];
        final allCountries = data.map((e) => CountryModel.fromJson(e)).toList();

        // نرجع بس الدول المفعلة
        return allCountries.where((country) => country.isActive).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load countries');
      }
    } on DioException catch (e) {
      print('🧪 [DEMO MODE] فشل تحميل الدول من الباكند، استخدام بيانات وهمية | ${e.message}');
      return MockData.mockCountries;
    } catch (e) {
      print('🧪 [DEMO MODE] خطأ غير متوقع في تحميل الدول، استخدام بيانات وهمية | $e');
      return MockData.mockCountries;
    }
  }
}
