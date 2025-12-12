import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../../../theme/finance_theme.dart';
import '../../shared/components/calculate_button.dart';
import '../../shared/components/glass_card.dart';
import '../../shared/components/number_input_field.dart';
import '../bloc/finance_v2_bloc.dart';
import '../bloc/finance_v2_event.dart';
import '../bloc/finance_v2_state.dart';

class InputSectionV2 extends StatefulWidget {
  const InputSectionV2({
    required this.theme,
    required this.strings,
    super.key,
    this.revenueKey,
    this.expenseKey,
    this.depreciationKey,
    this.calculateKey,
  });

  final FinanceThemeData theme;
  final AppLocalizationStrings strings;
  final GlobalKey? revenueKey;
  final GlobalKey? expenseKey;
  final GlobalKey? depreciationKey;
  final GlobalKey? calculateKey;

  @override
  State<InputSectionV2> createState() => _InputSectionV2State();
}

class _InputSectionV2State extends State<InputSectionV2> {
  late TextEditingController _revenueController;
  late TextEditingController _expenseController;
  late TextEditingController _depreciationController;

  @override
  void initState() {
    super.initState();
    _revenueController = TextEditingController();
    _expenseController = TextEditingController();
    _depreciationController = TextEditingController();
  }

  @override
  void dispose() {
    _revenueController.dispose();
    _expenseController.dispose();
    _depreciationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<FinanceV2Bloc, FinanceV2State>(
        builder: (BuildContext context, FinanceV2State state) {
          final FinanceV2Bloc bloc = context.read<FinanceV2Bloc>();

          if (_revenueController.text != state.revenue) {
            _revenueController.text = state.revenue;
          }
          if (_expenseController.text != state.expense) {
            _expenseController.text = state.expense;
          }
          if (_depreciationController.text != state.depreciation) {
            _depreciationController.text = state.depreciation;
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
                const SizedBox(height: 16),
                NumberInputField(
                  fieldKey: widget.depreciationKey,
                  controller: _depreciationController,
                  label: widget.strings.depreciationLabel,
                  theme: widget.theme,
                  onChanged: (String value) {
                    bloc.add(DepreciationChanged(value));
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
