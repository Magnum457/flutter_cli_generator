class CoreModuleTemplate {
  static const String coreModule = '''
  import 'package:flutter_modular/flutter_modular.dart';

  import 'local_storage/local_storage.dart';
  import 'local_storage/shared_preferences/shared_preferences_local_storage.dart';

  import 'local_storage/local_secure_storage.dart';
  import 'local_storage/flutter_secure_storage/flutter_secure_storage_local_storage.dart';

  import 'rest_client/rest_client.dart';
  import 'rest_client/dio/dio_rest_client.dart';

  class CoreModule extends Module {
    @override
      List<Bind> binds = [
        Bind.lazySingleton<LocalStorage>(
          (i) => SharedPreferencesLocalStorageImpl(),
          export: true,
        ),
        Bind.lazySingleton<LocalSecureStorage>(
          (i) => FlutterSecureStorageLocalStorageImpl(),
          export: true,
        ),
        Bind.lazySingleton<RestClient>(
          (i) => DioRestClient(),
          export: true,
        ),
      ];
    }
''';
}
