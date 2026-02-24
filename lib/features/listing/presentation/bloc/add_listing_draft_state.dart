import 'package:equatable/equatable.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/models/add_listing_draft.dart';

enum AddListingStep { basic, more }

class AddListingDraftState extends Equatable {
  final AddListingDraft draft;
  final AddListingStep step;
  final bool isLoadingDraft;
  final bool canProceed;
  final bool canPublish;
  final String? errorMessage;

  const AddListingDraftState({
    required this.draft,
    this.step = AddListingStep.basic,
    this.isLoadingDraft = false,
    this.canProceed = false,
    this.canPublish = false,
    this.errorMessage,
  });

  factory AddListingDraftState.initial() {
    return const AddListingDraftState(draft: AddListingDraft());
  }

  AddListingDraftState copyWith({
    AddListingDraft? draft,
    AddListingStep? step,
    bool? isLoadingDraft,
    bool? canProceed,
    bool? canPublish,
    String? errorMessage,
  }) {
    return AddListingDraftState(
      draft: draft ?? this.draft,
      step: step ?? this.step,
      isLoadingDraft: isLoadingDraft ?? this.isLoadingDraft,
      canProceed: canProceed ?? this.canProceed,
      canPublish: canPublish ?? this.canPublish,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    draft,
    step,
    isLoadingDraft,
    canProceed,
    canPublish,
    errorMessage,
  ];
}
