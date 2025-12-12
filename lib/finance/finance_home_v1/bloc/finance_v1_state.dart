import 'package:equatable/equatable.dart';

/// State for Finance V1 screen
class FinanceV1State extends Equatable {
  /// Creates a FinanceV1State
  const FinanceV1State({
    this.revenue = '',
    this.expense = '',
    this.profit = 0.0,
  });

  /// Revenue value
  final String revenue;

  /// Expense value
  final String expense;

  /// Calculated profit
  final double profit;

  /// Creates a copy with updated values
  FinanceV1State copyWith({String? revenue, String? expense, double? profit}) =>
      FinanceV1State(
        revenue: revenue ?? this.revenue,
        expense: expense ?? this.expense,
        profit: profit ?? this.profit,
      );

  @override
  List<Object?> get props => <Object?>[revenue, expense, profit];
}
