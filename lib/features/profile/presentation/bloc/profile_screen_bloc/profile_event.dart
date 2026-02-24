// abstract class ProfileEvent {}
//
// class LoadProfile extends ProfileEvent {
//   final String userId;
//   final bool isMe;
//
//   LoadProfile({required this.userId, required this.isMe});
// }
part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {
  final bool isMe; // هذا يحدد إذا البروفايل تبعنا أو شخص آخر

  FetchProfileEvent({required this.isMe});
}
class UpdateProfileEvent extends ProfileEvent {
  final Map<String, dynamic> updates;

  UpdateProfileEvent({required this.updates});
}