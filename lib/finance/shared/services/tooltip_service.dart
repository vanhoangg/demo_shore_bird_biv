import 'package:shared_preferences/shared_preferences.dart';

/// Service to manage tooltip state and version tracking
/// This demonstrates Shorebird's ability to patch tooltip behavior
class TooltipService {
  static const String _keyPrefix = 'tooltip_seen_';
  static const String _versionKey = 'tooltip_version';

  // Current tooltip version - can be changed via Shorebird patch
  // When this changes, all tooltips will be shown again
  static const String currentTooltipVersion = '1.0.0';

  static SharedPreferences? _prefs;

  /// Initialize the service
  static Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();

    // Check if we need to reset tooltips due to version change
    final String? storedVersion = _prefs!.getString(_versionKey);
    if (storedVersion != currentTooltipVersion) {
      // Version changed - reset all tooltip states
      await _resetAllTooltips();
      await _prefs!.setString(_versionKey, currentTooltipVersion);
    }
  }

  /// Clear all stored tooltip states (used when user explicitly restarts guide)
  static Future<void> resetAllTooltips() async {
    await initialize();
    await _resetAllTooltips();
  }

  /// Check if a specific tooltip has been seen
  static Future<bool> hasSeenTooltip(String tooltipId) async {
    await initialize();
    return _prefs!.getBool('$_keyPrefix$tooltipId') ?? false;
  }

  /// Mark a tooltip as seen
  static Future<void> markTooltipAsSeen(String tooltipId) async {
    await initialize();
    await _prefs!.setBool('$_keyPrefix$tooltipId', true);
  }

  /// Reset all tooltips (useful for testing or version updates)
  static Future<void> _resetAllTooltips() async {
    final List<String> keys = _prefs!
        .getKeys()
        .where((String key) => key.startsWith(_keyPrefix))
        .toList();

    for (final String key in keys) {
      await _prefs!.remove(key);
    }
  }

  /// Reset a specific tooltip (for testing)
  static Future<void> resetTooltip(String tooltipId) async {
    await initialize();
    await _prefs!.remove('$_keyPrefix$tooltipId');
  }

  /// Get the current tooltip version
  static String getTooltipVersion() => currentTooltipVersion;
}
