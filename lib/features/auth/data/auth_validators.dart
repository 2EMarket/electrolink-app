class AuthValidators {
  static String? validateIdentifier(String? value, bool isPhoneMode) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email or phone number';
    }

    if (isPhoneMode) {
      String cleanPhone = value.trim();
      if (cleanPhone.length < 9 || cleanPhone.length > 10) {
        return 'The number is wrong';
      }
      if (!RegExp(r'^[0-9]+$').hasMatch(cleanPhone)) {
        return 'The number is wrong';
      }
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Please enter a valid email address.';
      }
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    // في شاشة اللوجن لا نحتاج لفحص قوة كلمة المرور، فقط التأكد من إدخالها
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Please enter your full name';
    if (RegExp(r'[0-9]').hasMatch(value)) return 'Name cannot contain numbers';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value))
      return 'Please enter a valid email address';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Please enter your phone number';
    String cleanPhone = value.trim();
    if (cleanPhone.length < 9 || cleanPhone.length > 10)
      return 'Phone number must be 9-10 digits';
    if (!RegExp(r'^[0-9]+$').hasMatch(cleanPhone))
      return 'Phone must be digits only';
    return null;
  }

  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 8) return 'Password must be at least 8 characters';
    bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = value.contains(RegExp(r'[a-z]'));
    bool hasDigits = value.contains(RegExp(r'[0-9]'));
    if (!hasUppercase || !hasLowercase || !hasDigits) {
      return 'Must contain Uppercase, Lowercase, and Number';
    }
    return null;
  }

  static String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your new password';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'(?=.*[a-zA-Z])(?=.*[0-9])').hasMatch(value)) {
      return 'Password must include letters and numbers';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty)
      return 'Please confirm your new password';
    if (value != originalPassword) return 'Passwords do not match.';
    return null;
  }
}
