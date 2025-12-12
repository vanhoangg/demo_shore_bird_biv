import 'package:flutter/material.dart';

enum FinanceSeason { hot, cold, warm, rain, xmas }

class FinanceThemeData {
  const FinanceThemeData({
    required this.backgroundGradient,
    required this.glassGradient,
    required this.glassBorderColor,
    required this.glassShadowColor,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.subtleTextColor,
    required this.buttonGradient,
    required this.buttonShadowColor,
    required this.buttonTextColor,
    required this.inputFillColor,
    required this.inputBorderColor,
    required this.inputLabelColor,
    required this.profitAccentColor,
    required this.headerTitle,
    required this.versionLabelSimple,
    required this.versionLabelAdvanced,
    required this.calculationSimpleLabel,
    required this.calculationAdvancedLabel,
    required this.icon,
    this.headerSubtitle,
    this.badgeEmoji,
    this.badgeBackgroundColor,
    this.badgeBorderColor,
  });

  final List<Color> backgroundGradient;
  final List<Color> glassGradient;
  final Color glassBorderColor;
  final Color glassShadowColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color subtleTextColor;
  final List<Color> buttonGradient;
  final Color buttonShadowColor;
  final Color buttonTextColor;
  final Color inputFillColor;
  final Color inputBorderColor;
  final Color inputLabelColor;
  final Color profitAccentColor;
  final String headerTitle;
  final String? headerSubtitle;
  final String? badgeEmoji;
  final Color? badgeBackgroundColor;
  final Color? badgeBorderColor;
  final String versionLabelSimple;
  final String versionLabelAdvanced;
  final String calculationSimpleLabel;
  final String calculationAdvancedLabel;
  final IconData icon;
}

class FinanceThemeManager {
  static FinanceThemeData resolve(FinanceSeason season) =>
      _themes[season] ?? _themes[FinanceSeason.hot]!;

