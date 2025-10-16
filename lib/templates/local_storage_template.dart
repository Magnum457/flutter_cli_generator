class LocalStorageTemplate {
  // LocalStorage Interface
  static const String localStorageInterface = '''
  abstract class LocalStorage {
    const LocalStorage();

    Future<V?> read<V>(String key);
    Future<void> write<V>(String key, V value);
    Future<bool> contains(String key);
    Future<void> remove(String key);
    Future<void> clear();
  }
''';

  // LocalSecureStorage Interface
  static const String localSecureStorageInterface = '''
  abstract class LocalSecureStorage {
    Future<String?> read(String key);
    Future<void> write(String key, String value);
    Future<bool> contains(String key);
    Future<void> remove(String key);
    Future<void> clear();
  }
''';

  // SharedPreferences Implementation
  static const String sharedPreferencesImpl = '''
  import 'package:shared_preferences/shared_preferences.dart';
  import '../local_storage.dart';

  class SharedPreferencesLocalStorageImpl implements LocalStorage {
    Future<SharedPreferences> get _instance => SharedPreferences.getInstance();

    @override
    Future<void> clear() async {
      final sharedPreferences = await _instance;
      sharedPreferences.clear();
    }

    @override
    Future<bool> contains(String key) async {
      final sharedPreferences = await _instance;
      return sharedPreferences.containsKey(key);
    }

    @override
    Future<V?> read<V>(String key) async {
      final sharedPreferences = await _instance;
      return sharedPreferences.get(key) as V;
    }

    @override
    Future<void> remove(String key) async {
      final sharedPreferences = await _instance;
      sharedPreferences.remove(key);
    }

    @override
    Future<void> write<V>(String key, V value) async {
      final sharedPreferences = await _instance;

      switch (V) {
        case const (int):
          await sharedPreferences.setInt(key, value as int);
          break;
        case const (double):
          await sharedPreferences.setDouble(key, value as double);
          break;
        case const (String):
          await sharedPreferences.setString(key, value as String);
          break;
        case const (bool):
          await sharedPreferences.setBool(key, value as bool);
          break;
        case const (List):
          await sharedPreferences.setStringList(key, value as List<String>);
          break;
        default:
          throw Exception('Type not supported');
      }
    }
  }
''';

  // FlutterSecureStorage Implementation
  static const String flutterSecureStorageImpl = '''
  import 'package:flutter_secure_storage/flutter_secure_storage.dart';
  import '../local_secure_storage.dart';

  class FlutterSecureStorageLocalStorageImpl implements LocalSecureStorage {
    FlutterSecureStorage get _instance => const FlutterSecureStorage();

    @override
    Future<void> clear() async {
      await _instance.deleteAll();
    }

    @override
    Future<bool> contains(String key) async {
      return await _instance.containsKey(key: key);
    }

    @override
    Future<String?> read(String key) async {
      return await _instance.read(key: key);
    }

    @override
    Future<void> remove(String key) async {
      await _instance.delete(key: key);
    }

    @override
    Future<void> write(String key, String value) async {
      await _instance.write(key: key, value: value);
    }
  }
''';
}
