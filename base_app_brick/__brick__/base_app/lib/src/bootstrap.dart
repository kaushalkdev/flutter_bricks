import 'dart:ui';

import 'package:base_app/firebase_options.dart';
import 'package:base_app/src/app/app.dart';
import 'package:base_app/src/locator.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'svcs/svcs.dart';

Future<void> bootStrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  Locator.i.register();
  // TODO uncomment and add firebase configs
  await Locator.i.get<DbSvcs>().init();
  Locator.i.get<NetworkSvcs>().init();
  Locator.i.get<AnalyticsSvcs>().init();
  Locator.i.get<NotificationSvcs>().init();

  RouteSvs.i.configureRoutes();
  runApp(const MyApp());
}
