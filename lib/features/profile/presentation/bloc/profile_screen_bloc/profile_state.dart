// import '../../../../auth/data/models/auth_models.dart';
// import '../../../data/models/user_model.dart';
//
// abstract class ProfileState {}
//
// class ProfileLoading extends ProfileState {}
//
// class ProfileLoaded extends ProfileState {
//   final AppUserModel profile;
//   final bool isMe;
//
//   ProfileLoaded({required this.profile, required this.isMe});
// }
//
// class ProfileError extends ProfileState {
//   final String message;
//
//   ProfileError(this.message);
// }
part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final AppUserModel appUser;
  final bool isMe;

  ProfileLoaded({required this.appUser, required this.isMe});
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}