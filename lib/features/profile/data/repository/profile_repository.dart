import '../data_sources/profile_mock_data_source.dart';
import '../models/user_model.dart';

// Repository
class ProfileRepository {
  final ProfileMockDataSource dataSource;

  ProfileRepository({required this.dataSource});

  Future<UserModel> getUser(String userId) => dataSource.getUser(userId);
}
