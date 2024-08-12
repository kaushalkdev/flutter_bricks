import 'package:base_app/src/app_env.dart';

import 'src/bootstrap.dart';

void main() async {
  AppEnv.configure(Env.prod);
  await bootStrap();
}
