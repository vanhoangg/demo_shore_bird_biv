import 'package:flutter/material.dart';
import 'app_localizations.dart';

/// Provider for managing app locale
class LocaleProvider extends ChangeNotifier {
  Locale _locale = AppSupportedLocales.defaultLocale;

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }

  void setLocaleFromLanguageCode(String languageCode) {
    final Locale locale = AppSupportedLocales.locales.firstWhere(
      (Locale l) => l.languageCode == languageCode,
      orElse: () => AppSupportedLocales.defaultLocale,
    );
    setLocale(locale);
  }
}
