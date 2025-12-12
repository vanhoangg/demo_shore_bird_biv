import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../theme/finance_theme.dart';
import 'glass_card.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    required this.theme, required this.strings, super.key,
    this.useGradientForIcon = false,
  });

  final FinanceThemeData theme;
  final AppLocalizationStrings strings;
  final bool useGradientForIcon;

  @override
  Widget build(BuildContext context) => GlassCard(
      theme: theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: useGradientForIcon
                      ? LinearGradient(colors: theme.buttonGradient)
                      : null,
                  color: useGradientForIcon ? null : theme.iconBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(theme.icon, color: theme.iconColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      strings.appTitle,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryTextColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                    if (theme.headerSubtitle != null)
                      Text(
                        theme.headerSubtitle!,
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.secondaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
              if (theme.badgeEmoji != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        theme.badgeBackgroundColor ?? theme.iconBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    border: theme.badgeBorderColor != null
                        ? Border.all(color: theme.badgeBorderColor!)
                        : null,
                  ),
                  child: Text(
                    theme.badgeEmoji!,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
}
