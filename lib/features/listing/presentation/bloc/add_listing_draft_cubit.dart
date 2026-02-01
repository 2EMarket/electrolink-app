import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/models/add_listing_draft.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/models/listing_field_config.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/models/listing_photo_item.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/services/listing_catalog_service.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/services/listing_draft_storage.dart';
import 'package:second_hand_electronics_marketplace/features/location/data/models/location_model.dart';

import 'add_listing_draft_state.dart';

class AddListingDraftCubit extends Cubit<AddListingDraftState> {
  AddListingDraftCubit({
    ListingCatalogService? catalogService,
    ListingDraftStorage? draftStorage,
  })  : _catalogService = catalogService ?? ListingCatalogService(),
        _draftStorage = draftStorage ?? ListingDraftStorage(),
        super(AddListingDraftState.initial());

  final ListingCatalogService _catalogService;
  final ListingDraftStorage _draftStorage;

  ListingCategoryConfig? get selectedCategoryConfig {
    return _catalogService.getCategoryConfig(state.draft.category);
  }

  List<ListingCategoryConfig> get categories => _catalogService.getCategories();

  Future<void> loadDraft() async {
    emit(state.copyWith(isLoadingDraft: true));
    final draft = await _draftStorage.readDraft();
    final loadedDraft = draft ?? const AddListingDraft();
    _emitDraft(loadedDraft, isLoadingDraft: false);
  }

  void setStep(AddListingStep step) {
    emit(state.copyWith(step: step));
  }

  void nextStep() {
    if (!state.canProceed) return;
    emit(state.copyWith(step: AddListingStep.more));
  }

  void prevStep() {
    emit(state.copyWith(step: AddListingStep.basic));
  }

  void updateTitle(String value) {
    _emitDraft(state.draft.copyWith(title: value));
  }

  void updateCategory(String value) {
    _emitDraft(
      state.draft.copyWith(category: value, attributes: const {}),
    );
  }

  void updateCondition(String value) {
    _emitDraft(state.draft.copyWith(condition: value));
  }

  void updatePrice(String value) {
    _emitDraft(state.draft.copyWith(price: value));
  }

  void toggleNegotiable(bool value) {
    _emitDraft(state.draft.copyWith(negotiable: value));
  }

  void updateDescription(String value) {
    _emitDraft(state.draft.copyWith(description: value));
  }

  void updateAttribute(String key, String value) {
    final updated = Map<String, String>.from(state.draft.attributes);
    updated[key] = value;
    _emitDraft(state.draft.copyWith(attributes: updated));
  }

  void updateLocation(LocationModel location) {
    _emitDraft(state.draft.copyWith(location: location));
  }

  void toggleConfirmNotStolen(bool value) {
    _emitDraft(state.draft.copyWith(confirmNotStolen: value));
  }

  void updatePhotos(List<ListingPhotoItem> photos) {
    if (_samePhotos(state.draft.photos, photos)) return;
    _emitDraft(state.draft.copyWith(photos: photos));
  }

  Future<void> saveDraft() async {
    if (state.draft.isEmpty) return;
    try {
      await _draftStorage.writeDraft(state.draft);
    } catch (_) {}
  }

  void resetAfterSubmit() {
    emit(AddListingDraftState.initial());
  }

  void _emitDraft(
    AddListingDraft draft, {
    bool? isLoadingDraft,
  }) {
    final computed = _computeFlags(draft);
    emit(
      state.copyWith(
        draft: draft,
        isLoadingDraft: isLoadingDraft ?? state.isLoadingDraft,
        canProceed: computed.canProceed,
        canPublish: computed.canPublish,
      ),
    );
  }

  ({bool canProceed, bool canPublish}) _computeFlags(AddListingDraft draft) {
    final hasValidPhoto = draft.photos.any(
      (p) => p.status == ListingPhotoStatus.ready,
    );
    final hasPhotoError = draft.photos.any(
      (p) =>
          p.status == ListingPhotoStatus.tooLarge ||
          p.status == ListingPhotoStatus.error,
    );

    final basicReady =
        hasValidPhoto &&
        !hasPhotoError &&
        draft.title.trim().isNotEmpty &&
        draft.category.trim().isNotEmpty &&
        draft.condition.trim().isNotEmpty &&
        draft.price.trim().isNotEmpty;

    final config = _catalogService.getCategoryConfig(draft.category);
    final requiredFields =
        config?.fields.where((f) => f.required).toList() ?? [];

    final requiredOk = requiredFields.every(
      (f) => (draft.attributes[f.key] ?? '').trim().isNotEmpty,
    );

    final moreReady =
        basicReady &&
        requiredOk &&
        draft.location != null &&
        draft.confirmNotStolen;

    return (canProceed: basicReady, canPublish: moreReady);
  }

  bool _samePhotos(List<ListingPhotoItem> a, List<ListingPhotoItem> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
