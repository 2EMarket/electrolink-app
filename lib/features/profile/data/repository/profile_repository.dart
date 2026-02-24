// import '../data_sources/profile_mock_data_source.dart';
// import '../models/user_model.dart';
//
// // Repository
// class ProfileRepository {
//   final ProfileMockDataSource dataSource;
//
//   ProfileRepository({required this.dataSource});
//
//   Future<UserModel> getUser(String userId) => dataSource.getUser(userId);
// }
import '../../../auth/data/models/auth_models.dart';
import '../services/profile_service.dart';
import '../models/user_model.dart';

class ProfileRepository {
  final ProfileService dataSource;

  ProfileRepository({required this.dataSource});

  /// جلب بيانات المستخدم الحالية
  Future<AppUserModel> getCurrentUser({required UserModel authUser}) async {
    return await dataSource.getCurrentUserProfile(authUser: authUser);
  }

  /// تحديث بيانات البروفايل
  Future<ProfileModel> updateProfile(Map<String, dynamic> updates) async {
    return await dataSource.updateProfile(updates: updates);
  }
}