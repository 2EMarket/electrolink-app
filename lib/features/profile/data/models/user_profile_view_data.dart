import 'package:second_hand_electronics_marketplace/features/profile/data/models/user_model.dart';

class UserProfileViewData {
  final String name;
  final String avatar;
  final String email;
  final String phone;
  final String memberSince;

  const UserProfileViewData({
    required this.name,
    required this.avatar,
    required this.email,
    required this.phone,
    required this.memberSince,
  });

  factory UserProfileViewData.fromUser(UserModel user) {
    return UserProfileViewData(
      name: user.name,
      avatar: user.avatar,
      memberSince: _formatDate(user.createdAt),
      email: 'user@email.com', // لاحقًا من API
      phone: '+970...',
    );
  }
}
String _formatDate(DateTime date) {
  // نعرض الشهر والسنة فقط
  return '${_monthName(date.month)} ${date.year}';
}

String _monthName(int month) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return months[month - 1];
}
