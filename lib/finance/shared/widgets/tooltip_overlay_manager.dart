import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../theme/finance_theme.dart';
import '../services/tooltip_service.dart';
import 'guided_tooltip.dart';

// Export TooltipPosition for external use
export 'package:demo_shore_bird/finance/shared/widgets/guided_tooltip.dart'
    show TooltipPosition;

/// Manages tooltip overlay sequence
/// This demonstrates Shorebird's ability to patch tutorial content
class TooltipOverlayManager {
  static OverlayEntry? _currentOverlay;
  static BuildContext? _context;
  static int _currentIndex = -1;
  static List<TooltipConfig>? _tooltips;
  static FinanceThemeData? _theme;
  static AppLocalizationStrings? _strings;

  /// Initialize and show tooltips
  static Future<void> showTooltips({
    required BuildContext context,
    required List<TooltipConfig> tooltips,
    required FinanceThemeData theme,
    required AppLocalizationStrings strings,
  }) async {
    await TooltipService.initialize();

    _context = context;
    _tooltips = tooltips;
    _theme = theme;
    _strings = strings;

    // Find first unseen tooltip
    for (int i = 0; i < tooltips.length; i++) {
      final bool hasSeen = await TooltipService.hasSeenTooltip(tooltips[i].id);
      if (!hasSeen) {
        _currentIndex = i;
        _showCurrentTooltip();
        return;
      }
    }
  }

  static void _showCurrentTooltip() {
    if (_context == null ||
        _tooltips == null ||
        _theme == null ||
        _strings == null ||
        _currentIndex < 0 ||
        _currentIndex >= _tooltips!.length) {
      return;
    }

    final TooltipConfig tooltip = _tooltips![_currentIndex];
    final String? message = _getTooltipMessage(tooltip.id);

    if (message == null || tooltip.targetKey.currentContext == null) {
      _moveToNext();
      return;
    }

    _currentOverlay?.remove();

    _currentOverlay = OverlayEntry(
      builder: (BuildContext context) => _TooltipOverlayWrapper(
        message: message,
        targetKey: tooltip.targetKey,
        theme: _theme!,
        position: tooltip.position,
        onDismiss: () async {
          await TooltipService.markTooltipAsSeen(tooltip.id);
          _moveToNext();
        },
      ),
    );

    Overlay.of(_context!).insert(_currentOverlay!);
  }

  static void _moveToNext() {
    if (_tooltips == null || _currentIndex >= _tooltips!.length - 1) {
      _dismiss();
      return;
    }

    _currentIndex++;
    _showCurrentTooltip();
  }

  static void _dismiss() {
    _currentOverlay?.remove();
    _currentOverlay = null;
    _currentIndex = -1;
    _context = null;
    _tooltips = null;
    _theme = null;
    _strings = null;
  }

  static String? _getTooltipMessage(String tooltipId) {
    if (_strings == null) {
      return null;
    }

    switch (tooltipId) {
      case 'welcome':
        return _strings!.tooltipWelcomeMessage;
      case 'revenue':
        return _strings!.tooltipRevenueField;
      case 'expense':
        return _strings!.tooltipExpenseField;
      case 'depreciation':
        return _strings!.tooltipDepreciationField;
      case 'calculate':
        return _strings!.tooltipCalculateButton;
      case 'profit':
        return _strings!.tooltipProfitDisplay;
      default:
        return null;
    }
  }

  /// Dismiss current tooltip and skip to next
  static void skipCurrent() {
    if (_tooltips != null &&
        _currentIndex >= 0 &&
        _currentIndex < _tooltips!.length) {
      TooltipService.markTooltipAsSeen(_tooltips![_currentIndex].id);
    }
    _moveToNext();
  }

  /// Dismiss all tooltips
  static void dismissAll() {
    _dismiss();
  }
}

class TooltipConfig {
  TooltipConfig({
    required this.id,
    required this.targetKey,
    this.position = TooltipPosition.bottom,
  });

  final String id;
  final GlobalKey targetKey;
  final TooltipPosition position;
}

class _TooltipOverlayWrapper extends StatefulWidget {
  const _TooltipOverlayWrapper({
    required this.message,
    required this.targetKey,
    required this.theme,
    required this.position,
    required this.onDismiss,
  });

