import 'package:equatable/equatable.dart';

class FinanceV2State extends Equatable {

  const FinanceV2State({
    this.revenue = '',
    this.expense = '',
    this.depreciation = '',
    this.profit = 0.0,
  });
  final String revenue;
  final String expense;
  final String depreciation;
  final double profit;

  FinanceV2State copyWith({
    String? revenue,
    String? expense,
    String? depreciation,
    double? profit,
  }) => FinanceV2State(
      revenue: revenue ?? this.revenue,
      expense: expense ?? this.expense,
      depreciation: depreciation ?? this.depreciation,
      profit: profit ?? this.profit,
    );

  @override
  List<Object?> get props => <Object?>[revenue, expense, depreciation, profit];
}
