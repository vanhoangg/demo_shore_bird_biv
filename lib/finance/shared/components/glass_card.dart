import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../theme/finance_theme.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    required this.child,
    required this.theme,
    super.key,
    this.padding,
  });

  final Widget child;
  final FinanceThemeData theme;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(24),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: theme.glassGradient,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: theme.glassBorderColor, width: 1.5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: theme.glassShadowColor,
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
