import 'package:flutter/material.dart';

/// Supported locales for the app
class AppSupportedLocales {
  static const List<Locale> locales = <Locale>[
    Locale('en', 'US'), // English
    Locale('es', 'ES'), // Spanish
    Locale('fr', 'FR'), // French
    Locale('vi', 'VN'), // Vietnamese
  ];

  static Locale get defaultLocale => const Locale('en', 'US');
}

/// Localization delegate for the app
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppSupportedLocales.locales.any(
    (Locale supportedLocale) =>
        supportedLocale.languageCode == locale.languageCode,
  );

  @override
  Future<AppLocalizations> load(Locale locale) =>
      Future<AppLocalizations>.value(AppLocalizations(locale));

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;
}

/// Main localization class - stores all translations in Dart code
/// This allows Shorebird to patch new languages without asset changes
class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static AppLocalizations? of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  // Get translations based on locale
  AppLocalizationStrings get strings {
    switch (locale.languageCode) {
      case 'es':
        return SpanishStrings();
      case 'fr':
        return FrenchStrings();
      case 'vi':
        return VietnameseStrings();
      case 'en':
      default:
        return EnglishStrings();
    }
  }
}

/// Base class for localization strings
abstract class AppLocalizationStrings {
  // Finance app strings
  String get revenueLabel;
  String get expenseLabel;
  String get depreciationLabel;
  String get calculateCta;
  String get profitLabel;
  String get appTitle;
  String get selectLanguage;

  // Season labels
  String get seasonHot;
  String get seasonCold;
  String get seasonWarm;
  String get seasonRain;

  // Version labels
  String get versionSimple;
  String get versionAdvanced;
  String get versionPatched;

  // Calculation labels
  String get calculationSimple;
  String get calculationAdvanced;

  // Tooltip tutorial strings
  String get tooltipWelcomeTitle;
  String get tooltipWelcomeMessage;
  String get tooltipRevenueField;
  String get tooltipExpenseField;
  String get tooltipDepreciationField;
  String get tooltipCalculateButton;
  String get tooltipProfitDisplay;
  String get tooltipGotIt;
}

/// English translations
class EnglishStrings extends AppLocalizationStrings {
  @override
  String get revenueLabel => 'Revenue';

  @override
  String get expenseLabel => 'Expense';

  @override
  String get depreciationLabel => 'Depreciation';

  @override
  String get calculateCta => 'Calculate Profit';

  @override
  String get profitLabel => 'Profit';

  @override
  String get appTitle => 'Shorebird Finance';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get seasonHot => 'Hot';

  @override
  String get seasonCold => 'Cold';

  @override
  String get seasonWarm => 'Warm';

  @override
  String get seasonRain => 'Rain';

  @override
  String get versionSimple => 'App version: 1.0.0';

  @override
  String get versionAdvanced => 'App version: 1.0.1 — Patched by Shorebird 🕊️';

  @override
  String get versionPatched => 'Patched by Shorebird 🕊️';

  @override
  String get calculationSimple => 'Calculation: Profit = Revenue - Expense';

  @override
  String get calculationAdvanced =>
      'Calculation: Profit = Revenue - Expense - Depreciation';

  @override
  String get tooltipWelcomeTitle => 'Welcome! 👋';

  @override
  String get tooltipWelcomeMessage =>
      'This app has been updated with Shorebird! '
      "Let's take a quick tour of the new features.";

  @override
  String get tooltipRevenueField =>
      'Enter your total revenue here. This is the money '
      "you've earned from your business or investments.";

  @override
  String get tooltipExpenseField =>
      'Enter your total expenses here. These are all the '
      'costs associated with running your business.';

  @override
  String get tooltipDepreciationField =>
      'Depreciation accounts for the decrease in value of '
      'your assets over time. This helps calculate accurate profit.';

  @override
  String get tooltipCalculateButton =>
      'Tap this button to calculate your profit. The calculation '
      'will subtract expenses and depreciation from your revenue.';

