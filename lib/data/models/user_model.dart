class UserModel {
  final String id;
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String bio;
  final String profilePicture;
  final List<int> followerIds;
  final List<int> followingIds;
  final List<int> medalIds;
  final List<int> registeredHabitIds;
  final String walletAddress;
  final double balance;

  UserModel({required this.id, required this.username, required this.email, required this.password, required this.firstName, required this.lastName, required this.bio, required this.profilePicture, required this.followerIds, required this.followingIds, required this.medalIds, required this.registeredHabitIds, required this.walletAddress, required this.balance});
}
