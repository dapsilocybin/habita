class FollowedUser {
  final String id;
  final String username;
  final String fullName;

  const FollowedUser({
    required this.id,
    required this.username,
    required this.fullName,
  });

  factory FollowedUser.fromMap(Map<String, dynamic> map) {
    return FollowedUser(
      id: map['id'] as String,
      username: map['username'] as String? ?? '',
      fullName: map['full_name'] as String? ?? '',
    );
  }
}