  final String message;
  final GlobalKey targetKey;
  final FinanceThemeData theme;
  final TooltipPosition position;
  final VoidCallback onDismiss;

  @override
  State<_TooltipOverlayWrapper> createState() => _TooltipOverlayWrapperState();
}

class _TooltipOverlayWrapperState extends State<_TooltipOverlayWrapper>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _glowAnimation = CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _glowController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleDismiss() {
    _controller.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    final RenderBox? renderBox =
        widget.targetKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleDismiss();
      });
      return const SizedBox.shrink();
    }

    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size screenSize = MediaQuery.of(context).size;
    const double padding = 16;
    const double arrowSize = 12;
    final double tooltipWidth = (screenSize.width * 0.85).clamp(200.0, 350.0);

    // Calculate tooltip position
    double tooltipTop;
    double tooltipLeft;
    Offset arrowOffset;

    switch (widget.position) {
      case TooltipPosition.bottom:
        tooltipTop = offset.dy + size.height + padding + arrowSize;
        tooltipLeft = offset.dx + (size.width / 2) - (tooltipWidth / 2);
        tooltipLeft = tooltipLeft.clamp(
          padding,
          screenSize.width - tooltipWidth - padding,
        );
        arrowOffset = Offset(
          offset.dx + (size.width / 2) - tooltipLeft,
          -arrowSize,
        );
        break;
      case TooltipPosition.top:
        tooltipTop = offset.dy - padding - arrowSize - 100;
        tooltipLeft = offset.dx + (size.width / 2) - (tooltipWidth / 2);
        tooltipLeft = tooltipLeft.clamp(
          padding,
          screenSize.width - tooltipWidth - padding,
        );
        arrowOffset = Offset(
          offset.dx + (size.width / 2) - tooltipLeft,
          100 + arrowSize,
        );
        break;
      case TooltipPosition.right:
        tooltipTop = offset.dy + (size.height / 2) - 50;
        tooltipLeft = offset.dx + size.width + padding + arrowSize;
        arrowOffset = const Offset(-arrowSize, 50);
        break;
      case TooltipPosition.left:
        tooltipTop = offset.dy + (size.height / 2) - 50;
        tooltipLeft = offset.dx - tooltipWidth - padding - arrowSize;
        arrowOffset = Offset(tooltipWidth + arrowSize, 50);
        break;
    }

    return Stack(
      children: <Widget>[
        // Backdrop overlay
        Positioned.fill(
          child: GestureDetector(
            onTap: _handleDismiss,
            child: Container(color: Colors.black.withValues(alpha: 0.4)),
          ),
        ),
        // Highlight overlay
        Positioned(
          left: offset.dx - 8,
          top: offset.dy - 8,
          child: Container(
            width: size.width + 16,
            height: size.height + 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.theme.primaryTextColor.withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: widget.theme.primaryTextColor.withValues(alpha: 0.22),
                  blurRadius: 20 + (6 * _glowAnimation.value),
                  spreadRadius: 4 + (2 * _glowAnimation.value),
                ),
              ],
            ),
          ),
        ),
        // Tooltip
        Positioned(
          left: tooltipLeft,
          top: tooltipTop,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: tooltipWidth,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: widget.theme.inputFillColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: widget.theme.primaryTextColor.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.32),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.message,
                          style: TextStyle(
                            color: widget.theme.primaryTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: _handleDismiss,
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: Icon(
                              Icons.check_circle_rounded,
                              color: widget.theme.primaryTextColor,
                              size: 18,
                            ),
                            label: Text(
                              'Next',
                              style: TextStyle(
                                color: widget.theme.primaryTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Arrow
        if (widget.position == TooltipPosition.bottom)
          Positioned(
            left: tooltipLeft + arrowOffset.dx - 6,
            top: tooltipTop - arrowSize,
            child: CustomPaint(
              size: const Size(arrowSize * 2, arrowSize),
              painter: _ArrowPainter(
                color: widget.theme.inputFillColor,
                borderColor: widget.theme.primaryTextColor.withValues(
                  alpha: 0.3,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({required this.color, required this.borderColor});

  final Color color;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas
      ..drawPath(path, paint)
      ..drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) => false;
}
