# Localization with Shorebird - Implementation Guide

## Answer to Your Question

### Can Shorebird patch new languages added via flutter_localizations?

**Short Answer**: 
- ❌ **NO** - If you use ARB/JSON asset files (traditional flutter_localizations approach)
- ✅ **YES** - If you use code-based translations (Dart classes)

### Why This Limitation?

Shorebird currently **does NOT support patching asset files**, including:
- ARB files (`app_en.arb`, `app_es.arb`, etc.)
- JSON localization files
- Image assets
- Font files

However, Shorebird **CAN patch Dart code**, which is why we implemented a code-based localization system.

---

## Implementation Details

### What We Built

1. **Code-Based Localization System** (`lib/l10n/app_localizations.dart`)
   - All translations stored as Dart classes
   - No ARB/JSON asset files
   - Fully patchable by Shorebird

2. **Supported Languages** (Currently):
   - English (en)
   - Spanish (es)
   - French (fr)
   - Vietnamese (vi)

3. **Language Switcher** (`lib/widgets/language_switcher.dart`)
   - UI component in top-right corner
   - Allows users to switch languages instantly

### How It Works

```dart
// Translations are stored as Dart classes
class EnglishStrings extends AppLocalizationStrings {
  @override
  String get revenueLabel => 'Revenue';
  // ... more strings
}

class SpanishStrings extends AppLocalizationStrings {
  @override
  String get revenueLabel => 'Ingresos';
  // ... more strings
}
```

### Adding a New Language (Patchable!)

To add a new language (e.g., Japanese) that can be patched:

1. **Add new translation class** in `lib/l10n/app_localizations.dart`:
```dart
class JapaneseStrings extends AppLocalizationStrings {
  @override
  String get revenueLabel => '収入';
  @override
  String get expenseLabel => '費用';
  // ... all other strings
}
```

2. **Add locale** to `AppSupportedLocales.locales`:
```dart
static const List<Locale> locales = [
  Locale('en', 'US'),
  Locale('es', 'ES'),
  Locale('fr', 'FR'),
  Locale('vi', 'VN'),
  Locale('ja', 'JP'), // NEW!
];
```

3. **Update switch statement** in `AppLocalizations.strings`:
```dart
switch (locale.languageCode) {
  case 'ja':
    return JapaneseStrings(); // NEW!
  // ... existing cases
}
```

4. **Create Shorebird patch**:
```bash
shorebird patch ios --release-version 1.0.0+1
shorebird patch android --release-version 1.0.0+1
```

5. **Users get new language** automatically on next app launch! 🎉

---

## Comparison: Asset-Based vs Code-Based

### Traditional Approach (ARB Files) - NOT Patchable
```
lib/l10n/
├── app_en.arb    ❌ Asset file - cannot be patched
├── app_es.arb    ❌ Asset file - cannot be patched
└── app_fr.arb    ❌ Asset file - cannot be patched
```

**Limitation**: Adding new languages requires full app store release.

### Our Approach (Dart Classes) - Patchable ✅
```
lib/l10n/
└── app_localizations.dart  ✅ Dart code - can be patched
    ├── EnglishStrings
    ├── SpanishStrings
    ├── FrenchStrings
    └── VietnameseStrings
```

**Advantage**: Adding new languages can be done via Shorebird patch!

---

## Usage in Code

### Accessing Translations

```dart
// In any widget
final localizations = AppLocalizations.of(context);
final strings = localizations?.strings ?? EnglishStrings();

// Use translations
Text(strings.revenueLabel)  // "Revenue" or "Ingresos" etc.
```

### Language Switcher

The language switcher is automatically added to `FinanceHomeV1` and `FinanceHomeV2`:
- Located in top-right corner
- Shows current language
- Allows instant language switching

---

## Demo Scenario

### Adding Japanese Language Support

**Baseline**: App supports English, Spanish, French, Vietnamese

**Patch Story**: "We need to expand to Japanese market immediately"

1. **Add Japanese translations** (code changes)
2. **Create Shorebird patch**
3. **Deploy patch**
4. **Users get Japanese option** automatically
5. **No app store update needed!**

**Time**: < 5 minutes vs 3-7 days for traditional approach

---

## Best Practices

1. **Use code-based localization** for Shorebird compatibility
2. **Keep translations organized** in separate classes
3. **Test all languages** before patching
4. **Document new languages** in changelog
5. **Consider translation quality** - use professional translators

---

## Limitations

### What Shorebird CAN Patch
- ✅ Dart code (including translation classes)
- ✅ Business logic
- ✅ UI components
- ✅ Calculations

### What Shorebird CANNOT Patch
- ❌ ARB/JSON asset files
- ❌ Image assets
- ❌ Font files
- ❌ Native code changes

---

## Future Considerations

Shorebird team has mentioned plans to support asset patching in the future. When that happens:
- You could potentially use ARB files
- But code-based approach will still work
- Choose based on your team's preferences

---

## Summary

✅ **Yes, you can add new languages via Shorebird patches** - but only if you use code-based translations (Dart classes), not asset files (ARB/JSON).

✅ **We've implemented a complete multi-language system** that:
- Supports 4 languages out of the box
- Can be extended with new languages via patches
- Includes a language switcher UI
- Works seamlessly with Shorebird

The app is now ready to demonstrate how localization can be updated via Shorebird patches! 🎉
