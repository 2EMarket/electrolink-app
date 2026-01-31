import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../configs/theme/app_colors.dart';
import '../../../../../../core/constants/constants_exports.dart';
import '../../../../../../core/widgets/custom_textfield.dart';
import '../../../../../../core/widgets/notification_toast.dart';
import '../../../../profile_exports.dart';
import '../../../widgets/profile_widgets_exports.dart';

class EditUserProfile extends StatefulWidget {
  final bool isMe;
  final String userId;

  const EditUserProfile({super.key, required this.userId, required this.isMe});

  static const double _avatarSizePrivate = 150;
  static const double _editIndicatorSize = 32;

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  static const _warningIcon = AppAssets.popupWarning;
  File? _selectedAvatar;

  final ProfileMockDataSource mockUser = ProfileMockDataSource();

  ProfileViewData? profile;
  Map<String, TextEditingController>? controllers;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image == null) return;

    setState(() {
      _selectedAvatar = File(image.path);
    });
  }

  Future<void> _pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return;

    setState(() {
      _selectedAvatar = File(image.path);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    });
  }

  Future<void> _loadProfile() async {
    EasyLoading.show(status: 'Loading...');
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final user = await mockUser.getUser('1');

      profile = ProfileViewData.fromUser(user, type: ProfileType.private);

      controllers = {
        'Full Name': TextEditingController(text: profile!.name),
        'Email': TextEditingController(text: profile!.email ?? ''),
        'Phone Number': TextEditingController(text: profile!.phone ?? ''),
        'Country': TextEditingController(text: profile!.location),
      };

      setState(() {});
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void dispose() {
    controllers?.values.forEach((c) => c.dispose());
    super.dispose();
  }

  Widget _buildAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipOval(
          child:
              _selectedAvatar != null
                  ? Image.file(
                    _selectedAvatar!,
                    width: EditUserProfile._avatarSizePrivate,
                    height: EditUserProfile._avatarSizePrivate,
                    fit: BoxFit.cover,
                  )
                  : Image.asset(
                    profile!.avatar,
                    width: EditUserProfile._avatarSizePrivate,
                    height: EditUserProfile._avatarSizePrivate,
                    fit: BoxFit.cover,
                  ),
        ),
        Positioned(
          bottom: EditUserProfile._avatarSizePrivate * 0.15,
          right: EditUserProfile._avatarSizePrivate * 0.15,
          child: GestureDetector(
            onTap:
                () => showProfileOptionsSheet(
                  context,
                  type: ProfileOptionType.photo,
                  onTakePhoto: _takePhoto,
                  onPickGallery: _pickFromGallery,
                ),
            child: Container(
              width: EditUserProfile._editIndicatorSize,
              height: EditUserProfile._editIndicatorSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.mainColor,
              ),
              child: SvgPicture.asset(AppAssets.editIcon),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (profile == null || controllers == null) {
      return ProfileErrorScreen();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
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
            Center(child: _buildAvatar()),
            const SizedBox(height: AppSizes.paddingM),
            ...controllers!.entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.paddingM),
                child: CustomTextField(
                  label: e.key,
                  hintText: e.value.text,
                  controller: e.value,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.paddingL),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: EasyLoading.isShow ? null : _updateProfile,
                child: const Text("Update Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _updateProfile() async {
    EasyLoading.show(status: 'Waiting...');
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      await Future.delayed(const Duration(seconds: 2));
      EasyLoading.dismiss();
      context.goNamed(
        AppRoutes.userProfile,
        queryParameters: {
          'userId': '1',
          'isMe': 'true',
        },
      );

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
        onPrimary: _updateProfile,
        primaryColor: Theme.of(context).colorScheme.error,
      );
    }
  }
}
