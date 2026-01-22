import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;
  ProfileBloc({required this.repository}) : super(ProfileLoading()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await repository.getUser(event.userId);
        emit(ProfileLoaded(profile: user, isMe: event.isMe));
      } catch (e) {
        emit(ProfileError('Failed to load profile'));
      }
    });
  }
}

