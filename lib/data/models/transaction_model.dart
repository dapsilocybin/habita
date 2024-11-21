class TransactionModel {
  final String id;
  final DateTime createdAt;
  final String amount;
  final String fromUserId;
  final String toUserId;

  TransactionModel({required this.id, required this.createdAt, required this.amount, required this.fromUserId, required this.toUserId});
}
