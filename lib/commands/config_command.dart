import '../utils/file_utils.dart';
import '../templates/local_storage_template.dart';
import '../templates/rest_client_template.dart';
import '../templates/life_cycle_template.dart';
import '../templates/core_module_template.dart';
import '../templates/app_module_template.dart';

class ConfigCommand {
  void execute() {
    print('🚀 Configurando a infraestrutura do projeto...\n');

    // Cria a estrutura de diretórios
    _createDirectories();

    // Cria os arquivos de localStorage
    _generateLocalStorage();

    // Gera os arquivos de restClient
    _generateRestClient();

    // Gera os arquivos de lifeCycle dos widgets
    _generateLifeCycle();

    // Gera os arquivos do CoreModule
    _generateCoreModule();

    // Gera os arquivos do AppModule
    _generateAppModule();

    print('🎉 Infraestrutura configurada com sucesso!\n');
    print('📋 Arquivos gerados:');
    print('   - core/');
    print('   - core/local_storage/');
    print('   - core/rest_client/');
    print('   - core/life_cycle/');
    print('   - core/core_module.dart');
    print('   - app_module.dart');
    print('\n📦 Execute: flutter pub get');
    print('\n📝 Próximos passos:');
    print('   1. Configure seu main.dart para usar o AppModule');
    print('   2. Adicione as rotas dos seus módulos no AppModule');
  }

  void _createDirectories() {
    // Cria a estrutura de diretórios do localStorage
    FileUtils.createDirectory('lib/app/core/local_storage');
    FileUtils.createDirectory(
        'lib/app/core/local_storage/flutter_secure_storage');
    FileUtils.createDirectory('lib/app/core/local_storage/shared_preferences');

    // Cria a estrutura de diretórios do restClient
    FileUtils.createDirectory('lib/app/core/rest_client');
    FileUtils.createDirectory('lib/app/core/rest_client/dio');
    FileUtils.createDirectory('lib/app/core/rest_client/dio/interceptors');

    // Cria a estrutura de diretórios do lifeCycle
    FileUtils.createDirectory('lib/app/core/life_cycle');
  }

  void _generateCoreModule() {
    FileUtils.writeFile(
      'lib/app/core/core_module.dart',
      CoreModuleTemplate.coreModule,
    );
  }

  void _generateAppModule() {
    FileUtils.writeFile(
      'lib/app/app_module.dart',
      AppModuleTemplate.appModule,
    );
  }

  void _generateLocalStorage() {
    // Interface LocalStorage
    FileUtils.writeFile(
      'lib/app/core/local_storage/local_storage.dart',
      LocalStorageTemplate.localStorageInterface,
    );

    // Interface LocalSecureStorage
    FileUtils.writeFile(
      'lib/app/core/local_storage/local_secure_storage.dart',
      LocalStorageTemplate.localSecureStorageInterface,
    );

    // FlutterSecureStorage LocalStorage
    FileUtils.writeFile(
      'lib/app/core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage.dart',
      LocalStorageTemplate.flutterSecureStorageImpl,
    );

    // SharedPreferences LocalStorage
    FileUtils.writeFile(
      'lib/app/core/local_storage/shared_preferences/shared_preferences_local_storage.dart',
      LocalStorageTemplate.sharedPreferencesImpl,
    );
  }

  void _generateRestClient() {
    // RestClient Interface
    FileUtils.writeFile(
      'lib/app/core/rest_client/rest_client.dart',
      RestClientTemplate.restClientInterface,
    );

    // RestClient Response
    FileUtils.writeFile(
      'lib/app/core/rest_client/rest_client_response.dart',
      RestClientTemplate.restClientResponse,
    );

    // RestClientException
    FileUtils.writeFile(
      'lib/app/core/rest_client/rest_client_exception.dart',
      RestClientTemplate.restClientException,
    );

    // Dio RestClient
    FileUtils.writeFile(
      'lib/app/core/rest_client/dio/dio_rest_client.dart',
      RestClientTemplate.dioRestClient,
    );

    // Dio Interceptor
    FileUtils.writeFile(
      'lib/app/core/rest_client/dio/interceptors/dio_interceptor.dart',
      RestClientTemplate.authInterceptor,
    );
  }

  void _generateLifeCycle() {
    // Controller LifeCycle
    FileUtils.writeFile(
      'lib/app/core/life_cycle/controller_life_cycle.dart',
      LifeCycleTemplate.controllerLifeCycle,
    );

    // page LifeCycle
    FileUtils.writeFile(
      'lib/app/core/life_cycle/page_life_cycle_state.dart',
      LifeCycleTemplate.pageLifeCycleState,
    );
  }
}
