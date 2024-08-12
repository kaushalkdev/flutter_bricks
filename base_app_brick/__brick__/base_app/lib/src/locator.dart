import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'svcs/svcs.dart';

class Locator {
  Locator._();

  static final Locator i = Locator._();

  final GetIt _getIt = GetIt.instance;

  T get<T extends Object>() => _getIt.get<T>();
  bool isRegistered<T extends Object>() => _getIt.isRegistered<T>();
  FutureOr<dynamic> unRegister<T extends Object>() => _getIt.unregister<T>();
  void resetAll() => _getIt.reset();

  void register() {
    _getIt.registerLazySingleton<NetworkSvcs>(() => DioNetworkSvcs());

    _getIt.registerLazySingleton<NotificationSvcs>(() => FrbNotificationSvs());

    _getIt.registerLazySingleton<AnalyticsSvcs>(() => FrbAnalyticsSvs());

    _getIt.registerLazySingleton<DbSvcs>(() => HiveDbSvcs());

    _getIt.registerSingleton<Logger>(Logger());
  }
}