  static final Map<FinanceSeason, FinanceThemeData> _themes =
      <FinanceSeason, FinanceThemeData>{
        FinanceSeason.hot: const FinanceThemeData(
          backgroundGradient: <Color>[
            Color(0xFF8A1C1C),
            Color(0xFFC12C25),
            Color(0xFFFF6B3D),
          ],
          glassGradient: <Color>[Color(0x26FFFFFF), Color(0x14000000)],
          glassBorderColor: Color(0x33FFFFFF),
          glassShadowColor: Color(0x26000000),
          iconBackgroundColor: Color(0x4DFFFFFF),
          iconColor: Colors.white,
          primaryTextColor: Colors.white,
          secondaryTextColor: Color(0xE6FFECE4),
          subtleTextColor: Color(0xB3FFD6C7),
          buttonGradient: <Color>[Color(0xFFE1442D), Color(0xFFFF7A3D)],
          buttonShadowColor: Color(0x40000000),
          buttonTextColor: Colors.white,
          inputFillColor: Color(0x21FFFFFF),
          inputBorderColor: Color(0x33FFFFFF),
          inputLabelColor: Color(0xCCFFE4D5),
          profitAccentColor: Color(0xFFFFD166),
          headerTitle: 'Shorebird Finance',
          headerSubtitle: 'Season: Hot',
          badgeEmoji: '☀️',
          badgeBackgroundColor: Color(0x26FFFFFF),
          badgeBorderColor: Color(0x33FFFFFF),
          versionLabelSimple: 'App version: 1.0.0 — Hot bloom',
          versionLabelAdvanced: 'App version: 1.0.1 — Hot bloom (Patched)',
          calculationSimpleLabel: 'Calculation: Profit = Revenue - Expense',
          calculationAdvancedLabel:
              'Calculation: Profit = Revenue - Expense - Depreciation',
          icon: Icons.account_balance_wallet,
        ),
        FinanceSeason.cold: const FinanceThemeData(
          backgroundGradient: <Color>[
            Color(0xFF1D2B64),
            Color(0xFF1A2980),
            Color(0xFF26D0CE),
          ],
          glassGradient: <Color>[Color(0x40C5CAE9), Color(0x26090F24)],
          glassBorderColor: Color(0x3348CAE4),
          glassShadowColor: Color(0x1A030712),
          iconBackgroundColor: Color(0x803C4DAE),
          iconColor: Colors.white,
          primaryTextColor: Colors.white,
          secondaryTextColor: Color(0xE6E3F2FF),
          subtleTextColor: Color(0xB3D6E4FF),
          buttonGradient: <Color>[Color(0xFF4776E6), Color(0xFF8E54E9)],
          buttonShadowColor: Color(0x1A000000),
          buttonTextColor: Colors.white,
          inputFillColor: Color(0x332E3358),
          inputBorderColor: Color(0x334776E6),
          inputLabelColor: Color(0xCCEDF4FF),
          profitAccentColor: Colors.white,
          headerTitle: 'Shorebird Finance',
          headerSubtitle: 'Season: Cold',
          badgeEmoji: '❄️',
          badgeBackgroundColor: Color(0x332B3A67),
          badgeBorderColor: Color(0x334776E6),
          versionLabelSimple: 'App version: 1.0.0 — Cold focus',
          versionLabelAdvanced: 'App version: 1.0.1 — Cold focus (Patched)',
          calculationSimpleLabel: 'Calculation: Profit = Revenue - Expense',
          calculationAdvancedLabel:
              'Calculation: Profit = Revenue - Expense - Depreciation',
          icon: Icons.ac_unit,
        ),
        FinanceSeason.warm: const FinanceThemeData(
          backgroundGradient: <Color>[
            Color(0xFFF5AF19),
            Color(0xFFF12711),
            Color(0xFFFA709A),
          ],
          glassGradient: <Color>[Color(0x40FFE0B2), Color(0x26FFFFFF)],
          glassBorderColor: Color(0x33FFCC80),
          glassShadowColor: Color(0x1AFF8A65),
          iconBackgroundColor: Color(0x80FFB74D),
          iconColor: Colors.white,
          primaryTextColor: Colors.white,
          secondaryTextColor: Color(0xE6FFF3E0),
          subtleTextColor: Color(0xB3FFE0B2),
          buttonGradient: <Color>[Color(0xFFFFA74B), Color(0xFFFF7E5F)],
          buttonShadowColor: Color(0x33FF7043),
          buttonTextColor: Colors.white,
          inputFillColor: Color(0x33FFE0B2),
          inputBorderColor: Color(0x33FFB74D),
          inputLabelColor: Color(0xCCFFE0B2),
          profitAccentColor: Colors.white,
          headerTitle: 'Shorebird Finance',
          headerSubtitle: 'Season: Warm',
          badgeEmoji: '🌤️',
          badgeBackgroundColor: Color(0x33FFE0B2),
          badgeBorderColor: Color(0x33FFCC80),
          versionLabelSimple: 'App version: 1.0.2 — Warm breeze',
          versionLabelAdvanced: 'App version: 1.0.3 — Warm breeze (Patched)',
          calculationSimpleLabel: 'Calculation: Profit = Revenue - Expense',
          calculationAdvancedLabel:
              'Calculation: Profit = Revenue - Expense - Depreciation',
          icon: Icons.wb_sunny,
        ),
        FinanceSeason.rain: const FinanceThemeData(
          backgroundGradient: <Color>[
            Color(0xFF141E30),
            Color(0xFF243B55),
            Color(0xFF0F2027),
          ],
          glassGradient: <Color>[Color(0x33263D56), Color(0x26090F24)],
          glassBorderColor: Color(0x33427387),
          glassShadowColor: Color(0x33090F24),
          iconBackgroundColor: Color(0x80214257),
          iconColor: Colors.white,
          primaryTextColor: Colors.white,
          secondaryTextColor: Color(0xE6FFFFFF),
          subtleTextColor: Color(0xB3B0BEC5),
          buttonGradient: <Color>[Color(0xFF396afc), Color(0xFF2948ff)],
          buttonShadowColor: Color(0x33141830),
          buttonTextColor: Colors.white,
          inputFillColor: Color(0x333B4A64),
          inputBorderColor: Color(0x333968A6),
          inputLabelColor: Color(0xCCCFD8DC),
          profitAccentColor: Colors.white,
          headerTitle: 'Shorebird Finance',
          headerSubtitle: 'Season: Rain',
          badgeEmoji: '🕊️',
          badgeBackgroundColor: Color(0x333968A6),
          badgeBorderColor: Color(0x4C3968A6),
          versionLabelSimple: 'App version: 1.0.0 — Rain flow',
          versionLabelAdvanced: 'App version: 1.0.1 — Patched by Shorebird 🕊️',
          calculationSimpleLabel: 'Calculation: Profit = Revenue - Expense',
          calculationAdvancedLabel:
              'Calculation: Profit = Revenue - Expense - Depreciation',
          icon: Icons.auto_graph,
        ),
        FinanceSeason.xmas: const FinanceThemeData(
          backgroundGradient: <Color>[
            Color(0xFF0B3D2E),
            Color(0xFF0F5132),
            Color(0xFF8B1E3F),
            Color(0xFFB9314F),
          ],
          glassGradient: <Color>[Color(0x40FFFFFF), Color(0x14FFFFFF)],
          glassBorderColor: Color(0x26FFFFFF),
          glassShadowColor: Color(0x26000000),
          iconBackgroundColor: Color(0x33FFFFFF),
          iconColor: Colors.white,
          primaryTextColor: Colors.white,
          secondaryTextColor: Color(0xE6FFFFFF),
          subtleTextColor: Color(0xB3FFFFFF),
          buttonGradient: <Color>[Color(0xFF0F5132), Color(0xFFB9314F)],
          buttonShadowColor: Color(0x33000000),
          buttonTextColor: Colors.white,
          inputFillColor: Color(0x33FFFFFF),
          inputBorderColor: Color(0x33FFFFFF),
          inputLabelColor: Color(0xCCFFFFFF),
          profitAccentColor: Colors.amberAccent,
          headerTitle: 'Shorebird Finance',
          headerSubtitle: 'Season: Xmas',
          badgeEmoji: '🎄',
          badgeBackgroundColor: Color(0x1AFFFFFF),
          badgeBorderColor: Color(0x26FFFFFF),
          versionLabelSimple: 'App version: 1.0.0 — Xmas glow',
          versionLabelAdvanced: 'App version: 1.0.1 — Xmas glow (Patched)',
          calculationSimpleLabel: 'Calculation: Profit = Revenue - Expense',
          calculationAdvancedLabel:
              'Calculation: Profit = Revenue - Expense - Depreciation',
          icon: Icons.celebration,
        ),
      };
}

class FinanceStrings {
  static const String revenueLabel = 'Revenue';
  static const String expenseLabel = 'Expense';
  static const String depreciationLabel = 'Depreciation';
  static const String calculateCta = 'Calculate Profit';
  static const String profitLabel = 'Profit';
}
