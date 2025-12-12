import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../../../theme/finance_theme.dart';
import '../../shared/components/calculate_button.dart';
import '../../shared/components/glass_card.dart';
import '../../shared/components/number_input_field.dart';
import '../bloc/finance_v1_bloc.dart';
import '../bloc/finance_v1_event.dart';
import '../bloc/finance_v1_state.dart';

class InputSectionV1 extends StatefulWidget {
  const InputSectionV1({
    required this.theme,
    required this.strings,
    super.key,
    this.revenueKey,
    this.expenseKey,
    this.calculateKey,
  });

  final FinanceThemeData theme;
  final AppLocalizationStrings strings;
  final Key? revenueKey;
  final Key? expenseKey;
  final Key? calculateKey;

  @override
  State<InputSectionV1> createState() => _InputSectionV1State();
}

class _InputSectionV1State extends State<InputSectionV1> {
  late TextEditingController _revenueController;
  late TextEditingController _expenseController;

  @override
  void initState() {
    super.initState();
    _revenueController = TextEditingController();
    _expenseController = TextEditingController();
  }

  @override
  void dispose() {
    _revenueController.dispose();
    _expenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<FinanceV1Bloc, FinanceV1State>(
        builder: (BuildContext context, FinanceV1State state) {
          final FinanceV1Bloc bloc = context.read<FinanceV1Bloc>();

          if (_revenueController.text != state.revenue) {
            _revenueController.text = state.revenue;
          }
          if (_expenseController.text != state.expense) {
            _expenseController.text = state.expense;
          }

          return GlassCard(
            theme: widget.theme,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                NumberInputField(
                  fieldKey: widget.revenueKey,
                  controller: _revenueController,
                  label: widget.strings.revenueLabel,
                  theme: widget.theme,
                  onChanged: (String value) {
                    bloc.add(RevenueChanged(value));
                  },
                ),
                const SizedBox(height: 16),
                NumberInputField(
                  fieldKey: widget.expenseKey,
                  controller: _expenseController,
                  label: widget.strings.expenseLabel,
                  theme: widget.theme,
                  onChanged: (String value) {
                    bloc.add(ExpenseChanged(value));
                  },
                ),
                const SizedBox(height: 24),
                CalculateButton(
                  buttonKey: widget.calculateKey,
                  theme: widget.theme,
                  strings: widget.strings,
                  onPressed: () {
                    bloc.add(const CalculateProfit());
                  },
                ),
              ],
            ),
          );
        },
      );
}
