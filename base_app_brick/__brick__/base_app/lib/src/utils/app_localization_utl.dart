import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocalizationUtls {
  static final AppLocalizationUtls i = AppLocalizationUtls._();
  AppLocalizationUtls._() {
    _currentLocale = ValueNotifier(supportedLocales.first);
  }

  late ValueNotifier<Locale> _currentLocale;
  ValueNotifier<Locale> get currentLocale => _currentLocale;

  List<Locale> get supportedLocales => const [
        Locale('en'),
        Locale('es'),
      ];

  void setLocale([Locale? locale]) {
    _currentLocale.value = locale ?? supportedLocales.first;
  }

  List<LocalizationsDelegate> get localizationsDelegates => [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];
}

extension AppLocalizationsExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
