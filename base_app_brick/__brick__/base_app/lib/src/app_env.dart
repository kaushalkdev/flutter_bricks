import 'package:base_app/src/svcs/network_svcs.dart';

enum Env { dev, stage, prod }

class EnvValues {
  final String apiBaseUrl;

  EnvValues({required this.apiBaseUrl});
}

abstract class AppEnv {
  static late EnvValues _values;

  static EnvValues get values => _values;

  static void configure(Env env) {
    switch (env) {
      case Env.dev:
        _values = EnvValues(apiBaseUrl: Apis.devBaseUrl);
        break;

      case Env.stage:
        _values = EnvValues(apiBaseUrl: Apis.stageBaseUrl);

      case Env.prod:
        _values = EnvValues(apiBaseUrl: Apis.prodBaseUrl);
    }
  }
}
