import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import '../../../../../configs/theme/app_colors.dart';
import '../../../../../configs/theme/app_typography.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/constants/app_sizes.dart';

// you can use this vertical More Icon function to show the bottom sheet
void showCustomBottomSheet(BuildContext context, Widget widget) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.colors.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          AppSizes.bottomSheetRadiusTop,
        ), // Bottom sheet top radius
      ),
    ),
    builder: (_) => widget,
  );
}

class BottomSheetProfileOptions extends StatelessWidget {
  const BottomSheetProfileOptions();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 134,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingM,
        AppSizes.paddingM,
        AppSizes.paddingM,
        0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                'Options',
                style: AppTypography.body16Medium.copyWith(
                  color: context.colors.titles,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => context.pop(),
                icon: Container(
                  width: 19,
                  height: 19,
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colors.icons, width: 1.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.close, size: 11),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                onTap: () {
                  context.pop(); // أولًا تغلق الـ bottom sheet
                  context.goNamed(AppRoutes.reportUser); // ثم تنتقل للصفحة
                },
                child: Text(
                  'Report',
                  style: AppTypography.body14Regular.copyWith(
                    color: context.colors.titles,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetPhotoOptions extends StatelessWidget {
  const BottomSheetPhotoOptions();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingM,
        AppSizes.paddingM,
        AppSizes.paddingM,
        0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                'Photo Options',
                style: AppTypography.body16Medium.copyWith(
                  color: context.colors.titles,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => context.pop(),
                icon: Container(
                  width: 19,
                  height: 19,
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colors.icons, width: 1.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.close, size: 11),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius10,
                      ),
                      border: Border.all(
                        color: context.colors.border,
                        width: 0.3,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppSizes.paddingS),
                        child: ListTile(
                          leading: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: context.colors.mainColor.withOpacity(0.10),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(AppSizes.paddingXS),
                              child: SvgPicture.asset(
                                AppAssets.cameraIcon,
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ),
                          title: Text(
                            'Take Photo',
                            style: AppTypography.body16Regular.copyWith(
                              color: context.colors.titles,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.paddingM),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius10,
                      ),
                      border: Border.all(
                        color: context.colors.border,
                        width: 0.3,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppSizes.paddingS),
                        child: ListTile(
                          leading: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: context.colors.mainColor.withOpacity(0.10),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(AppSizes.paddingXS),
                              child: SvgPicture.asset(
                                AppAssets.galleryIcon,
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ),
                          title: Text(
                            'Choose from Gallery',
                            style: AppTypography.body16Regular.copyWith(
                              color: context.colors.titles,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
