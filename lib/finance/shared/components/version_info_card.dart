import 'package:flutter/material.dart';
import '../../../theme/finance_theme.dart';
import 'glass_card.dart';

class VersionInfoCard extends StatelessWidget {
  const VersionInfoCard({
    required this.theme, required this.title, required this.subtitle, super.key,
  });

  final FinanceThemeData theme;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => GlassCard(
      theme: theme,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.primaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: theme.subtleTextColor, fontSize: 12),
          ),
        ],
      ),
    );
}
