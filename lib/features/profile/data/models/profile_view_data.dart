import 'package:second_hand_electronics_marketplace/features/profile/data/models/user_model.dart';
enum ProfileType {
  public,
  private,
}

class ProfileViewData {
  final String name;
  final String avatar;
  final String location;
  final String memberSince;
  final String? lastSeen;
  final String? responseTime;
  final bool isOnline;

  // private-only
  final String? email;
  final String? phone;

  const ProfileViewData({
    required this.name,
    required this.avatar,
    required this.location,
    required this.memberSince,
    required this.isOnline,
    this.lastSeen,
    this.responseTime,
    this.email,
    this.phone,
  });

  factory ProfileViewData.fromUser(
      UserModel user, {
        required ProfileType type,
      }) {
    return ProfileViewData(
      name: user.name,
      avatar: user.avatar,
      location: user.location,
      memberSince: _formatDate(user.createdAt),
      isOnline: user.isOnline,
      lastSeen: type == ProfileType.public
          ? _formatLastSeen(user.lastSeen)
          : null,
      responseTime: type == ProfileType.public
          ? _formatResponseTime(user.responseTimeMinutes)
          : 'Replies within ${user.responseTimeMinutes} min',


      email: type == ProfileType.private ? user.email : 'user@email.com' ,
      phone: type == ProfileType.private ? user.phone: '+970...',
    );
  }
  factory ProfileViewData.fromModel(
      UserModel user, {
        required ProfileType type,
      }) {
    return ProfileViewData(
      name: user.name,
      avatar: user.avatar,
      location: user.location,
      memberSince: _formatDate(user.createdAt),
      isOnline: user.isOnline,
      lastSeen: type == ProfileType.public
          ? _formatLastSeen(user.lastSeen)
          : null,
      responseTime: type == ProfileType.public
          ? _formatResponseTime(user.responseTimeMinutes)
          : 'Replies within ${user.responseTimeMinutes} min',
      email: type == ProfileType.private ? user.email : 'user@email.com',
      phone: type == ProfileType.private ? user.phone : '+970...',
    );
  }
}

String _formatDate(DateTime date) {
  return '${_monthName(date.month)} ${date.year}';
}

String _monthName(int month) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return months[month - 1];
}

String _formatLastSeen(DateTime lastSeen) {
  final duration = DateTime.now().difference(lastSeen);

  if (duration.inMinutes < 60) {
    return '${duration.inMinutes} minutes ago';
  } else if (duration.inHours < 24) {
    return '${duration.inHours} hours ago';
  } else {
    return '${duration.inDays} days ago';
  }
}

String _formatResponseTime(int minutes) {
  if (minutes < 60) {
    return 'Replies within $minutes min';
  } else {
    final hours = (minutes / 60).ceil();
    return 'Replies within $hours hr';
  }
}
