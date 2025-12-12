import 'package:flutter/material.dart';

import '../../../theme/finance_theme.dart';

class ThemeHeaderSwitcher extends StatelessWidget {
  const ThemeHeaderSwitcher({
    required this.theme,
    required this.title,
    required this.onSwitchTheme,
    super.key,
    this.subtitle,
  });

  final FinanceThemeData theme;
  final String title;
  final String? subtitle;
  final VoidCallback onSwitchTheme;

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: theme.primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: TextStyle(color: theme.secondaryTextColor, fontSize: 13),
              ),
          ],
        ),
      ),
      TextButton.icon(
        onPressed: onSwitchTheme,
        style: TextButton.styleFrom(
          foregroundColor: theme.primaryTextColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: theme.iconBackgroundColor.withValues(alpha: 0.4),
        ),
        icon: const Icon(Icons.color_lens),
        label: const Text('Theme'),
      ),
    ],
  );
}
