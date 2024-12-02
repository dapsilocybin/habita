class UserModel {
  final String id;
  final String username;
  final String email;
  final String bio;
  final DateTime createdAt;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final String walletAddress;
  final String authUserId;

  UserModel({required this.id, required this.username, required this.email, required this.bio, required this.createdAt, required this.firstName, required this.lastName, required this.profilePicture, required this.walletAddress, required this.authUserId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'bio': bio,
      'created_at': createdAt,
      'first_name': firstName,
      'last_name': lastName,
      'profile_picture': profilePicture,
      'wallet_address': walletAddress,
      'auth_user_id': authUserId,
    };
  }

  static UserModel fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] as String,
      username: data['username'] as String,
      email: data['email'] as String,
      bio: data['bio'] as String,
      createdAt: data['created_at'] as DateTime,
      firstName: data['first_name'] as String,
      lastName: data['last_name'] as String,
      profilePicture: data['profile_picture'] as String,
      walletAddress: data['wallet_address'] as String,
      authUserId: data['auth_user_id'] as String,
    );
  }

}
