import 'package:flutter/material.dart';
import '../../../theme/finance_theme.dart';

/// A guided tooltip widget that highlights UI elements
/// This demonstrates Shorebird's ability to patch tutorial content
class GuidedTooltip extends StatefulWidget {
  const GuidedTooltip({
    required this.message,
    required this.targetKey,
    required this.theme,
    required this.onDismiss,
    super.key,
    this.position = TooltipPosition.bottom,
    this.showArrow = true,
  });

  final String message;
  final GlobalKey targetKey;
  final FinanceThemeData theme;
  final VoidCallback onDismiss;
  final TooltipPosition position;
  final bool showArrow;

  @override
  State<GuidedTooltip> createState() => _GuidedTooltipState();
}

enum TooltipPosition { top, bottom, left, right }

class _GuidedTooltipState extends State<GuidedTooltip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  OverlayEntry? _overlayEntry;

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTooltip();
    });
  }

  void _showTooltip() {
    final RenderBox? renderBox =
        widget.targetKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) {
      widget.onDismiss();
      return;
    }

    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _TooltipOverlay(
        message: widget.message,
        targetSize: size,
        targetOffset: offset,
        theme: widget.theme,
        position: widget.position,
        showArrow: widget.showArrow,
        fadeAnimation: _fadeAnimation,
        scaleAnimation: _scaleAnimation,
        onDismiss: () {
          _controller.reverse().then((_) {
            _overlayEntry?.remove();
            widget.onDismiss();
          });
        },
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class _TooltipOverlay extends StatelessWidget {
  const _TooltipOverlay({
    required this.message,
    required this.targetSize,
    required this.targetOffset,
    required this.theme,
    required this.position,
    required this.showArrow,
    required this.fadeAnimation,
    required this.scaleAnimation,
    required this.onDismiss,
  });

  final String message;
  final Size targetSize;
  final Offset targetOffset;
  final FinanceThemeData theme;
  final TooltipPosition position;
  final bool showArrow;
  final Animation<double> fadeAnimation;
  final Animation<double> scaleAnimation;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    const double padding = 16;
    const double arrowSize = 12;
    final double tooltipWidth = (screenSize.width * 0.85).clamp(200.0, 350.0);

    // Calculate tooltip position
    double tooltipTop;
    double tooltipLeft;
    Offset arrowOffset;

    switch (position) {
      case TooltipPosition.bottom:
        tooltipTop = targetOffset.dy + targetSize.height + padding + arrowSize;
        tooltipLeft =
            targetOffset.dx + (targetSize.width / 2) - (tooltipWidth / 2);
        tooltipLeft = tooltipLeft.clamp(
          padding,
          screenSize.width - tooltipWidth - padding,
        );
        arrowOffset = Offset(
          targetOffset.dx + (targetSize.width / 2) - tooltipLeft,
          -arrowSize,
        );
        break;
      case TooltipPosition.top:
        tooltipTop = targetOffset.dy - padding - arrowSize - 100;
        tooltipLeft =
            targetOffset.dx + (targetSize.width / 2) - (tooltipWidth / 2);
        tooltipLeft = tooltipLeft.clamp(
          padding,
          screenSize.width - tooltipWidth - padding,
        );
        arrowOffset = Offset(
          targetOffset.dx + (targetSize.width / 2) - tooltipLeft,
          100 + arrowSize,
        );
        break;
      case TooltipPosition.right:
        tooltipTop = targetOffset.dy + (targetSize.height / 2) - 50;
        tooltipLeft = targetOffset.dx + targetSize.width + padding + arrowSize;
        arrowOffset = const Offset(-arrowSize, 50);
        break;
      case TooltipPosition.left:
        tooltipTop = targetOffset.dy + (targetSize.height / 2) - 50;
        tooltipLeft = targetOffset.dx - tooltipWidth - padding - arrowSize;
        arrowOffset = Offset(tooltipWidth + arrowSize, 50);
        break;
    }

    return Stack(
      children: <Widget>[
        // Backdrop overlay
        Positioned.fill(
          child: GestureDetector(
            onTap: onDismiss,
            child: Container(color: Colors.black.withValues(alpha: 0.4)),
          ),
        ),
        // Highlight overlay
        Positioned(
          left: targetOffset.dx - 8,
          top: targetOffset.dy - 8,
          child: Container(
            width: targetSize.width + 16,
            height: targetSize.height + 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.primaryTextColor.withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: theme.primaryTextColor.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 4,
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
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: tooltipWidth,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.inputFillColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.primaryTextColor.withValues(alpha: 0.3),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              message,
                              style: TextStyle(
                                color: theme.primaryTextColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: theme.primaryTextColor.withValues(
                                alpha: 0.7,
                              ),
                              size: 20,
                            ),
                            onPressed: onDismiss,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: onDismiss,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Got it',
                            style: TextStyle(
                              color: theme.primaryTextColor,
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
        // Arrow
        if (showArrow && position == TooltipPosition.bottom)
          Positioned(
            left: tooltipLeft + arrowOffset.dx - 6,
            top: tooltipTop - arrowSize,
            child: CustomPaint(
              size: const Size(arrowSize * 2, arrowSize),
              painter: _ArrowPainter(
                color: theme.inputFillColor,
                borderColor: theme.primaryTextColor.withValues(alpha: 0.3),
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
