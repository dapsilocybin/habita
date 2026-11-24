class ChatUser {
  const ChatUser({
    required this.id,
    required this.username,
    required this.fullName,
    this.avatarUrl,
  });

  final String id;
  final String username;
  final String fullName;
  final String? avatarUrl;

  String get displayName => fullName.trim().isNotEmpty ? fullName : username;
}
