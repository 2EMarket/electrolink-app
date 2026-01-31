import 'package:flutter/material.dart';

import '../../../../../configs/theme/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import 'bottom_sheet_profile_options.dart';

class ProfileAppBarActions extends StatelessWidget {
  final bool isMe;

  const ProfileAppBarActions({super.key, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingS),
        child: Icon(
          isMe ? Icons.settings_rounded : Icons.more_vert,
          color: context.colors.icons,
        ),
      ),
      onPressed: () {
        if (isMe) {

        } else {
          // فعل الـ BottomSheet
          showProfileOptionsSheet(context, type: ProfileOptionType.report);
        }
      },
    );
  }
}
