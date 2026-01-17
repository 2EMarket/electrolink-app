
import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../constants/app_sizes.dart';

class EmptyListingsSection extends StatelessWidget {
  const EmptyListingsSection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          children: [
            Image.asset(
              AppAssets.noListing,
              width: 94,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: AppSizes.paddingM),
            Text(
              'This user has no active listing',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
