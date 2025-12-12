import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../theme/finance_theme.dart';
import 'glass_card.dart';

class ProfitDisplayCard extends StatelessWidget {
  const ProfitDisplayCard({
    required this.theme, required this.strings, required this.profit, super.key,
    this.cardKey,
  });

  final FinanceThemeData theme;
  final AppLocalizationStrings strings;
  final double profit;
  final Key? cardKey;

  @override
  Widget build(BuildContext context) => GlassCard(
      key: cardKey,
      theme: theme,
      child: Column(
        children: <Widget>[
          Text(
            strings.profitLabel,
            style: TextStyle(
              color: theme.secondaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${profit.toStringAsFixed(2)}',
            style: TextStyle(
              color: theme.profitAccentColor,
              fontSize: 42,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
        ],
      ),
    );
}