  @override
  String get tooltipProfitDisplay =>
      'Your calculated profit will appear here. This shows '
      "how much money you've actually made after all deductions.";

  @override
  String get tooltipGotIt => 'Got it';
}

/// Spanish translations
class SpanishStrings extends AppLocalizationStrings {
  @override
  String get revenueLabel => 'Ingresos';

  @override
  String get expenseLabel => 'Gastos';

  @override
  String get depreciationLabel => 'Depreciación';

  @override
  String get calculateCta => 'Calcular Ganancia';

  @override
  String get profitLabel => 'Ganancia';

  @override
  String get appTitle => 'Shorebird Finanzas';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

  @override
  String get seasonHot => 'Caliente';

  @override
  String get seasonCold => 'Frío';

  @override
  String get seasonWarm => 'Templado';

  @override
  String get seasonRain => 'Lluvia';

  @override
  String get versionSimple => 'Versión de la app: 1.0.0';

  @override
  String get versionAdvanced =>
      'Versión de la app: 1.0.1 — Parcheado por Shorebird 🕊️';

  @override
  String get versionPatched => 'Parcheado por Shorebird 🕊️';

  @override
  String get calculationSimple => 'Cálculo: Ganancia = Ingresos - Gastos';

  @override
  String get calculationAdvanced =>
      'Cálculo: Ganancia = Ingresos - Gastos - Depreciación';

  @override
  String get tooltipWelcomeTitle => '¡Bienvenido! 👋';

  @override
  String get tooltipWelcomeMessage =>
      '¡Esta aplicación ha sido actualizada con Shorebird! '
      'Déjame mostrarte un recorrido rápido de las nuevas funciones.';

  @override
  String get tooltipRevenueField =>
      'Ingresa tu ingreso total aquí. Este es el dinero '
      'que has ganado de tu negocio o inversiones.';

  @override
  String get tooltipExpenseField =>
      'Ingresa tus gastos totales aquí. Estos son todos los '
      'costos asociados con la operación de tu negocio.';

  @override
  String get tooltipDepreciationField =>
      'La depreciación representa la disminución en el valor de '
      'tus activos con el tiempo. Esto ayuda a calcular la ganancia precisa.';

  @override
  String get tooltipCalculateButton =>
      'Toca este botón para calcular tu ganancia. El cálculo '
      'restará los gastos y la depreciación de tus ingresos.';

  @override
  String get tooltipProfitDisplay =>
      'Tu ganancia calculada aparecerá aquí. Esto muestra '
      'cuánto dinero has ganado realmente después de todas las deducciones.';

  @override
  String get tooltipGotIt => 'Entendido';
}

/// French translations
class FrenchStrings extends AppLocalizationStrings {
  @override
  String get revenueLabel => 'Revenus';

  @override
  String get expenseLabel => 'Dépenses';

  @override
  String get depreciationLabel => 'Amortissement';

  @override
  String get calculateCta => 'Calculer le Profit';

  @override
  String get profitLabel => 'Profit';

  @override
  String get appTitle => 'Shorebird Finance';

  @override
  String get selectLanguage => 'Sélectionner la Langue';

  @override
  String get seasonHot => 'Chaud';

  @override
  String get seasonCold => 'Froid';

  @override
  String get seasonWarm => 'Doux';

  @override
  String get seasonRain => 'Pluie';

  @override
  String get versionSimple => "Version de l'app: 1.0.0";

  @override
  String get versionAdvanced =>
      "Version de l'app: 1.0.1 — Patché par Shorebird 🕊️";

  @override
  String get versionPatched => 'Patché par Shorebird 🕊️';

  @override
  String get calculationSimple => 'Calcul: Profit = Revenus - Dépenses';

  @override
  String get calculationAdvanced =>
      'Calcul: Profit = Revenus - Dépenses - Amortissement';

  @override
  String get tooltipWelcomeTitle => 'Bienvenue ! 👋';

