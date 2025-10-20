class ModuleTemplate {
  static String generate(
      String pascalCaseName, String snakeCaseName, String camelCaseName) {
    return '''
    import 'package:flutter_modular/flutter_modular.dart';

    import '../../core/rest_client/rest_client.dart';

    import '../../repositories/${snakeCaseName}/${snakeCaseName}_repository.dart';
    import '../../repositories//${snakeCaseName}/${snakeCaseName}_repository_impl.dart';

    import '../../services/${snakeCaseName}/${snakeCaseName}_service.dart';
    import '../../services/${snakeCaseName}/${snakeCaseName}_service_impl.dart';

    import '${snakeCaseName}_page.dart';
    import '${snakeCaseName}_store.dart';

    class ${snakeCaseName}Module extends Module {
      @override
      List<Bind> binds = [
        Bind.lazySingleton<I${pascalCaseName}Repository>(
          (i) => ${pascalCaseName}Repository(
            restClient: i<RestClient>(),
          ),
        ),
        Bind.lazySingleton<I${pascalCaseName}Service>(
          (i) => ${pascalCaseName}Service(
            ${camelCaseName}Repository: i<I${pascalCaseName}Repository>(),
          ),
        ),
        Bind.singleton(
          (i) => ${pascalCaseName}Store(
            ${camelCaseName}Service: i<I${pascalCaseName}Service>(),
          ),
        ),
      ];

      @override
      List<ModularRoute> routes = [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const ${pascalCaseName}Page(),
        ),
      ];
    }
''';
  }
}
