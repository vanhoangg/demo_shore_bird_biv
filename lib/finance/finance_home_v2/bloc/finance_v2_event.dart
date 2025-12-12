import 'package:equatable/equatable.dart';

abstract class FinanceV2Event extends Equatable {
  const FinanceV2Event();

  @override
  List<Object?> get props => <Object?>[];
}

class RevenueChanged extends FinanceV2Event {

  const RevenueChanged(this.revenue);
  final String revenue;

  @override
  List<Object?> get props => <Object?>[revenue];
}

class ExpenseChanged extends FinanceV2Event {

  const ExpenseChanged(this.expense);
  final String expense;

  @override
  List<Object?> get props => <Object?>[expense];
}

class DepreciationChanged extends FinanceV2Event {

  const DepreciationChanged(this.depreciation);
  final String depreciation;

  @override
  List<Object?> get props => <Object?>[depreciation];
}

class CalculateProfit extends FinanceV2Event {
  const CalculateProfit();
}
