import 'package:flutter/material.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class ShorebirdUpdateButton extends StatefulWidget {
  const ShorebirdUpdateButton({
    super.key,
    this.backgroundColor,
    this.iconColor,
  });

  final Color? backgroundColor;
  final Color? iconColor;

  @override
  State<ShorebirdUpdateButton> createState() => _ShorebirdUpdateButtonState();
}

class _ShorebirdUpdateButtonState extends State<ShorebirdUpdateButton> {
  final ShorebirdUpdater _updater = ShorebirdUpdater();
  bool _isUpdating = false;

  Future<void> _checkForUpdatesAndApply() async {
    if (_isUpdating) {
      return;
    }

    setState(() {
      _isUpdating = true;
    });

    try {
      final UpdateStatus status = await _updater.checkForUpdate();

      if (!mounted) {
        return;
      }

      if (status == UpdateStatus.outdated) {
        await _updater.update();

        if (!mounted) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Update downloaded. Please restart the app.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You are already on the latest version.'),
          ),
        );
      }
    } on UpdateException catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update: '${error.message}'")),
      );
    } finally {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: widget.backgroundColor ?? Colors.white.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(14),
    ),
    child: IconButton(
      icon: _isUpdating
          ? SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.iconColor ?? Colors.white,
                ),
              ),
            )
          : Icon(Icons.system_update, color: widget.iconColor ?? Colors.white),
      tooltip: 'Check for Shorebird update',
      onPressed: _isUpdating ? null : _checkForUpdatesAndApply,
    ),
  );
}
