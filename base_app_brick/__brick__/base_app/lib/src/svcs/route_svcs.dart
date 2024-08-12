import 'dart:async';

import 'package:base_app/src/app/home/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class Routes {
  static const String home = '/';
  static const String newScreen = 'new';
}

class RouteSvs {
  static RouteSvs i = RouteSvs._();
  RouteSvs._();

  late GoRouter _routes;

  GoRouter get routes => _routes;

  void configureRoutes({GlobalKey<NavigatorState>? navigatorKey}) {
    _routes = GoRouter(
      navigatorKey:
          GlobalKey<NavigatorState>(), // need from outside // requyired
      initialLocation: Routes.home,
      routes: [
        GoRoute(
            path: Routes.home,
            name: Routes.home,
            builder: (context, state) => const MyHomePage(),
            routes: [
              GoRoute(
                  path: Routes.newScreen,
                  name: Routes.newScreen,
                  builder: (context, state) => const NewScreen()),
            ]),
      ],
      debugLogDiagnostics: kDebugMode,
      observers: [],
      errorPageBuilder: _errorBuilder,
      redirect: _redirectHandler,
    );
  }

  FutureOr<String?> _redirectHandler(
    BuildContext context,
    GoRouterState state,
  ) {
    return null;
  }

  Page _errorBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return MaterialPage(
      child: Center(
        child: Text(state.error.toString()),
      ),
    );
  }
}
