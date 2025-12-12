import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../theme/finance_theme.dart';
import '../services/tooltip_service.dart';

/// Manages the sequence of tooltips shown to users
/// This demonstrates Shorebird's ability to patch tutorial flows
class TooltipManager extends StatefulWidget {
  const TooltipManager({
    required this.child,
    required this.theme,
    required this.strings,
    super.key,
    this.tooltipIds = const <String>[],
  });

  final Widget child;
  final FinanceThemeData theme;
  final AppLocalizationStrings strings;
  final List<String> tooltipIds;

  @override
  State<TooltipManager> createState() => _TooltipManagerState();
}

class _TooltipManagerState extends State<TooltipManager> {
  int _currentTooltipIndex = -1;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeTooltips();
  }

  Future<void> _initializeTooltips() async {
    await TooltipService.initialize();

    // Find the first unseen tooltip
    for (int i = 0; i < widget.tooltipIds.length; i++) {
      final bool hasSeen = await TooltipService.hasSeenTooltip(
        widget.tooltipIds[i],
      );
      if (!hasSeen) {
        if (mounted) {
          setState(() {
            _currentTooltipIndex = i;
            _isInitialized = true;
          });
        }
        return;
      }
    }

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  void _showNextTooltip() {
    if (_currentTooltipIndex < widget.tooltipIds.length - 1) {
      setState(() {
        _currentTooltipIndex++;
      });
    } else {
      setState(() {
        _currentTooltipIndex = -1;
      });
    }
  }

  Future<void> _handleTooltipDismiss(String tooltipId) async {
    await TooltipService.markTooltipAsSeen(tooltipId);
    _showNextTooltip();
  }

  String? _getTooltipMessage(String tooltipId) {
    switch (tooltipId) {
      case 'welcome':
        return widget.strings.tooltipWelcomeMessage;
      case 'revenue':
        return widget.strings.tooltipRevenueField;
      case 'expense':
        return widget.strings.tooltipExpenseField;
      case 'depreciation':
        return widget.strings.tooltipDepreciationField;
      case 'calculate':
        return widget.strings.tooltipCalculateButton;
      case 'profit':
        return widget.strings.tooltipProfitDisplay;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _currentTooltipIndex == -1) {
      return widget.child;
    }

    final String currentTooltipId = widget.tooltipIds[_currentTooltipIndex];
    final String? message = _getTooltipMessage(currentTooltipId);

    if (message == null) {
      return widget.child;
    }

    return Stack(
      children: <Widget>[
        widget.child,
        if (_currentTooltipIndex >= 0)
          _TooltipWrapper(
            tooltipId: currentTooltipId,
            message: message,
            theme: widget.theme,
            onDismiss: () => _handleTooltipDismiss(currentTooltipId),
          ),
      ],
    );
  }
}

class _TooltipWrapper extends StatelessWidget {
  const _TooltipWrapper({
    required this.tooltipId,
    required this.message,
    required this.theme,
    required this.onDismiss,
  });

  final String tooltipId;
  final String message;
  final FinanceThemeData theme;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
