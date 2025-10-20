import '../utils/file_utils.dart';
import '../utils/name_utils.dart';
import '../templates/model_template.dart';
import '../templates/repository_template.dart';
import '../templates/service_template.dart';
import '../templates/store_template.dart';
import '../templates/page_template.dart';
import '../templates/module_template.dart';

class ScaffoldCommand {
  void execute(String moduleName) {
    final pascalCaseName = NameUtils.toPascalCase(moduleName);
    final camelCaseName = NameUtils.toCamelCase(moduleName);
    final snakeCaseName = NameUtils.toCamelCase(moduleName);

    print('🚀 Gerando scaffold para: $pascalCaseName...\n');

    // Define paths
    final basePath = 'lib/app';
    final modelsPath = '$basePath/models/${snakeCaseName}';
    final repositoriesPath = '$basePath/repositories/${snakeCaseName}';
    final servicesPath = '$basePath/services/${snakeCaseName}';
    final modulesPath = '$basePath/modules/${snakeCaseName}';

    // Cria diretórios
    _createDirectories(modulesPath, modelsPath, repositoriesPath, servicesPath);

    // Gera arquivos usando templates
    _generateFiles(
      pascalCaseName: pascalCaseName,
      camelCaseName: camelCaseName,
      snakeCaseName: snakeCaseName,
      modulesPath: modulesPath,
      modelsPath: modelsPath,
      repositoriesPath: repositoriesPath,
      servicesPath: servicesPath,
    );

    _printSuccessMessage(pascalCaseName, snakeCaseName, modulesPath);
  }

  void _createDirectories(String modulesPath, String modelsPath,
      String repositoriesPath, String servicesPath) {
    FileUtils.createDirectory(modulesPath);
    FileUtils.createDirectory(modelsPath);
    FileUtils.createDirectory(repositoriesPath);
    FileUtils.createDirectory(servicesPath);
  }

  void _generateFiles({
    required String pascalCaseName,
    required String camelCaseName,
    required String snakeCaseName,
    required String modulesPath,
    required String modelsPath,
    required String repositoriesPath,
    required String servicesPath,
  }) {
    // Model
    FileUtils.writeFile(
      '$modelsPath/${snakeCaseName}_model.dart',
      ModelTemplate.generate(pascalCaseName, snakeCaseName),
    );

    // Repository e Interface
    FileUtils.writeFile(
      '$repositoriesPath/${snakeCaseName}_repository.dart',
      RepositoryTemplate.generateInterface(pascalCaseName, snakeCaseName),
    );

    FileUtils.writeFile(
      '$repositoriesPath/${snakeCaseName}_repository_impl.dart',
      RepositoryTemplate.generateImplementation(
          pascalCaseName, camelCaseName, snakeCaseName),
    );

    // Service e Interface
    FileUtils.writeFile(
      '$servicesPath/${snakeCaseName}_service.dart',
      ServiceTemplate.generateInterface(pascalCaseName, snakeCaseName),
    );

    FileUtils.writeFile(
      '$servicesPath/${snakeCaseName}_service_impl.dart',
      ServiceTemplate.generateImplementation(
          pascalCaseName, camelCaseName, snakeCaseName),
    );

    // Store, Page e Module
    FileUtils.writeFile(
      '$modulesPath/${snakeCaseName}_page.dart',
      PageTemplate.generate(pascalCaseName, camelCaseName, snakeCaseName),
    );

    FileUtils.writeFile(
      '$modulesPath/${snakeCaseName}_store.dart',
      StoreTemplate.generate(pascalCaseName, camelCaseName, snakeCaseName),
    );

    FileUtils.writeFile(
      '$modulesPath/${snakeCaseName}_module.dart',
      ModuleTemplate.generate(pascalCaseName, snakeCaseName, camelCaseName),
    );
  }

  void _printSuccessMessage(
      String pascalCaseName, String snakeCaseName, String modulesPath) {
    print('🎉 Scaffold para $pascalCaseName gerado com sucesso!');
    print('📂 Arquivos gerados em: $modulesPath');
    print('\n Próximos passos:');
    print('   1. Adicione o módulo ao seu AppModule:');
    print(
        '      ModuleRoute(\'/$snakeCaseName\', module: ${pascalCaseName}Module()),');
    print(
        '   2. Execute: flutter pub run build_runner build --delete-conflicting-outputs');
  }
}
