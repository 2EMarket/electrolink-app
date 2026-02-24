import 'package:equatable/equatable.dart';

enum AddListingSubmitStatus { idle, submitting, success, offline, failure }

class AddListingSubmitState extends Equatable {
  final AddListingSubmitStatus status;

  const AddListingSubmitState({this.status = AddListingSubmitStatus.idle});

  AddListingSubmitState copyWith({AddListingSubmitStatus? status}) {
    return AddListingSubmitState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
