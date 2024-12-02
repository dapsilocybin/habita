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
      'createdAt': createdAt,
      'amount': amount,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
    };
  }

  static TransactionModel fromMap(Map<String, dynamic> data) {
    return TransactionModel(
      id: data['id'] as String,
      createdAt: data['createdAt'] as DateTime,
      amount: data['amount'] as String,
      fromUserId: data['fromUserId'] as String,
      toUserId: data['toUserId'] as String,      
    );
  }
}
