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
import 'package:second_hand_electronics_marketplace/features/auth/presentation/pages/register_screen.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/pages/main_layout_screen.dart';

import '../../../../core/widgets/notification_toast.dart';
import '../../../../core/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedCountryCode = '+970';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isPhoneMode = false;

  @override
  void initState() {
    super.initState();
    _identifierController.addListener(_checkInputType);
  }

  @override
  void dispose() {
    _identifierController.removeListener(_checkInputType);
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkInputType() {
    final text = _identifierController.text;
    if (text.isEmpty) {
      if (_isPhoneMode) setState(() => _isPhoneMode = false);
      return;
    }

    final isNumber = RegExp(r'^[0-9+]+$').hasMatch(text[0]);
    if (isNumber != _isPhoneMode) {
      setState(() => _isPhoneMode = isNumber);
    }
  }

  String? _validateIdentifier(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Please enter your email or phone number';

    if (_isPhoneMode) {
      String cleanPhone = value.trim();
      if (cleanPhone.length < 9 || cleanPhone.length > 10)
        return 'The number is wrong';
      if (!RegExp(r'^[0-9]+$').hasMatch(cleanPhone))
        return 'The number is wrong';
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value))
        return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    return null;
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      String identifier = _identifierController.text.trim();

      if (_isPhoneMode) {
        if (identifier.startsWith('0')) identifier = identifier.substring(1);
        identifier = '$_selectedCountryCode$identifier';
      }

      context.read<AuthCubit>().login(
        email: identifier,
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
      appBar: AppBar(title: const Text("Sign in")),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            NotificationToast.show(
              context,
              "Welcome Back!",
              "Logged in successfully",
              ToastType.success,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
              (route) => false,
            );
          } else if (state is AuthFailure) {
            NotificationToast.show(
              context,
              "Login Failed",
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
                      title: 'Welcome back',
                      subtitle: 'Please log in to continue.',
                    ),
                    const SizedBox(height: AppSizes.paddingL),

                    CustomTextField(
                      label: "Email or Phone number",
                      hintText: "Enter your email or phone number",
                      isRequired: true,
                      controller: _identifierController,
                      validator: _validateIdentifier,
                      keyboardType:
                          _isPhoneMode
                              ? TextInputType.phone
                              : TextInputType.emailAddress,
                      prefix:
                          _isPhoneMode
                              ? SizedBox(
                                width: 110,
                                child: CountryCodePicker(
                                  onChanged: (country) {
                                    setState(() {
                                      _selectedCountryCode =
                                          country.dialCode ?? '+970';
                                    });
                                  },
                                  initialSelection: 'PS',
                                  favorite: const ['+970', 'PS'],
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                  padding: EdgeInsets.zero,
                                  textStyle: AppTypography.body14Regular
                                      .copyWith(
                                        color: context.colors.mainColor,
                                      ),
                                  flagWidth: 22,
                                ),
                              )
                              : null,
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
                            value: _rememberMe,
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
                                _rememberMe = val ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Remember me",
                                style: AppTypography.body14Regular.copyWith(
                                  color: context.colors.text,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("Open Forgot Password");
                                },
                                child: Text(
                                  "Forgot password?",
                                  style: AppTypography.body14Medium.copyWith(
                                    color: context.colors.text,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingL),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            state is AuthLoading ? null : _onLoginPressed,
                        child:
                            state is AuthLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Text("Sign in"),
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
                          "Don't have an account? ",
                          style: AppTypography.body16Regular.copyWith(
                            color: context.colors.text,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign up",
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
