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
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
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
      id: json['id']?.toString() ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'] ?? 'buyer',
      isEmailVerified: json['isEmailVerified'] ?? false,
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
    final data = json['data'] ?? {};

    return AuthResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',

      token: data['token'] ?? '',

      user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
      otpSentMessage: data['otpSent'],
    );
  }
}
