class Earning {
  final double totalEarnings;
  final double withdrawals;
  final double deductions;
  final double monthlyEarning;
  final double monthlyWidthdrawals;


  Earning({
    required this.totalEarnings,
    required this.withdrawals,
    required this.deductions,
    required this.monthlyEarning,
    required this.monthlyWidthdrawals,

  });

  factory Earning.fromJson(Map<String, dynamic> json) {
    return Earning(
      totalEarnings: json['total_earnings'].toDouble(),
      withdrawals: json['total_deductions'].toDouble(),
      deductions: json['total_deductions'].toDouble(),
      monthlyEarning: json['this_month_earnings'].toDouble(),
      monthlyWidthdrawals: json['this_month_withdrawals'].toDouble(),
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_earnings': totalEarnings,
      'withdrawals': withdrawals,
      'deductions': deductions,
      'total_income': monthlyEarning,
      'total_expenses': monthlyWidthdrawals,
    
    };
  }
}
