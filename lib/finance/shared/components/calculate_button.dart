import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../theme/finance_theme.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({
    required this.theme,
    required this.strings,
    required this.onPressed,
    super.key,
    this.buttonKey,
  });

  final FinanceThemeData theme;
  final AppLocalizationStrings strings;
  final VoidCallback onPressed;
  final Key? buttonKey;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: theme.buttonGradient),
      borderRadius: BorderRadius.circular(16),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: theme.buttonShadowColor,
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        key: buttonKey,
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Center(
            child: Text(
              strings.calculateCta,
              style: TextStyle(
                color: theme.buttonTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
