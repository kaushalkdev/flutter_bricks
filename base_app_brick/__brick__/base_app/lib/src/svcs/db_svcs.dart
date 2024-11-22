import 'package:base_app/src/locator.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

abstract class DBkeys {
  static const String token = 'token';
  static const String notification = 'notification';
}

abstract class DbSvcs {
  Future<void> init();

  T? get<T>(String key);

  Future<void> put<T>(String key, T value);

  Future<void> delete(String key);

  Future<void> close();

  Future<void> resetDb();
}

class HiveDbSvcs implements DbSvcs {
  static const String dbName = 'HiveDb';
  Box? _box;
  @override
  Future<void> close() async {
    await _box?.close();
  }

  @override
  Future<void> delete(String key) async {
    await _box?.delete(key);
  }

  @override
  T? get<T>(String key) {
    return _box?.get(key);
  }

  @override
  Future<void> init() async {
    try {
      Hive.init((await getApplicationDocumentsDirectory()).path);
      _box = await Hive.openBox(dbName);
    } catch (e) {
      Locator.i.get<Logger>().e(e.toString());
    }
  }

  @override
  Future<void> put<T>(String key, T value) async {
    await _box?.put(key, value);
  }

  @override
  Future<void> resetDb() async {
    await Hive.deleteFromDisk();
    _box = null;
  }
}
