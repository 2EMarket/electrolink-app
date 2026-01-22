import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../configs/theme/app_colors.dart';
import '../../../../../../core/constants/app_assets.dart';
import '../../../../../../core/constants/app_routes.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/widgets/custom_textfield.dart';
import '../../../../../../core/widgets/notification_toast.dart';
import '../../../../data/models/profile_view_data.dart';
import '../../../../data/models/user_model.dart';
import '../../public_profile/report_user_screen/send_report_screen.dart';
/*
class EditUserProfile extends StatefulWidget {
  EditUserProfile({super.key});

  static const double _avatarSizePrivate = 150;
  static const double _editIndicatorSize = 32;

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  static const _warningIcon = AppAssets.popupWarning;

  final mockUser = UserModel(
    id: '1',
    name: 'Eleanor Vance',
    avatar: AppAssets.profilePic,
    location: 'Berlin',
    createdAt: DateTime(2023, 5, 1),
    lastSeen: DateTime.now().subtract(const Duration(hours: 1)),
    responseTimeMinutes: 60,
    isOnline: true,
    email: "EleanorVance@example.com",
  );

  @override
  Widget build(BuildContext context) {
    final profile = ProfileViewData.fromUser(
      mockUser,
      type: ProfileType.private,
    );
    Widget avatar = Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          profile.avatar,
          width: EditUserProfile._avatarSizePrivate,
          height: EditUserProfile._avatarSizePrivate,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: EditUserProfile._avatarSizePrivate * 0.15,
          right: EditUserProfile._avatarSizePrivate * 0.15,
          child: GestureDetector(
            onTap:
                () => showCustomBottomSheet(
                  context,
                  const BottomSheetPhotoOptions(),
                ),
            child: Container(
              width: EditUserProfile._editIndicatorSize,
              height: EditUserProfile._editIndicatorSize,
              child: SvgPicture.asset(AppAssets.editIcon),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.mainColor,
              ),
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.paddingM,
          0,
          AppSizes.paddingM,
          AppSizes.paddingL,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: avatar),
            const SizedBox(height: AppSizes.paddingM),
            CustomTextField(
              label: 'Full Name',
              hintText: profile.name,
              controller: TextEditingController(text: profile.name),
            ),
            const SizedBox(height: AppSizes.paddingM),
            CustomTextField(
              label: 'Email',
              hintText: profile.email!,
              controller: TextEditingController(text: profile.email!),
            ),
            const SizedBox(height: AppSizes.paddingM),
            CustomTextField(
              label: 'Phone Number',
              hintText: profile.phone!,
              controller: TextEditingController(text: profile.phone),
            ),
            const SizedBox(height: AppSizes.paddingM),
            CustomTextField(
              label: 'Country',
              hintText: profile.location,
              controller: TextEditingController(text: profile.location),
            ),
            const SizedBox(height: AppSizes.paddingL),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: EasyLoading.isShow ? null : _submitReport,
                child: const Text("Update Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReport() async {
    EasyLoading.show(status: 'Waiting...');
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      await Future.delayed(const Duration(seconds: 2));
      EasyLoading.dismiss();
      context.goNamed(AppRoutes.userProfile);
      NotificationToast.show(
        context,
        'Edited Successfully',
        'The profile has been successfully updated.',
        ToastType.success,
      );
    } catch (_) {
      EasyLoading.dismiss();
      ShowStatusPopup(
        context: context,
        icon: _warningIcon,
        title: 'Something went wrong',
        description:
            'We couldn’t load your profile information.  Please check your internet connection and try again.',
        primaryText: 'Try again',
        //     secondaryText: 'Cancel',
        onPrimary: _submitReport,
        primaryColor: Theme.of(context).colorScheme.error,
      );
    }
  }
}*/
