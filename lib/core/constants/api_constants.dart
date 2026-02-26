class ApiEndpoints {
  static const String baseUrl = 'https://gsg-project-group-6.onrender.com';

  // ==========================================
  // Auth Endpoints
  // ==========================================
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String verifyCode = '/auth/verify-code';
  static const String resendVerificationCode = '/auth/send-verification-code';
  static const String sendResetPasswordCode = '/auth/send-reset-password-code';
  static const String resetPassword = '/auth/reset-password';

  // ==========================================
  // ==========================================
  // Profile Endpoints
  // ==========================================
  static const String getProfile = '/profile'; // GET
  static const String updateProfile = '/profile'; // PATCH
}

class ApiKeys {
  // JSON Request/Response Keys
  static const String id = 'id';
  static const String fullName = 'fullName';
  static const String email = 'email';
  static const String phoneNumber = 'phoneNumber';
  static const String password = 'password';
  static const String newPassword = 'newPassword';
  static const String confirmPassword = 'confirmPassword';
  static const String role = 'role';
  static const String isEmailVerified = 'isEmailVerified';
  static const String success = 'success';
  static const String message = 'message';
  static const String data = 'data';
  static const String token = 'token';
  static const String user = 'user';
  static const String otpSent = 'otpSent';
  static const String code = 'code';
  static const String type = 'type';
  static const String otpType = 'otpType';
  static const String bio = 'bio';
  static const String location = 'location';
  static const String countryId = 'countryId';
  static const String avatarAssetId = 'avatarAssetId';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String lastLogin = 'lastLogin';
  static const String responseTimeMinutes = 'responseTimeMinutes';
  static const String isPhoneVerified = 'isPhoneVerified';
  static const String isIdentityVerified = 'isIdentityVerified';
  static const String userId = 'userId';

  // Specific API Values (Enums/Types)
  static const String emailVerification = 'email_verification';
  static const String phoneVerification = 'phone_verification';
  static const String passwordResetType = 'password_reset';
  static const String defaultRoleBuyer = 'buyer';

  // Headers
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer ';
}
