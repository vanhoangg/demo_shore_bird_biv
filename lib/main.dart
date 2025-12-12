import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'finance/finance_home_v1/finance_home_v1_screen.dart';
import 'finance/finance_home_v2/finance_home_v2_screen.dart';
import 'finance/shared/services/feature_toggle_manager.dart';
import 'l10n/app_localizations.dart';
import 'l10n/locale_provider.dart';

void main() {
  runApp(const ShorebirdFinanceApp());
}

class ShorebirdFinanceApp extends StatefulWidget {
  const ShorebirdFinanceApp({super.key});

  @override
  State<ShorebirdFinanceApp> createState() => _ShorebirdFinanceAppState();
}

class _ShorebirdFinanceAppState extends State<ShorebirdFinanceApp> {
  final LocaleProvider _localeProvider = LocaleProvider();
  bool? _useFinanceV2;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeFeatureToggle();
  }

  Future<void> _initializeFeatureToggle() async {
    await FeatureToggleManager.initialize();
    final bool useV2 = await FeatureToggleManager.shouldUseFinanceV2();
    if (mounted) {
      setState(() {
        _useFinanceV2 = useV2;
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _localeProvider,
    builder: (BuildContext context, _) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      locale: _localeProvider.locale,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppSupportedLocales.locales,
      home: _isInitialized
          ? ((_useFinanceV2 ?? false)
                ? FinanceHomeV2Screen(localeProvider: _localeProvider)
                : FinanceHomeV1Screen(localeProvider: _localeProvider))
          : const Scaffold(body: Center(child: CircularProgressIndicator())),
    ),
  );
}
