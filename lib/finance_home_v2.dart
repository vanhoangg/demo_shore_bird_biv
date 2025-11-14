import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme/finance_theme.dart';

class FinanceHomeV2 extends StatefulWidget {
  const FinanceHomeV2({super.key, this.season = FinanceSeason.rain});

  final FinanceSeason season;

  @override
  State<FinanceHomeV2> createState() => _FinanceHomeV2State();
}

class _FinanceHomeV2State extends State<FinanceHomeV2>
    with SingleTickerProviderStateMixin {
  final TextEditingController _revenueController = TextEditingController();
  final TextEditingController _expenseController = TextEditingController();
  final TextEditingController _depreciationController = TextEditingController();
  double _profit = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late FinanceThemeData _theme;

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
  void didUpdateWidget(covariant FinanceHomeV2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.season != widget.season) {
      setState(() {
        _theme = FinanceThemeManager.resolve(widget.season);
      });
    }
  }

  @override
  void dispose() {
    _revenueController.dispose();
    _expenseController.dispose();
    _depreciationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  double _toDouble(String value) {
    return double.tryParse(value.trim()) ?? 0;
  }

  void _calculateProfit() {
    final double revenue = _toDouble(_revenueController.text);
    final double expense = _toDouble(_expenseController.text);
    final double depreciation = _toDouble(_depreciationController.text);
    setState(() {
      _profit = revenue - expense - depreciation;
    });
  }

  Widget _buildGlassCard({required Widget child, EdgeInsets? padding}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _theme.glassGradient,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _theme.glassBorderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: _theme.glassShadowColor,
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _theme.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  _buildGlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: _theme.buttonGradient,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                _theme.icon,
                                color: _theme.iconColor,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _theme.headerTitle,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: _theme.primaryTextColor,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  if (_theme.headerSubtitle != null)
                                    Text(
                                      _theme.headerSubtitle!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _theme.secondaryTextColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (_theme.badgeEmoji != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      _theme.badgeBackgroundColor ??
                                      _theme.iconBackgroundColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: _theme.badgeBorderColor != null
                                      ? Border.all(
                                          color: _theme.badgeBorderColor!,
                                          width: 1,
                                        )
                                      : null,
                                ),
                                child: Text(
                                  _theme.badgeEmoji!,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildGlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _revenueController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: TextStyle(
                            color: _theme.primaryTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            labelText: FinanceStrings.revenueLabel,
                            labelStyle: TextStyle(
                              color: _theme.inputLabelColor,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: _theme.inputFillColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: _theme.inputBorderColor,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: _theme.primaryTextColor,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _expenseController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: TextStyle(
                            color: _theme.primaryTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            labelText: FinanceStrings.expenseLabel,
                            labelStyle: TextStyle(
                              color: _theme.inputLabelColor,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: _theme.inputFillColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: _theme.inputBorderColor,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: _theme.primaryTextColor,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _depreciationController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: TextStyle(
                            color: _theme.primaryTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            labelText: FinanceStrings.depreciationLabel,
                            labelStyle: TextStyle(
                              color: _theme.inputLabelColor,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: _theme.inputFillColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: _theme.inputBorderColor,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: _theme.primaryTextColor,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: _theme.buttonGradient,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: _theme.buttonShadowColor,
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _calculateProfit,
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                child: Center(
                                  child: Text(
                                    FinanceStrings.calculateCta,
                                    style: TextStyle(
                                      color: _theme.buttonTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildGlassCard(
                    child: Column(
                      children: [
                        Text(
                          FinanceStrings.profitLabel,
                          style: TextStyle(
                            color: _theme.secondaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${_profit.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: _theme.profitAccentColor,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildGlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          _theme.calculationAdvancedLabel,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _theme.primaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _theme.versionLabelAdvanced,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _theme.subtleTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
