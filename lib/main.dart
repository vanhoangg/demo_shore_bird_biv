import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import 'finance/finance_home_v1/finance_home_v1_screen.dart';
import 'finance/finance_home_v2/finance_home_v2_screen.dart';
import 'finance/shared/services/feature_toggle_manager.dart';
import 'l10n/app_localizations.dart';
import 'l10n/locale_provider.dart';
import 'theme/finance_theme.dart';

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
  final ShorebirdUpdater _updater = ShorebirdUpdater();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  bool? _useFinanceV2;
  bool _isInitialized = false;
  FinanceSeason _season = FinanceSeason.hot;

  @override
  void initState() {
    super.initState();
    _initializeFeatureToggle();
  }

  Future<void> _initializeFeatureToggle() async {
    await FeatureToggleManager.initialize();
    final bool useV2 = await FeatureToggleManager.shouldUseFinanceV2();
    if (!mounted) {
      return;
    }

    setState(() {
      _useFinanceV2 = useV2;
      _isInitialized = true;
      _season = useV2 ? FinanceSeason.rain : FinanceSeason.hot;
    });

    // Once the first frame is rendered, automatically check for updates.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForUpdatesAndMaybeShowDialog();
    });
  }

  Future<void> _checkForUpdatesAndMaybeShowDialog() async {
    try {
      // Use this for real check:
      // final UpdateStatus status = await _updater.checkForUpdate();
      // Temporary: force outdated status for testing
      final UpdateStatus status = await _updater.checkForUpdate();

      if (!mounted) {
        return;
      }

      if (status == UpdateStatus.upToDate) {
        _showSnackbar('You are already on the latest version.');
        return;
      }

      await _showDialogForStatus(status);
    } on UpdateException catch (error) {
      if (!mounted) {
        return;
      }

      _showSnackbar("Failed to check for updates: '${error.message}'");
    }
  }

  void _showSnackbar(String message) {
    final BuildContext? messengerContext = _navigatorKey.currentContext;
    if (messengerContext == null) {
      return;
    }

    ScaffoldMessenger.of(
      messengerContext,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _showDialogForStatus(UpdateStatus status) async {
    final BuildContext? dialogContext = _navigatorKey.currentContext;
    if (dialogContext == null) {
      return;
    }

    final bool isOutdated = status == UpdateStatus.outdated;
    final bool isRestartRequired = status == UpdateStatus.restartRequired;

    final String title = isOutdated ? 'Update available' : 'Update downloaded';
    final String content = isOutdated
        ? 'A new version of the app is available. You need to update to continue.'
        : 'Update downloaded. Please restart the app.';
    final String actionLabel = isOutdated ? 'Update' : 'Restart';

    await showDialog<void>(
      context: dialogContext,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();

              try {
                if (!mounted) {
                  return;
                }
                if (isOutdated) {
                  await _updater.update();
                  _showSnackbar('Update downloaded. Please restart the app.');
                }
                if (isRestartRequired) {
                  _showSnackbar('Update newest. Please restart the app.');
                }
              } on UpdateException catch (_) {
                if (!mounted) {
                  return;
                }
              }
            },
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }

  void _cycleSeason() {
    const List<FinanceSeason> seasons = FinanceSeason.values;
    final int nextIndex = (seasons.indexOf(_season) + 1) % seasons.length;
    setState(() {
      _season = seasons[nextIndex];
    });
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _localeProvider,
    builder: (BuildContext context, _) => MaterialApp(
      navigatorKey: _navigatorKey,
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
          ? Scaffold(
              body: (_useFinanceV2 ?? false)
                  ? FinanceHomeV2Screen(
                      season: _season,
                      localeProvider: _localeProvider,
                      onCycleSeason: _cycleSeason,
                    )
                  : FinanceHomeV1Screen(
                      season: _season,
                      localeProvider: _localeProvider,
                    ),
            )
          : const Scaffold(body: Center(child: CircularProgressIndicator())),
    ),
  );
}
