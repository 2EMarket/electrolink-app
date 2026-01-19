import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../configs/theme/app_colors.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/constants/app_sizes.dart';

// you can use this vertical More Icon function to show the bottom sheet
void showCustomBottomSheet(BuildContext context) {
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
    builder: (_) => const BottomSheetProfileOptions(),
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
              Text('Options', style: Theme.of(context).textTheme.titleSmall),
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
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
