import 'package:flutter_bloc/flutter_bloc.dart';
import 'finance_v2_event.dart';
import 'finance_v2_state.dart';

class FinanceV2Bloc extends Bloc<FinanceV2Event, FinanceV2State> {
  FinanceV2Bloc() : super(const FinanceV2State()) {
    on<RevenueChanged>(_onRevenueChanged);
    on<ExpenseChanged>(_onExpenseChanged);
    on<DepreciationChanged>(_onDepreciationChanged);
    on<CalculateProfit>(_onCalculateProfit);
  }

  void _onRevenueChanged(RevenueChanged event, Emitter<FinanceV2State> emit) {
    emit(state.copyWith(revenue: event.revenue));
  }

  void _onExpenseChanged(ExpenseChanged event, Emitter<FinanceV2State> emit) {
    emit(state.copyWith(expense: event.expense));
  }

  void _onDepreciationChanged(
    DepreciationChanged event,
    Emitter<FinanceV2State> emit,
  ) {
    emit(state.copyWith(depreciation: event.depreciation));
  }

  void _onCalculateProfit(CalculateProfit event, Emitter<FinanceV2State> emit) {
    final double revenue = _toDouble(state.revenue);
    final double expense = _toDouble(state.expense);
    final double depreciation = _toDouble(state.depreciation);
    final double profit = revenue - expense - depreciation;

    emit(state.copyWith(profit: profit));
  }

  double _toDouble(String value) => double.tryParse(value.trim()) ?? 0.0;
}
