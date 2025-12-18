import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages feature toggles for the app
/// This demonstrates Shorebird's ability to patch feature flags
class FeatureToggleManager {
  static const String _useFinanceV2Key = 'feature_use_finance_v2';
  static const String _configAssetPath = 'assets/config/feature_config.json';

  // Default value - loaded from JSON config file
  // When enabled, uses FinanceHomeV2Screen
  // When disabled, uses FinanceHomeV1Screen
  static bool _defaultUseFinanceV2 = false;
  static bool _configLoaded = false;

  static SharedPreferences? _prefs;

  /// Initialize the service and load config from JSON
  static Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _loadConfigFromJson();
  }

  /// Load feature config from JSON file
  static Future<void> _loadConfigFromJson() async {
    if (_configLoaded) {
      return;
    }

    try {
      final String jsonString = await rootBundle.loadString(_configAssetPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      if (jsonData.containsKey('features')) {
        final Map<String, dynamic> features =
            jsonData['features'] as Map<String, dynamic>;
        if (features.containsKey('use_finance_v2')) {
          _defaultUseFinanceV2 = features['use_finance_v2'] as bool;
        }
      }
      _configLoaded = true;
    } on Exception {
      // If config file doesn't exist or is invalid, use default value
      _defaultUseFinanceV2 = false;
      _configLoaded = true;
    }
  }

  static Future<bool> shouldUseFinanceV2() async => false;

  /// Enable Finance V2
  static Future<void> enableFinanceV2() async {
    await initialize();
    await _prefs!.setBool(_useFinanceV2Key, true);
  }

  /// Disable Finance V2 (use Finance V1)
  static Future<void> disableFinanceV2() async {
    await initialize();
    await _prefs!.setBool(_useFinanceV2Key, false);
  }

  /// Toggle between V1 and V2
  static Future<void> toggleFinanceVersion() async {
    await initialize();
    final bool currentValue = await shouldUseFinanceV2();
    await _prefs!.setBool(_useFinanceV2Key, !currentValue);
  }

  /// Reset to default value from JSON config
  static Future<void> resetToDefault() async {
    await initialize();
    await _prefs!.setBool(_useFinanceV2Key, _defaultUseFinanceV2);
  }

  /// Reload config from JSON file (useful for testing or after patches)
  static Future<void> reloadConfig() async {
    _configLoaded = false;
    await _loadConfigFromJson();
  }

  /// Get the current default value from config
  static bool getDefaultUseFinanceV2() => _defaultUseFinanceV2;
}
