import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../profile/data/models/user_model.dart';
import '../../data/models/auth_models.dart';
import '../../data/services/auth_service.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/constants/constants_exports.dart';
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
        await CacheHelper.saveData(key: CacheKeys.token, value: response.token);
        _authService.updateHeader(response.token);
      }

      emit(AuthSuccess(response));
    } catch (e) {
      String errorMsg = e.toString().replaceAll('Exception: ', '');

      if (errorMsg.contains('Unique constraint failed')) {
        if (errorMsg.contains(ApiKeys.email)) {
          errorMsg = AppStrings.errEmailExists;
        } else if (errorMsg.contains(ApiKeys.phoneNumber)) {
          errorMsg = AppStrings.errPhoneExists;
        } else {
          errorMsg = AppStrings.errAccountExists;
        }
      }

      emit(AuthFailure(errorMsg));
    }
  }

  Future<void> sendResetPasswordCode({
    required String identifier,
    required bool isPhone,
  }) async {
    emit(AuthLoading());
    try {
      final Map<String, dynamic> data = {};
      if (isPhone) {
        data[ApiKeys.phoneNumber] = identifier;
      } else {
        data[ApiKeys.email] = identifier;
      }

      await _authService.sendResetPasswordCode(data: data);
      emit(AuthCodeSent());
    } catch (e) {
      String errorMsg = e.toString();

      if (errorMsg.contains('404') || errorMsg.contains('User not found')) {
        errorMsg = AppStrings.errUserNotFound;
      } else if (errorMsg.contains('400')) {
        errorMsg = AppStrings.errInvalidFormat;
      } else {
        errorMsg = AppStrings.errGeneric;
      }

      emit(AuthFailure(errorMsg));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final response = await _authService.login(email, password);
      if (response.token.isNotEmpty) {
        await CacheHelper.saveData(key: CacheKeys.token, value: response.token);
        _authService.updateHeader(response.token);
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
    } catch (e) {
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      emit(AuthFailure(errorMsg));
    }
  }

  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
    required String token,
  }) async {
    emit(AuthLoading());
    try {
      await _authService.resetPassword(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        token: token,
      );

      emit(AuthPasswordResetSuccess());
    } catch (e) {
      String errorMsg = e.toString().replaceAll('Exception: ', '');

      if (errorMsg.contains('401') || errorMsg.contains('Unauthorized')) {
        errorMsg = AppStrings.errSessionExpired;
      } else if (errorMsg.contains('400')) {
        errorMsg = AppStrings.errValidationFailed;
      } else {
        errorMsg = AppStrings.errGeneric;
      }

      emit(AuthFailure(errorMsg));
    }
  }

  Future<void> logout() async {
    await CacheHelper.removeData(key: CacheKeys.token);
    emit(AuthLogOut());
  }
}