  @override
  String get tooltipWelcomeMessage =>
      'Cette application a été mise à jour avec Shorebird ! '
      'Faisons un tour rapide des nouvelles fonctionnalités.';

  @override
  String get tooltipRevenueField =>
      "Entrez votre revenu total ici. C'est l'argent "
      'que vous avez gagné de votre entreprise ou investissements.';

  @override
  String get tooltipExpenseField =>
      'Entrez vos dépenses totales ici. Ce sont tous les '
      'coûts associés à la gestion de votre entreprise.';

  @override
  String get tooltipDepreciationField =>
      "L'amortissement représente la diminution de la valeur de "
      'vos actifs au fil du temps. Cela aide à calculer le profit précis.';

  @override
  String get tooltipCalculateButton =>
      'Appuyez sur ce bouton pour calculer votre profit. Le calcul '
      "soustraira les dépenses et l'amortissement de vos revenus.";

  @override
  String get tooltipProfitDisplay =>
      'Votre profit calculé apparaîtra ici. Cela montre '
      "combien d'argent vous avez réellement gagné "
      'après toutes les déductions.';

  @override
  String get tooltipGotIt => 'Compris';
}

/// Vietnamese translations
class VietnameseStrings extends AppLocalizationStrings {
  @override
  String get revenueLabel => 'Doanh thu';

  @override
  String get expenseLabel => 'Chi phí';

  @override
  String get depreciationLabel => 'Khấu hao';

  @override
  String get calculateCta => 'Tính Lợi nhuận';

  @override
  String get profitLabel => 'Lợi nhuận';

  @override
  String get appTitle => 'Shorebird Tài chính';

  @override
  String get selectLanguage => 'Chọn Ngôn ngữ';

  @override
  String get seasonHot => 'Nóng';

  @override
  String get seasonCold => 'Lạnh';

  @override
  String get seasonWarm => 'Ấm';

  @override
  String get seasonRain => 'Mưa';

  @override
  String get versionSimple => 'Phiên bản ứng dụng: 1.0.0';

  @override
  String get versionAdvanced =>
      'Phiên bản ứng dụng: 1.0.1 — Đã cập nhật bởi Shorebird 🕊️';

  @override
  String get versionPatched => 'Đã cập nhật bởi Shorebird 🕊️';

  @override
  String get calculationSimple => 'Công thức: Lợi nhuận = Doanh thu - Chi phí';

  @override
  String get calculationAdvanced =>
      'Công thức: Lợi nhuận = Doanh thu - Chi phí - Khấu hao';

  @override
  String get tooltipWelcomeTitle => 'Chào mừng! 👋';

  @override
  String get tooltipWelcomeMessage =>
      'Ứng dụng này đã được cập nhật bằng Shorebird! '
      'Hãy cùng khám phá các tính năng mới.';

  @override
  String get tooltipRevenueField =>
      'Nhập tổng doanh thu của bạn vào đây. Đây là số tiền '
      'bạn đã kiếm được từ kinh doanh hoặc đầu tư.';

  @override
  String get tooltipExpenseField =>
      'Nhập tổng chi phí của bạn vào đây. Đây là tất cả các '
      'chi phí liên quan đến việc vận hành doanh nghiệp của bạn.';

  @override
  String get tooltipDepreciationField =>
      'Khấu hao tính đến việc giảm giá trị của tài sản của bạn '
      'theo thời gian. Điều này giúp tính toán lợi nhuận chính xác.';

  @override
  String get tooltipCalculateButton =>
      'Nhấn nút này để tính lợi nhuận. Phép tính sẽ trừ chi phí '
      'và khấu hao khỏi doanh thu của bạn.';

  @override
  String get tooltipProfitDisplay =>
      'Lợi nhuận đã tính của bạn sẽ hiển thị ở đây. Điều này cho thấy '
      'bạn đã kiếm được bao nhiêu tiền sau tất cả các khoản khấu trừ.';

  @override
  String get tooltipGotIt => 'Đã hiểu';
}
