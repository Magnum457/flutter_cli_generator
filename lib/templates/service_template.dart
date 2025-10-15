class ServiceTemplate {
  static String generateInterface(String pascalCaseName, String snakeCaseName) {
    return '''
    import '../models/${snakeCaseName}_model.dart';

    abstract class I${pascalCaseName}Service {
      Future<${pascalCaseName}Model> get${pascalCaseName}();
      Future<List<${pascalCaseName}Model>> getAll${pascalCaseName}s();
      Future<${pascalCaseName}Model> create${pascalCaseName}(${pascalCaseName}Model ${pascalCaseName});
      Future<${pascalCaseName}Model> update${pascalCaseName}(${pascalCaseName}Model ${pascalCaseName});

      // Métodos de gerenciamento de cache/estado
      Future<${pascalCaseName}Model> get${pascalCaseName}FromCache();
      Future<void> set${pascalCaseName}InCache(${pascalCaseName}Model ${pascalCaseName});
      void clearCache();
    }
''';
  }
}
