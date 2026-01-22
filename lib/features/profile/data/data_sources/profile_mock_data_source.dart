import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';

import '../models/user_model.dart';
/*
class ProfileMockDataSource {
  Future<UserModel> getProfile(String userId) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network
    return UserModel(
      id: '1',
      name: 'Eleanor Vance',
      avatar: AppAssets.profilePic,
      location: 'Berlin',
      createdAt: DateTime(2023, 5, 1),
      lastSeen: DateTime.now().subtract(const Duration(hours: 1)),
      responseTimeMinutes: 60,
      isOnline: true,
    );
  }
}
*/
// Mock data source
class ProfileMockDataSource {
  final UserModel mockUser = UserModel(
    id: '1',
    name: 'Eleanor Vance',
    avatar: AppAssets.profilePic,
    location: 'Berlin',
    createdAt: DateTime(2023, 5, 1),
    lastSeen: DateTime.now().subtract(const Duration(hours: 1)),
    responseTimeMinutes: 60,
    isOnline: true,
    email: 'eleanor.vance@example.com',
    phone: '+970123456',
  );

  Future<UserModel> getUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500)); // simulate delay
    return mockUser;
  }
}
