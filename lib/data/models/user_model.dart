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
      'createdAt': createdAt,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicture': profilePicture,
      'walletAddress': walletAddress,
      'authUserId': authUserId,
    };
  }

  static UserModel fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] as String,
      username: data['username'] as String,
      email: data['email'] as String,
      bio: data['bio'] as String,
      createdAt: data['createdAt'] as DateTime,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      profilePicture: data['profilePicture'] as String,
      walletAddress: data['walletAddress'] as String,
      authUserId: data['authUserId'] as String,
    );
  }

}
