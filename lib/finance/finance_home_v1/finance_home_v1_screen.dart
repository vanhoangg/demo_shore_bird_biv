import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../../l10n/locale_provider.dart';
import '../../theme/finance_theme.dart';
import '../../widgets/language_switcher.dart';
import '../shared/components/profit_display_card.dart';
import '../shared/components/version_info_card.dart';
import '../shared/services/tooltip_service.dart';
import '../shared/widgets/tooltip_overlay_manager.dart'
    show TooltipOverlayManager, TooltipConfig, TooltipPosition;
import 'bloc/finance_v1_bloc.dart';
import 'bloc/finance_v1_state.dart';
import 'components/input_section_v1.dart';

class FinanceHomeV1Screen extends StatefulWidget {
  const FinanceHomeV1Screen({
    super.key,
    this.season = FinanceSeason.hot,
    this.localeProvider,
  });

  final FinanceSeason season;
  final LocaleProvider? localeProvider;

  @override
  State<FinanceHomeV1Screen> createState() => _FinanceHomeV1ScreenState();
}

class _FinanceHomeV1ScreenState extends State<FinanceHomeV1Screen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late FinanceThemeData _theme;

  // GlobalKeys for tooltips
  final GlobalKey _revenueKey = GlobalKey();
  final GlobalKey _expenseKey = GlobalKey();
  final GlobalKey _calculateKey = GlobalKey();
  final GlobalKey _profitKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _theme = FinanceThemeManager.resolve(widget.season);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant FinanceHomeV1Screen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.season != widget.season) {
      setState(() {
        _theme = FinanceThemeManager.resolve(widget.season);
      });
    }
  }

  Future<void> _showTooltipFlow() async {
    final AppLocalizations? localizations = AppLocalizations.of(context);
    final AppLocalizationStrings? strings = localizations?.strings;
    if (strings == null) {
      return;
    }

    await TooltipOverlayManager.showTooltips(
      context: context,
      theme: _theme,
      strings: strings,
      tooltips: <TooltipConfig>[
        TooltipConfig(id: 'revenue', targetKey: _revenueKey),
        TooltipConfig(id: 'expense', targetKey: _expenseKey),
        TooltipConfig(
          id: 'calculate',
          targetKey: _calculateKey,
          position: TooltipPosition.top,
        ),
        TooltipConfig(
          id: 'profit',
          targetKey: _profitKey,
          position: TooltipPosition.top,
        ),
      ],
    );
  }

  Future<void> _onStartGuidePressed() async {
    await TooltipService.resetAllTooltips();
    await _showTooltipFlow();
  }

  @override
  void dispose() {
    _animationController.dispose();
    TooltipOverlayManager.dismissAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? localizations = AppLocalizations.of(context);
    final AppLocalizationStrings strings =
        localizations?.strings ?? EnglishStrings();
    final Size screenSize = MediaQuery.of(context).size;
    final double glowSize = screenSize.shortestSide * 0.45;
    final double glowOffset = glowSize * 0.25;

    return BlocProvider<FinanceV1Bloc>(
      create: (BuildContext context) => FinanceV1Bloc(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _theme.backgroundGradient,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(-glowOffset, -glowOffset),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: glowSize,
                      height: glowSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: <Color>[
                            Colors.white.withValues(alpha: 0.12),
                            Colors.white.withValues(alpha: 0.02),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.auto_awesome,
                                    color: Colors.white,
                                  ),
                                  tooltip: 'Start guided tour',
                                  onPressed: _onStartGuidePressed,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _theme.headerTitle,
                                      style: TextStyle(
                                        color: _theme.primaryTextColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    if (_theme.headerSubtitle != null)
                                      Text(
                                        _theme.headerSubtitle!,
                                        style: TextStyle(
                                          color: _theme.secondaryTextColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (widget.localeProvider != null)
                                LanguageSwitcher(
                                  localeProvider: widget.localeProvider!,
                                ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          InputSectionV1(
                            theme: _theme,
                            strings: strings,
                            revenueKey: _revenueKey,
                            expenseKey: _expenseKey,
                            calculateKey: _calculateKey,
                          ),
                          const SizedBox(height: 24),
                          BlocBuilder<FinanceV1Bloc, FinanceV1State>(
                            builder:
                                (BuildContext context, FinanceV1State state) =>
                                    ProfitDisplayCard(
                                      cardKey: _profitKey,
                                      theme: _theme,
                                      strings: strings,
                                      profit: state.profit,
                                    ),
                          ),
                          const SizedBox(height: 24),
                          VersionInfoCard(
                            theme: _theme,
                            title: strings.calculationSimple,
                            subtitle: strings.versionSimple,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
