abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String userId;
  final bool isMe;

  LoadProfile({required this.userId, required this.isMe});
}
