
import '../../../data/models/user_model.dart';

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel profile;
  final bool isMe;

  ProfileLoaded({required this.profile, required this.isMe});
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

