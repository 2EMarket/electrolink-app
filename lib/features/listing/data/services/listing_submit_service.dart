import 'dart:async';
import 'package:second_hand_electronics_marketplace/features/listing/data/models/add_listing_draft.dart';

enum ListingSubmitResult { success, offline, failure }

class ListingSubmitService {
  final bool simulateOffline;

  ListingSubmitService({this.simulateOffline = false});

  Future<ListingSubmitResult> submitListing(AddListingDraft draft) async {
    await Future.delayed(const Duration(seconds: 2));
    if (simulateOffline) return ListingSubmitResult.offline;
    return ListingSubmitResult.success;
  }
}
