import '../../../../core/constants/api_constants.dart';

class RegisterRequestModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  RegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.fullName: fullName,
      ApiKeys.email: email,
      ApiKeys.phoneNumber: phoneNumber,
      ApiKeys.password: password,
    };
  }
}

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String role;
  final bool isEmailVerified;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.isEmailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[ApiKeys.id]?.toString() ?? '',
      fullName: json[ApiKeys.fullName] ?? '',
      email: json[ApiKeys.email] ?? '',
      phoneNumber: json[ApiKeys.phoneNumber] ?? '',
      role: json[ApiKeys.role] ?? ApiKeys.defaultRoleBuyer,
      isEmailVerified: json[ApiKeys.isEmailVerified] ?? false,
    );
  }
}

class AuthResponseModel {
  final bool success;
  final String message;
  final String token;
  final UserModel? user;
  final String? otpSentMessage;

  AuthResponseModel({
    required this.success,
    required this.message,
    required this.token,
    this.user,
    this.otpSentMessage,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json[ApiKeys.data] ?? {};

    return AuthResponseModel(
      success: json[ApiKeys.success] ?? false,
      message: json[ApiKeys.message] ?? '',
      token: data[ApiKeys.token] ?? '',
      user:
          data[ApiKeys.user] != null
              ? UserModel.fromJson(data[ApiKeys.user])
              : null,
      otpSentMessage: data[ApiKeys.otpSent],
    );
  }
}
