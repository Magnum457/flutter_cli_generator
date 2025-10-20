class ServiceTemplate {
  static String generateInterface(String pascalCaseName, String snakeCaseName) {
    return '''
    import '../../models/${snakeCaseName}/${snakeCaseName}_model.dart';

    abstract class I${pascalCaseName}Service {
      Future<${pascalCaseName}Model> get${pascalCaseName}();
      Future<List<${pascalCaseName}Model>> getAll${pascalCaseName}s();
      Future<${pascalCaseName}Model> create${pascalCaseName}(${pascalCaseName}Model ${pascalCaseName});
      Future<${pascalCaseName}Model> update${pascalCaseName}(${pascalCaseName}Model ${pascalCaseName});

      // Métodos de gerenciamento de cache/estado
      // Future<${pascalCaseName}Model> get${pascalCaseName}FromCache();
      // Future<void> set${pascalCaseName}InCache(${pascalCaseName}Model ${pascalCaseName});
      // void clearCache();
    }
''';
  }

  static String generateImplementation(
      String pascalCaseName, String camelCaseName, String snakeCaseName) {
    return '''
    import '${snakeCaseName}_service.dart';
    import '../../models/${snakeCaseName}/${snakeCaseName}_model.dart';
    import '../../repositories/${snakeCaseName}/${snakeCaseName}_repository.dart';

    class ${pascalCaseName}Service implements I${pascalCaseName}Service {
      final I${pascalCaseName}Repository _${camelCaseName}Repository;

      ${pascalCaseName}Service({
        required I${pascalCaseName}Repository ${camelCaseName}Repository,
      }) : _${camelCaseName}Repository = ${camelCaseName}Repository;
    
      @override
      Future<${pascalCaseName}Model> get${pascalCaseName}() async {
        // Pode adicionar lógica de cache aqui
        return await _${camelCaseName}Repository.get${pascalCaseName}();
      }

      @override
      Future<List<${pascalCaseName}Model>> getAll${pascalCaseName}s() async {
        // Pode adicionar lógica de cache aqui
        return await _${camelCaseName}Repository.getAll${pascalCaseName}s();
      }

      @override
      Future<${pascalCaseName}Model> create${pascalCaseName}(${pascalCaseName}Model ${camelCaseName}) async {
        final created${pascalCaseName} = await _${camelCaseName}Repository.create${pascalCaseName}(${camelCaseName});
        // Pode adicionar lógica de cache aqui
        return created${pascalCaseName};
      }

      @override
      Future<${pascalCaseName}Model> update${pascalCaseName}(${pascalCaseName}Model ${camelCaseName}) async {
        final updated${pascalCaseName} = await _${camelCaseName}Repository.update${pascalCaseName}(${camelCaseName});
        // Pode adicionar lógica de cache aqui
        return updated${pascalCaseName};
      }
    }
''';
  }
}
