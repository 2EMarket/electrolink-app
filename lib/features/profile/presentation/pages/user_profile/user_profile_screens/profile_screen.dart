import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../../../core/constants/constants_exports.dart';
import '../../../../../listing/data/listing_model.dart';
import '../../../../profile_exports.dart';
import '../../../widgets/profile_widgets_exports.dart';

class ProfileScreen extends StatelessWidget {
  final bool isMe;
  final String userId;

  const ProfileScreen({super.key, required this.userId, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => ProfileRepository(dataSource: ProfileMockDataSource()),
      child: BlocProvider(
        create:
            (context) =>
                ProfileBloc(repository: context.read<ProfileRepository>())
                  ..add(LoadProfile(userId: userId, isMe: isMe)),
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoading) {
              EasyLoading.show(status: 'Loading...');
            } else {
              EasyLoading.dismiss();
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileError) return ProfileErrorScreen();
              if (state is ProfileLoaded) {
                final profileData = ProfileViewData.fromUser(
                  state.profile,
                  type: state.isMe ? ProfileType.private : ProfileType.public,
                );
                final verificationProgress = 0.3; // mock progress
                final userListings =
                    dummyListings
                        .where((l) => l.ownerId == state.profile.id)
                        .toList();
                return Scaffold(
                  appBar: AppBar(
                    title: Text(profileData.name),
                    actions: [ProfileAppBarActions(isMe: state.isMe)],
                  ),
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSizes.paddingM,
                      AppSizes.paddingM,
                      AppSizes.paddingM,
                      AppSizes.paddingL,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        ProfileHeader(
                          profile: profileData,
                          type:
                              state.isMe
                                  ? ProfileType.private
                                  : ProfileType.public,
                        ),
                        SizedBox(height: AppSizes.paddingS),
                        if (state.isMe)
                          PrivateProfileCompletion(
                            verificationProgress: verificationProgress,
                          ),
                        SizedBox(
                          height:
                              state.isMe
                                  ? AppSizes.paddingM
                                  : AppSizes.paddingXXS,
                        ),
                        state.isMe
                            ? PrivateProfileWidget(userListings: userListings)
                            : PublicProfileWidget(userListings: userListings),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
