class UserModel {
  final String id;
  final String name;
  final String avatar;
  final String location;
  final DateTime createdAt;
  final DateTime lastSeen;
  final int responseTimeMinutes;
  final bool isOnline;
  final String? email;
  final String? phone;

  const UserModel({
    required this.id,
    required this.name,
    required this.avatar,

    required this.location,
    required this.createdAt,
    required this.lastSeen,
    required this.responseTimeMinutes,
    this.isOnline = false,
    this.email = 'james.monroe@example.com',
    this.phone = '059788464'
  });
}
