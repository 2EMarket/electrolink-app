import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/constants_exports.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/social_media_button.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/top_in_registration.dart';
import 'package:second_hand_electronics_marketplace/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/auth/presentation/cubits/auth_states.dart';
import 'package:second_hand_electronics_marketplace/features/auth/presentation/pages/login_screen.dart';
import 'package:second_hand_electronics_marketplace/features/auth/presentation/pages/otp_screen.dart';

import '../../../../core/widgets/notification_toast.dart';
import '../../../../core/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedCountryCode = '+970';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool _isPasswordVisible = false;
  bool _isTermsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Please enter your full name';
    if (RegExp(r'[0-9]').hasMatch(value)) return 'Name cannot contain numbers';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value))
      return 'Please enter a valid email address';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Please enter your phone number';
    String cleanPhone = value.trim();
    if (cleanPhone.length < 9 || cleanPhone.length > 10)
      return 'Phone number must be 9-10 digits';
    if (!RegExp(r'^[0-9]+$').hasMatch(cleanPhone))
      return 'Phone must be digits only';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 8) return 'Password must be at least 8 characters';
    bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = value.contains(RegExp(r'[a-z]'));
    bool hasDigits = value.contains(RegExp(r'[0-9]'));
    if (!hasUppercase || !hasLowercase || !hasDigits)
      return 'Must contain Uppercase, Lowercase, and Number';
    return null;
  }

  void _onRegisterPressed() {
    if (!_isTermsAccepted) {
      NotificationToast.show(
        context,
        "Terms Required",
        "You must agree to the Terms of Service",
        ToastType.warning,
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      String cleanPhone = _phoneController.text.trim();
      if (cleanPhone.startsWith('0')) cleanPhone = cleanPhone.substring(1);
      final fullPhoneNumber = '$_selectedCountryCode$cleanPhone';
      print("📞 Full Phone Number: $fullPhoneNumber");
      context.read<AuthCubit>().register(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: fullPhoneNumber,
        password: _passwordController.text,
      );
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });

      NotificationToast.show(
        context,
        "Missing Info",
        "Please check the fields marked in red",
        ToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign up")),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            NotificationToast.show(
              context,
              "Success",
              "Registration Successful! Check OTP",
              ToastType.success,
            );

            String cleanPhone = _phoneController.text.trim();
            if (cleanPhone.startsWith('0'))
              cleanPhone = cleanPhone.substring(1);
            final fullPhoneNumber = '$_selectedCountryCode$cleanPhone';

            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => OtpScreen(
                      email: _emailController.text.trim(),
                      phoneNumber: fullPhoneNumber,
                    ),
              ),
            );
          } else if (state is AuthFailure) {
            NotificationToast.show(
              context,
              "Registration Failed",
              state.message,
              ToastType.error,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Form(
                key: _formKey,

                autovalidateMode: _autovalidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TopInRegistrationWidget(
                      title: 'Welcome!',
                      subtitle:
                          'Create your account to buy or sell electronics.',
                    ),
                    const SizedBox(height: AppSizes.paddingL),

                    CustomTextField(
                      label: "Full Name",
                      hintText: "Enter your full name",
                      isRequired: true,
                      controller: _nameController,
                      validator: _validateName,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    CustomTextField(
                      label: "Email",
                      hintText: "Enter your email",
                      isRequired: true,
                      controller: _emailController,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    CustomTextField(
                      label: "Phone number",
                      hintText: "Enter your phone number",
                      isRequired: true,
                      controller: _phoneController,
                      validator: _validatePhone,
                      keyboardType: TextInputType.phone,
                      prefix: Container(
                        width: 110,
                        child: CountryCodePicker(
                          onChanged: (country) {
                            setState(() {
                              _selectedCountryCode = country.dialCode ?? '+970';
                            });
                          },
                          initialSelection: 'PS',
                          favorite: const ['+970', 'PS'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                          padding: EdgeInsets.zero,
                          textStyle: AppTypography.body14Regular.copyWith(
                            color: context.colors.mainColor,
                          ),
                          flagWidth: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    CustomTextField(
                      label: "Password",
                      hintText: "Enter your password",
                      isRequired: true,
                      controller: _passwordController,
                      validator: _validatePassword,
                      obscureText: !_isPasswordVisible,
                      suffix: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: context.colors.icons,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 19,
                          height: 19,
                          child: Checkbox(
                            value: _isTermsAccepted,
                            activeColor: context.colors.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            side: BorderSide(
                              color: context.colors.hint,
                              width: 1.5,
                            ),
                            onChanged: (val) {
                              setState(() {
                                _isTermsAccepted = val ?? false;
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "I agree to the ",
                                  style: AppTypography.label12Regular.copyWith(
                                    color: context.colors.hint,
                                    height: 1.5,
                                  ),

                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          setState(() {
                                            _isTermsAccepted =
                                                !_isTermsAccepted;
                                          });
                                        },
                                ),

                                TextSpan(
                                  text: "Terms of Service and Privacy Policy.",
                                  style: AppTypography.label12Regular.copyWith(
                                    color: context.colors.hint,
                                    decoration: TextDecoration.underline,
                                    decorationColor: context.colors.hint,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          print("Open Terms Page");
                                        },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingL),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            state is AuthLoading ? null : _onRegisterPressed,
                        child:
                            state is AuthLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Text("Register"),
                      ),
                    ),

                    const SizedBox(height: AppSizes.paddingL),

                    Row(
                      children: [
                        Expanded(child: Divider(color: context.colors.hint)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingXS,
                          ),
                          child: Text(
                            "Or Continue With",
                            style: AppTypography.label12Regular.copyWith(
                              color: context.colors.hint,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: context.colors.hint)),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingS),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SocialMediaButton(
                            iconPath: "assets/svgs/google.svg",
                          ),
                        ),
                        const SizedBox(width: AppSizes.paddingM),
                        Expanded(
                          child: SocialMediaButton(
                            iconPath: "assets/svgs/apple.svg",
                          ),
                        ),
                        const SizedBox(width: AppSizes.paddingM),
                        Expanded(
                          child: SocialMediaButton(
                            iconPath: "assets/svgs/facebook.svg",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingL),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: AppTypography.body16Regular.copyWith(
                            color: context.colors.text,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign in",
                            style: AppTypography.body16Medium.copyWith(
                              color: context.colors.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
