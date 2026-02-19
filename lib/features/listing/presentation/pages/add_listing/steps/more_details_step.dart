import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/theme_exports.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_sizes.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/custom_textfield.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/labeled_checkbox.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/models/listing_field_config.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/bloc/add_listing_draft_cubit.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/bloc/add_listing_draft_state.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/widgets/listing_select_field.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/widgets/listing_selection_sheet.dart';

/// UI step shown during the "Add Listing" flow.
///
/// Renders extra, category-specific fields (dynamically), plus description,
/// location selector, and the confirmation checkbox.
class MoreDetailsStep extends StatelessWidget {
  const MoreDetailsStep({
    super.key,
    required this.descriptionController,
    required this.attributeControllers,
    required this.onOpenLocation,
  });

  /// Controller for the multi-line description field.
  final TextEditingController descriptionController;

  /// Map that caches `TextEditingController`s for each dynamic attribute key.
  ///
  /// The widget stores controllers here so that user input is preserved across
  /// rebuilds while the form is being edited.
  final Map<String, TextEditingController> attributeControllers;

  /// Callback invoked when the user taps the Location selector.
  final VoidCallback onOpenLocation;

  @override
  Widget build(BuildContext context) {
    // Pull theme colors from BuildContext extension.
    final colors = context.colors;

    // Rebuild when the AddListingDraft state changes.
    return BlocBuilder<AddListingDraftCubit, AddListingDraftState>(
      builder: (context, state) {
        // Obtain the cubit instance to issue updates (attribute, description etc.).
        final draftCubit = context.read<AddListingDraftCubit>();

        // Selected category configuration (may be null if not chosen yet).
        final config = draftCubit.selectedCategoryConfig;

        // List of dynamic fields to render for the selected category.
        final fields = config?.fields ?? <ListingFieldConfig>[];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section title.
            Text(
              'More Details',
              style: AppTypography.h3_18Medium.copyWith(color: colors.titles),
            ),
            const SizedBox(height: AppSizes.paddingM),

            // Render category-defined fields dynamically.
            // Each `ListingFieldConfig` can be a text, number, or selection.
            ...fields.map((field) {
              // Selection field: show a tappable selector which opens a bottom sheet
              // containing the available options (field.options).
              if (field.type == ListingFieldType.selection) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.paddingM),
                  child: ListingSelectField(
                    label: field.label,
                    // Use the current value from the draft, fallback to empty.
                    value: state.draft.attributes[field.key] ?? '',
                    isRequired: field.required,
                    onTap: () {
                      // Show a modal bottom sheet with the list of choices.
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder:
                            (_) => FractionallySizedBox(
                              heightFactor: 0.9,
                              child: ListingSelectionSheet(
                                title: field.label,
                                options: field.options,
                                selectedValue:
                                    state.draft.attributes[field.key] ?? '',
                                // When a user selects an option, update the draft via cubit.
                                onSelected:
                                    (value) => draftCubit.updateAttribute(
                                      field.key,
                                      value,
                                    ),
                              ),
                            ),
                      );
                    },
                  ),
                );
              }

              // For text/number fields we reuse or create a controller per-key so
              // the typed value is preserved across rebuilds.
              final controller =
                  attributeControllers[field.key] ??
                  (attributeControllers[field.key] = TextEditingController(
                    text: state.draft.attributes[field.key] ?? '',
                  ));

              return Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.paddingM),
                child: CustomTextField(
                  label: field.label,
                  isRequired: field.required,
                  // Use provided hint or a default one built from the label.
                  hintText:
                      field.hint.isEmpty
                          ? 'Enter ${field.label.toLowerCase()}'
                          : field.hint,
                  controller: controller,
                  // Use number keyboard for numerical fields.
                  keyboardType:
                      field.type == ListingFieldType.number
                          ? TextInputType.number
                          : TextInputType.text,
                  // Propagate changes to the cubit so shared draft state stays in sync.
                  onChanged:
                      (value) => draftCubit.updateAttribute(field.key, value),
                ),
              );
            }),

            // Free-form description field (not part of dynamic category fields).
            CustomTextField(
              label: 'Description',
              hintText:
                  'Mention usage time, defects, accessories included, and reason for selling',
              controller: descriptionController,
              maxLines: 4,
              maxLength: 500,
              // Send description updates to the cubit.
              onChanged: draftCubit.updateDescription,
            ),

            const SizedBox(height: AppSizes.paddingM),

            // Location selector. The actual location picker logic is handled by
            // the parent through the supplied `onOpenLocation` callback.
            ListingSelectField(
              label: 'Location',
              value: state.draft.location?.address ?? '',
              isRequired: true,
              placeholder: 'Where the listing is available',
              onTap: onOpenLocation,
            ),

            const SizedBox(height: AppSizes.paddingM),

            // Confirmation checkbox required by the form.
            LabeledCheckbox(
              value: state.draft.confirmNotStolen,
              onChanged: (v) => draftCubit.toggleConfirmNotStolen(v ?? false),
              label: 'I confirm this item is not stolen or prohibited',
              showRequiredStar: true,
              labelStyle: AppTypography.body14Regular.copyWith(
                color: colors.text,
              ),
            ),
          ],
        );
      },
    );
  }
}
