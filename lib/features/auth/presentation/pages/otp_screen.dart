import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/top_in_registration.dart';
import 'package:second_hand_electronics_marketplace/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/auth/presentation/cubits/auth_states.dart';
import 'package:second_hand_electronics_marketplace/features/home/presentation/pages/main_layout_screen.dart';

import '../../../../core/widgets/notification_toast.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final String phoneNumber;

  const OtpScreen({super.key, required this.email, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();

  bool _isEmailVerification = false;

  @override
  void initState() {
    super.initState();
  }

  void _verify() {
    if (_pinController.text.length == 4) {
      context.read<AuthCubit>().verifyCode(
        code: _pinController.text,

        email: _isEmailVerification ? widget.email : null,

        phone: _isEmailVerification ? null : widget.phoneNumber,
      );
    } else {
      NotificationToast.show(
        context,
        "Invalid Code",
        "Please enter the 4-digit code",
        ToastType.warning,
      );
    }
  }

  void _switchVerificationMethod() {
    setState(() {
      _isEmailVerification = !_isEmailVerification;
      _pinController.clear();
    });

    context.read<AuthCubit>().resendCode(isEmail: _isEmailVerification);
  }

  String _maskData(String data) {
    if (data.contains('@')) {
      final parts = data.split('@');
      final username = parts[0];
      final domain = parts[1];

      if (username.length > 2) {
        return '${username.substring(0, 2)}****@$domain';
      }
      return data;
    } else {
      if (data.length > 8) {
        String start = data.substring(0, 4);
        String end = data.substring(data.length - 3);
        return '$start *** ** $end';
      }
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String destination =
        _isEmailVerification
            ? _maskData(widget.email)
            : _maskData(widget.phoneNumber);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: AppTypography.h3_18Medium.copyWith(color: context.colors.text),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.hint),
        borderRadius: BorderRadius.circular(12),
        color: context.colors.surface,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.colors.mainColor, width: 1),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Verify Code')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            NotificationToast.show(
              context,
              "Verified!",
              "Account verified successfully",
              ToastType.success,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
              (route) => false,
            );
          } else if (state is AuthCodeSent) {
            NotificationToast.show(
              context,
              "Sent",
              "Code sent to $destination",
              ToastType.success,
            );
          } else if (state is AuthFailure) {
            NotificationToast.show(
              context,
              "Error",
              state.message,
              ToastType.error,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter the 4-digit code we sent to\n$destination',
                  textAlign: TextAlign.center,
                  style: AppTypography.h3_18Regular.copyWith(
                    color: context.colors.text,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingL),

                Pinput(
                  length: 4,
                  controller: _pinController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => _verify(),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is AuthLoading ? null : _verify,
                    child:
                        state is AuthLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text("Verify"),
                  ),
                ),

                const SizedBox(height: AppSizes.paddingL),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive the code? ",
                      style: AppTypography.body16Regular.copyWith(
                        color: context.colors.text,
                      ),
                    ),
                    GestureDetector(
                      onTap:
                          () => context.read<AuthCubit>().resendCode(
                            isEmail: _isEmailVerification,
                          ),
                      child: Text(
                        "Resend",
                        style: AppTypography.body16Medium.copyWith(
                          color: context.colors.text,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSizes.paddingM),
                GestureDetector(
                  onTap: _switchVerificationMethod,
                  child: Text(
                    _isEmailVerification
                        ? "Send code via phone number"
                        : "Send code via email",
                    style: AppTypography.body14Regular.copyWith(
                      color: context.colors.hint,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
