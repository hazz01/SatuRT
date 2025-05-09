enum TransactionType {
  income,
  expense,
  pending,
}

class Transaction {
  final String id;
  final String name;
  final String date;
  final double amount;
  final TransactionType type;
  final String description;

  Transaction({
    required this.id,
    required this.name,
    required this.date,
    required this.amount,
    required this.type,
    required this.description,
  });
}
