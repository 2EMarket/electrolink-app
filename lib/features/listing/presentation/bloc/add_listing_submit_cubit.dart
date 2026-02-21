import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/models/add_listing_draft.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/services/listing_draft_storage.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/services/listing_submit_service.dart';

import 'add_listing_submit_state.dart';

class AddListingSubmitCubit extends Cubit<AddListingSubmitState> {
  AddListingSubmitCubit({
    ListingSubmitService? submitService,
    ListingDraftStorage? draftStorage,
  }) : _submitService = submitService ?? ListingSubmitService(),
       _draftStorage = draftStorage ?? ListingDraftStorage(),
       super(const AddListingSubmitState());

  final ListingSubmitService _submitService;
  final ListingDraftStorage _draftStorage;

  Future<void> submit(AddListingDraft draft, {required bool canPublish}) async {
    if (!canPublish) return;
    emit(state.copyWith(status: AddListingSubmitStatus.submitting));
    final result = await _submitService.submitListing(draft);
    if (result == ListingSubmitResult.success) {
      await _draftStorage.clearDraft();
      emit(state.copyWith(status: AddListingSubmitStatus.success));
    } else if (result == ListingSubmitResult.offline) {
      emit(state.copyWith(status: AddListingSubmitStatus.offline));
    } else {
      emit(state.copyWith(status: AddListingSubmitStatus.failure));
    }
  }

  void reset() {
    emit(state.copyWith(status: AddListingSubmitStatus.idle));
  }
}
