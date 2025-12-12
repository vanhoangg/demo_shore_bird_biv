import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../l10n/locale_provider.dart';

/// Language switcher widget
class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({required this.localeProvider, super.key});
  final LocaleProvider localeProvider;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return const SizedBox.shrink();
    }

    final Locale currentLocale = localeProvider.locale;
    final AppLocalizationStrings strings = localizations.strings;

    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language, color: Colors.white),
      tooltip: strings.selectLanguage,
      onSelected: localeProvider.setLocale,
      itemBuilder: (BuildContext context) =>
          AppSupportedLocales.locales.map((Locale locale) {
            final bool isSelected =
                locale.languageCode == currentLocale.languageCode;
            return PopupMenuItem<Locale>(
              value: locale,
              child: Row(
                children: <Widget>[
                  if (isSelected)
                    const Icon(Icons.check, size: 20, color: Colors.blue)
                  else
                    const SizedBox(width: 20),
                  const SizedBox(width: 8),
                  Text(_getLanguageName(locale)),
                ],
              ),
            );
          }).toList(),
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'vi':
        return 'Tiếng Việt';
      default:
        return locale.languageCode.toUpperCase();
    }
  }
}
