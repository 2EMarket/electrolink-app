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
  }) async {
    emit(AuthLoading());
    try {
      final response = await _authService.verifyCode(
        code: code,
        email: email,
        phone: phone,
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
}
