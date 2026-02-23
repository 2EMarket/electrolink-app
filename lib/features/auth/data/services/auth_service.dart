import 'package:dio/dio.dart';

import '../models/auth_models.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: request.toJson(),
      );

      print("📦 Server Response: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Registration failed');
      }
    } on DioException catch (e) {
      print("🚨 Server Error Data: ${e.response?.data}");

      final errorMessage =
          e.response?.data['message'] ?? 'Network error occurred';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // تعيين كلمة المرور الجديدة
  Future<dynamic> resetPassword({
    required String newPassword,
    required String confirmPassword,
    required String token,
  }) async {
    try {
      final response = await _dio.post(
        // أو apiService.post حسب طريقتك
        '/auth/reset-password',
        data: {"newPassword": newPassword, "confirmPassword": confirmPassword},
        // ✅ إضافة التوكن في الهيدر ضروري جداً زي ما طلب السواجر
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // إرسال كود إعادة تعيين كلمة المرور
  Future<dynamic> sendResetPasswordCode({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/send-reset-password-code',
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponseModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Network error occurred';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> verifyCode({
    required String code,
    String? email,
    String? phone,
    String? type,
  }) async {
    try {
      final Map<String, dynamic> data = {"code": code};

      if (email != null) {
        data["email"] = email;
        // ✅ إذا إجانا type (زي password_reset) استخدمه، وإلا استخدم email_verification
        data["type"] = type ?? "email_verification";
      } else if (phone != null) {
        data["phoneNumber"] = phone;
        // ✅ نفس الإشي هنا للرقم
        data["type"] = type ?? "phone_verification";
      }
      if (type != null) data['type'] = type;

      final response = await _dio.post('/auth/verify-code', data: data);
      return response;
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Verification failed';
      throw Exception(errorMessage);
    }
  }

  Future<void> resendCode({bool isEmail = true}) async {
    try {
      await _dio.post(
        '/auth/send-verification-code',
        data: {
          "otpType": isEmail ? "email_verification" : "phone_verification",
        },
      );
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to resend code';
      throw Exception(errorMessage);
    }
  }

  void updateHeader(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
