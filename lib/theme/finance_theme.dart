import 'package:flutter/material.dart';

enum FinanceSeason { hot, cold, warm, rain }

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
    this.headerSubtitle,
    this.badgeEmoji,
    this.badgeBackgroundColor,
    this.badgeBorderColor,
    required this.versionLabelSimple,
    required this.versionLabelAdvanced,
    required this.calculationSimpleLabel,
    required this.calculationAdvancedLabel,
    required this.icon,
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

  static final Map<FinanceSeason, FinanceThemeData> _themes = {
    FinanceSeason.hot: FinanceThemeData(
      backgroundGradient: const [
        Color(0xFFFF512F),
        Color(0xFFF09819),
        Color(0xFFFFC371),
      ],
      glassGradient: const [
        Color(0x40FFFFFF),
        Color(0x26FFFFFF),
      ],
      glassBorderColor: const Color(0x4DFFFFFF),
      glassShadowColor: const Color(0x1A000000),
      iconBackgroundColor: const Color(0x80FFFFFF),
      iconColor: Colors.white,
      primaryTextColor: Colors.white,
      secondaryTextColor: const Color(0xE6FFFFFF),
      subtleTextColor: const Color(0xB3FFFFFF),
      buttonGradient: const [
        Color(0xFFFF9966),
        Color(0xFFFF5E62),
      ],
      buttonShadowColor: const Color(0x33000000),
      buttonTextColor: Colors.white,
      inputFillColor: const Color(0x33FFFFFF),
      inputBorderColor: const Color(0x4DFFFFFF),
      inputLabelColor: const Color(0xCCFFFFFF),
      profitAccentColor: Colors.white,
      headerTitle: 'Shorebird Finance',
      headerSubtitle: 'Season: Hot',
      badgeEmoji: '☀️',
      badgeBackgroundColor: const Color(0x33FFFFFF),
      badgeBorderColor: const Color(0x4DFFFFFF),
      versionLabelSimple: 'App version: 1.0.0 — Hot bloom',
      versionLabelAdvanced: 'App version: 1.0.1 — Hot bloom (Patched)',
      calculationSimpleLabel: 'Calculation: Profit = Revenue - Expense',
      calculationAdvancedLabel:
          'Calculation: Profit = Revenue - Expense - Depreciation',
      icon: Icons.account_balance_wallet,
    ),
    FinanceSeason.cold: FinanceThemeData(
      backgroundGradient: const [
        Color(0xFF1D2B64),
        Color(0xFF1A2980),
        Color(0xFF26D0CE),
      ],
      glassGradient: const [
        Color(0x40C5CAE9),
        Color(0x26090F24),
      ],
      glassBorderColor: const Color(0x3348CAE4),
      glassShadowColor: const Color(0x1A030712),
      iconBackgroundColor: const Color(0x803C4DAE),
      iconColor: Colors.white,
      primaryTextColor: Colors.white,
      secondaryTextColor: const Color(0xE6E3F2FF),
      subtleTextColor: const Color(0xB3D6E4FF),
      buttonGradient: const [
        Color(0xFF4776E6),
        Color(0xFF8E54E9),
      ],
      buttonShadowColor: const Color(0x1A000000),
      buttonTextColor: Colors.white,
      inputFillColor: const Color(0x332E3358),
      inputBorderColor: const Color(0x334776E6),
      inputLabelColor: const Color(0xCCEDF4FF),
      profitAccentColor: Colors.white,
      headerTitle: 'Shorebird Finance',
      headerSubtitle: 'Season: Cold',
      badgeEmoji: '❄️',
      badgeBackgroundColor: const Color(0x332B3A67),
      badgeBorderColor: const Color(0x334776E6),
      versionLabelSimple: 'App version: 1.0.0 — Cold focus',
      versionLabelAdvanced: 'App version: 1.0.1 — Cold focus (Patched)',
      calculationSimpleLabel: 'Calculation: Profit = Revenue - Expense',
      calculationAdvancedLabel:
          'Calculation: Profit = Revenue - Expense - Depreciation',
      icon: Icons.ac_unit,
    ),
    FinanceSeason.warm: FinanceThemeData(
      backgroundGradient: const [
        Color(0xFFF5AF19),
        Color(0xFFF12711),
        Color(0xFFFA709A),
      ],
      glassGradient: const [
        Color(0x40FFE0B2),
        Color(0x26FFFFFF),
      ],
      glassBorderColor: const Color(0x33FFCC80),
      glassShadowColor: const Color(0x1AFF8A65),
      iconBackgroundColor: const Color(0x80FFB74D),
      iconColor: Colors.white,
      primaryTextColor: Colors.white,
      secondaryTextColor: const Color(0xE6FFF3E0),
      subtleTextColor: const Color(0xB3FFE0B2),
      buttonGradient: const [
        Color(0xFFFFA74B),
        Color(0xFFFF7E5F),
      ],
      buttonShadowColor: const Color(0x33FF7043),
      buttonTextColor: Colors.white,
      inputFillColor: const Color(0x33FFE0B2),
      inputBorderColor: const Color(0x33FFB74D),
      inputLabelColor: const Color(0xCCFFE0B2),
      profitAccentColor: Colors.white,
      headerTitle: 'Shorebird Finance',
      headerSubtitle: 'Season: Warm',
      badgeEmoji: '🌤️',
      badgeBackgroundColor: const Color(0x33FFE0B2),
      badgeBorderColor: const Color(0x33FFCC80),
      versionLabelSimple: 'App version: 1.0.2 — Warm breeze',
      versionLabelAdvanced: 'App version: 1.0.3 — Warm breeze (Patched)',
      calculationSimpleLabel: 'Calculation: Profit = Revenue - Expense',
      calculationAdvancedLabel:
          'Calculation: Profit = Revenue - Expense - Depreciation',
      icon: Icons.wb_sunny,
    ),
    FinanceSeason.rain: FinanceThemeData(
      backgroundGradient: const [
        Color(0xFF141E30),
        Color(0xFF243B55),
        Color(0xFF0F2027),
      ],
      glassGradient: const [
        Color(0x33263D56),
        Color(0x26090F24),
      ],
      glassBorderColor: const Color(0x33427387),
      glassShadowColor: const Color(0x33090F24),
      iconBackgroundColor: const Color(0x80214257),
      iconColor: Colors.white,
      primaryTextColor: Colors.white,
      secondaryTextColor: const Color(0xE6FFFFFF),
      subtleTextColor: const Color(0xB3B0BEC5),
      buttonGradient: const [
        Color(0xFF396afc),
        Color(0xFF2948ff),
      ],
      buttonShadowColor: const Color(0x33141830),
      buttonTextColor: Colors.white,
      inputFillColor: const Color(0x333B4A64),
      inputBorderColor: const Color(0x333968A6),
      inputLabelColor: const Color(0xCCCFD8DC),
      profitAccentColor: Colors.white,
      headerTitle: 'Shorebird Finance',
      headerSubtitle: 'Season: Rain',
      badgeEmoji: '🕊️',
      badgeBackgroundColor: const Color(0x333968A6),
      badgeBorderColor: const Color(0x4C3968A6),
      versionLabelSimple: 'App version: 1.0.0 — Rain flow',
      versionLabelAdvanced: 'App version: 1.0.1 — Patched by Shorebird 🕊️',
      calculationSimpleLabel: 'Calculation: Profit = Revenue - Expense',
      calculationAdvancedLabel:
          'Calculation: Profit = Revenue - Expense - Depreciation',
      icon: Icons.auto_graph,
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

