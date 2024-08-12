import 'package:base_app/src/locator.dart';
import 'package:base_app/src/svcs/svcs.dart';
import 'package:base_app/src/utils/utils.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: AppThemeUtl.i.currentTheme,
      builder: (context, appTheme, child) {
        return ValueListenableBuilder<Locale>(
          valueListenable: AppLocalizationUtls.i.currentLocale,
          builder: (context, currentLocale, child) {
            return MaterialApp.router(
              theme: appTheme,
              routerConfig: RouteSvs.i.routes,
              locale: currentLocale,
              supportedLocales: AppLocalizationUtls.i.supportedLocales,
              localizationsDelegates:
                  AppLocalizationUtls.i.localizationsDelegates,
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    Locator.i.get<NetworkSvcs>().dispose();
    Locator.i.get<NotificationSvcs>().dispose();
    AppThemeUtl.i.currentTheme.dispose();
    super.dispose();
  }
}
