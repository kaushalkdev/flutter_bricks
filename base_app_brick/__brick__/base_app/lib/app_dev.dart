import 'package:base_app/src/app_env.dart';
import 'package:base_app/src/bootstrap.dart';

void main() async {
  AppEnv.configure(Env.dev);
  await bootStrap();
}
