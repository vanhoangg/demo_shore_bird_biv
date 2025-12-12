import 'package:flutter_bloc/flutter_bloc.dart';
import 'finance_v1_event.dart';
import 'finance_v1_state.dart';

class FinanceV1Bloc extends Bloc<FinanceV1Event, FinanceV1State> {
  FinanceV1Bloc() : super(const FinanceV1State()) {
    on<RevenueChanged>(_onRevenueChanged);
    on<ExpenseChanged>(_onExpenseChanged);
    on<CalculateProfit>(_onCalculateProfit);
  }

  void _onRevenueChanged(RevenueChanged event, Emitter<FinanceV1State> emit) {
    emit(state.copyWith(revenue: event.revenue));
  }

  void _onExpenseChanged(ExpenseChanged event, Emitter<FinanceV1State> emit) {
    emit(state.copyWith(expense: event.expense));
  }

  void _onCalculateProfit(CalculateProfit event, Emitter<FinanceV1State> emit) {
    final double revenue = _toDouble(state.revenue);
    final double expense = _toDouble(state.expense);
    final double profit = revenue - expense;

    emit(state.copyWith(profit: profit));
  }

  double _toDouble(String value) => double.tryParse(value.trim()) ?? 0.0;
}
