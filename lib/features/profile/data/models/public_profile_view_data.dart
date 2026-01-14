import 'package:second_hand_electronics_marketplace/features/profile/data/models/user_model.dart';

class PublicProfileViewData {
  final String name;
  final String avatar;
  final String location;
  final String memberSince;
  final String lastSeen;
  final String responseTime;

  const PublicProfileViewData({
    required this.name,
    required this.avatar,
    required this.location,
    required this.memberSince,
    required this.lastSeen,
    required this.responseTime,
  });

  factory PublicProfileViewData.fromUser(UserModel user) {
    return PublicProfileViewData(
      name: user.name,
      avatar: user.avatar,
      location: user.location,
      memberSince: _formatDate(user.createdAt),
      lastSeen: _formatLastSeen(user.lastSeen),
      responseTime: _formatResponseTime(user.responseTimeMinutes),
    );
  }
}

String _formatDate(DateTime date) {
  // نعرض الشهر والسنة فقط
  return '${_monthName(date.month)} ${date.year}';
}

String _monthName(int month) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return months[month - 1];
}

// output: May 2023
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

// إذا آخر ظهور قبل ساعة:
// output: 1 hour ago
String _formatResponseTime(int minutes) {
  if (minutes < 60) {
    return 'Replies within $minutes min';
  } else {
    final hours = (minutes / 60).ceil();
    return 'Replies within $hours hr';
  }
}

// minutes = 60 → "Replies within 1 hr"
