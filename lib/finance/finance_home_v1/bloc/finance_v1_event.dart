import 'package:equatable/equatable.dart';

/// Base class for Finance V1 events
abstract class FinanceV1Event extends Equatable {
  /// Creates a FinanceV1Event
  const FinanceV1Event();

  @override
  List<Object?> get props => <Object?>[];
}

/// Event when revenue value changes
class RevenueChanged extends FinanceV1Event {
  /// Creates a RevenueChanged event
  const RevenueChanged(this.revenue);

  /// The new revenue value
  final String revenue;

  @override
  List<Object?> get props => <Object?>[revenue];
}

/// Event when expense value changes
class ExpenseChanged extends FinanceV1Event {
  /// Creates an ExpenseChanged event
  const ExpenseChanged(this.expense);

  /// The new expense value
  final String expense;

  @override
  List<Object?> get props => <Object?>[expense];
}

/// Event to calculate profit
class CalculateProfit extends FinanceV1Event {
  /// Creates a CalculateProfit event
  const CalculateProfit();
}
