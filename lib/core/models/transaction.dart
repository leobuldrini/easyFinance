class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String sector;
  final TransactionType transactionType;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.sector,
    required this.transactionType,
  });

  bool get isIncome {
    return transactionType.isIncome;
  }
  bool get isOutcome {
    return transactionType.isOutcome;
  }
}

enum TransactionType {
  income,
  outcome
}

extension TransactionTypeExtension on TransactionType {
  bool get isIncome {
    switch (this){
      case TransactionType.income:
        return true;
      case TransactionType.outcome:
        return false;
    }
  }

  bool get isOutcome {
    switch (this){
      case TransactionType.income:
        return false;
      case TransactionType.outcome:
        return true;
    }
  }
}