class TransactionModel {
  final String id;
  final DateTime createdAt;
  final String amount;
  final String fromUserId;
  final String toUserId;

  TransactionModel({required this.id, required this.createdAt, required this.amount, required this.fromUserId, required this.toUserId});

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'amount': amount,
      'from_user_id': fromUserId,
      'to_user_id': toUserId,
    };
  }

  static TransactionModel fromMap(Map<String, dynamic> data) {
    return TransactionModel(
      id: data['id'] as String,
      createdAt: data['created_at'] as DateTime,
      amount: data['amount'] as String,
      fromUserId: data['from_user_id'] as String,
      toUserId: data['to_user_id'] as String,      
    );
  }
}
