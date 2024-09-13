class Earning {
  final double totalEarnings;
  final double withdrawals;
  final double deductions;
  final double totalIncome;
  final double totalExpenses;
  final List<RecentTransaction> recentTransactions;

  Earning({
    required this.totalEarnings,
    required this.withdrawals,
    required this.deductions,
    required this.totalIncome,
    required this.totalExpenses,
    required this.recentTransactions,
  });

  factory Earning.fromJson(Map<String, dynamic> json) {
    return Earning(
      totalEarnings: json['total_earnings'].toDouble(),
      withdrawals: json['withdrawals'].toDouble(),
      deductions: json['deductions'].toDouble(),
      totalIncome: json['total_income'].toDouble(),
      totalExpenses: json['total_expenses'].toDouble(),
      recentTransactions: (json['recent_transactions'] as List)
          .map((transaction) => RecentTransaction.fromJson(transaction))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_earnings': totalEarnings,
      'withdrawals': withdrawals,
      'deductions': deductions,
      'total_income': totalIncome,
      'total_expenses': totalExpenses,
      'recent_transactions': recentTransactions
          .map((transaction) => transaction.toJson())
          .toList(),
    };
  }
}

class RecentTransaction {
  final int id;
  final String transactionType;
  final String transactionSource;
  final String amount;
  final String date;
  final String status;
  final String description;
  final int user;
  final dynamic wallet;
  final dynamic paymobTransactionDatabaseId;

  RecentTransaction({
    required this.id,
    required this.transactionType,
    required this.transactionSource,
    required this.amount,
    required this.date,
    required this.status,
    required this.description,
    required this.user,
    this.wallet,
    this.paymobTransactionDatabaseId,
  });

  factory RecentTransaction.fromJson(Map<String, dynamic> json) {
    return RecentTransaction(
      id: json['id'],
      transactionType: json['transaction_type'],
      transactionSource: json['transaction_source'],
      amount: json['amount'],
      date: json['date'],
      status: json['status'],
      description: json['description'],
      user: json['user'],
      wallet: json['wallet'],
      paymobTransactionDatabaseId: json['paymob_transaction_database_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transaction_type': transactionType,
      'transaction_source': transactionSource,
      'amount': amount,
      'date': date,
      'status': status,
      'description': description,
      'user': user,
      'wallet': wallet,
      'paymob_transaction_database_id': paymobTransactionDatabaseId,
    };
  }
}
