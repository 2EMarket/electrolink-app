import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/auth_models.dart';
import '../../data/services/auth_service.dart';
import '../../../../core/helpers/cache_helper.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(AuthInitial());

  Future<void> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final request = RegisterRequestModel(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
      );

      final response = await _authService.register(request);

      if (response.token.isNotEmpty) {
        await CacheHelper.saveData(key: 'token', value: response.token);

        _authService.updateHeader(response.token);

        print("🔐 Token saved & Header updated: ${response.token}");
      }

      emit(AuthSuccess(response));
    } catch (e) {
      print("❌ Register Error: $e");
      String errorMsg = e.toString().replaceAll('Exception: ', '');

      if (errorMsg.contains('Unique constraint failed')) {
        if (errorMsg.contains('email')) {
          errorMsg = 'This email is already registered. Please sign in.';
        } else if (errorMsg.contains('phoneNumber')) {
          errorMsg = 'This phone number is already registered. Please sign in.';
        } else {
          errorMsg = 'This account already exists.';
        }
      }

      emit(AuthFailure(errorMsg));
    }
  }

  // إرسال كود إعادة تعيين كلمة المرور
  Future<void> sendResetPasswordCode({
    required String identifier,
    required bool isPhone,
  }) async {
    emit(AuthLoading());
    try {
      // تجهيز البيانات حسب نوع الإدخال
      final Map<String, dynamic> data = {};
      if (isPhone) {
        data['phoneNumber'] = identifier;
      } else {
        data['email'] = identifier;
      }

      // ✅ استدعاء الدالة من الـ AuthService
      final response = await _authService.sendResetPasswordCode(data: data);

      // إذا نجحت العملية، بنبعث حالة إن الكود انبعث
      emit(AuthCodeSent());
      print("✅ Reset Code sent successfully");
    } catch (e) {
      print("❌ Send Reset Code Error: $e");
      String errorMsg = e.toString();

      // هندلة رسائل الخطأ
      if (errorMsg.contains('404') || errorMsg.contains('User not found')) {
        errorMsg = 'User not found. Please check your email or phone number.';
      } else if (errorMsg.contains('400')) {
        errorMsg = 'Invalid email or phone number format.';
      } else {
        errorMsg = 'An error occurred. Please try again.';
      }

      emit(AuthFailure(errorMsg));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final response = await _authService.login(email, password);

      if (response.token.isNotEmpty) {
        await CacheHelper.saveData(key: 'token', value: response.token);

        _authService.updateHeader(response.token);

        print("🔐 Login Token saved: ${response.token}");
      }

      emit(AuthSuccess(response));
    } catch (e) {
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      emit(AuthFailure(errorMsg));
    }
  }

  Future<void> verifyCode({
    required String code,
    String? email,
    String? phone,
    String? type,
  }) async {
    emit(AuthLoading());
    try {
      final response = await _authService.verifyCode(
        code: code,
        email: email,
        phone: phone,
        type: type,
      );

      final model = AuthResponseModel.fromJson(response.data);

      emit(AuthSuccess(model));
    } catch (e) {
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      emit(AuthFailure(errorMsg));
    }
  }

  Future<void> resendCode({bool isEmail = true}) async {
    try {
      await _authService.resendCode(isEmail: isEmail);

      emit(AuthCodeSent());
      print("✅ Code resent successfully");
    } catch (e) {
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      print("❌ Resend error: $errorMsg");

      emit(AuthFailure(errorMsg));
    }
  }

  // تعيين كلمة المرور الجديدة
  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
    required String token,
  }) async {
    emit(AuthLoading());
    try {
      // ✅ استدعاء الدالة من السيرفس
      final response = await _authService.resetPassword(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        token: token,
      );

      emit(AuthPasswordResetSuccess());
    } catch (e) {
      print("❌ Reset Password Error: $e");
      String errorMsg = e.toString().replaceAll('Exception: ', '');

      // هندلة الأخطاء الخاصة بهاي الشاشة
      if (errorMsg.contains('401') || errorMsg.contains('Unauthorized')) {
        errorMsg = 'Session expired or invalid token. Please try again.';
      } else if (errorMsg.contains('400')) {
        errorMsg = 'Validation failed. Please check your passwords.';
      } else {
        errorMsg = 'An error occurred. Please try again.';
      }

      emit(AuthFailure(errorMsg));
    }
  }
}
