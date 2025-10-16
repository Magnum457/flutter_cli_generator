import '../utils/file_utils.dart';
import '../utils/name_utils.dart';
import '../templates/model_template.dart';
import '../templates/repository_template.dart';
import '../templates/service_template.dart';

class ScaffoldCommand {
  void execute(String moduleName) {
    final pascalCaseName = NameUtils.toPascalCase(moduleName);
    final camelCaseName = NameUtils.toCamelCase(moduleName);
    final snakeCaseName = NameUtils.toCamelCase(moduleName);

    print('🚀 Gerando scaffold para: $pascalCaseName...\n');

    // Define paths
    final basePath = 'lib/app';
    final modelsPath = '$basePath/models';
    final repositoriesPath = '$basePath/repositories';
    final servicesPath = '$basePath/services';

    // Cria diretórios
    FileUtils.createDirectory(modelsPath);
    FileUtils.createDirectory(repositoriesPath);
    FileUtils.createDirectory(servicesPath);

    // Gera arquivos usando templates
    _generateFiles({
      required String pascalCaseName,
      required String camelCaseName,
      required String snakeCaseName,
      required String modelsPath,
      required String repositoriesPath,
      required String servicesPath,
    }) {
      // Model
      FileUtils.writeFile(
        '$modelsPath/${snakeCaseName}_model.dart',
        ModelTemplate.generate(pascalCaseName, snakeCaseName),
      );

      // Repository
      FileUtils.writeFile(
        '$repositoriesPath/${snakeCaseName}_repository.dart',
        RepositoryTemplate.generateInterface(pascalCaseName, snakeCaseName),
      );
      FileUtils.writeFile(
        '$repositoriesPath/${snakeCaseName}_repository_impl.dart',
        RepositoryTemplate.generateImplementation(
            pascalCaseName, camelCaseName, snakeCaseName),
      );

      // Service
      FileUtils.writeFile(
        '$servicesPath/${snakeCaseName}_service.dart',
        ServiceTemplate.generateInterface(pascalCaseName, snakeCaseName),
      );
      FileUtils.writeFile(
        '$servicesPath/${snakeCaseName}_service_impl.dart',
        ServiceTemplate.generateImplementation(
            pascalCaseName, camelCaseName, snakeCaseName),
      );
    }

    void _printSuccesMessage(
      String pascalCaseName,
      String snakeCaseName,
      String modulesPath,
    ) {
      print('\n✅ Scaffold do módulo "$pascalCaseName" criado com sucesso!');
      print('\n Próximos passos:');
      print(
          '  2. Execute: flutter pub run build_runner build --delete-conflicting-outputs');
    }
  }
}
