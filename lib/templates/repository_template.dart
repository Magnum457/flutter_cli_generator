class RepositoryTemplate {
  static String generateInterface(String pascalCaseName, String snakeCaseName) {
    return '''
      import '../../models/${snakeCaseName}/${snakeCaseName}_model.dart';

      abstract class I${pascalCaseName}Repository {
        Future<${pascalCaseName}Model> get${pascalCaseName}();
        Future<List<${pascalCaseName}Model>> getAll${pascalCaseName}s();
        Future<${pascalCaseName}Model> create${pascalCaseName}(${pascalCaseName}Model ${pascalCaseName});
        Future<${pascalCaseName}Model> update${pascalCaseName}(${pascalCaseName}Model ${pascalCaseName});
      }
''';
  }

  static String generateImplementation(
      String pascalCaseName, String camelCaseName, String snakeCaseName) {
    return '''
      import '../../core/rest_client/rest_client.dart';
      import '../../core/rest_client/rest_client_exception.dart';
      
      import '${snakeCaseName}_repository.dart';
      import '../../models/${snakeCaseName}/${snakeCaseName}_model.dart';

      class ${pascalCaseName}Repository implements I${pascalCaseName}Repository {
        final RestClient _restClient;

        ${pascalCaseName}Repository({
          required RestClient restClient,
        }) : _restClient = restClient;

        @override
        Future<${pascalCaseName}Model> get${pascalCaseName}() async {
          try {
            final response = await _restClient.get('/${camelCaseName}');
            return ${pascalCaseName}Model.fromJson(response.data as Map<String, dynamic>);
          } on RestClientException catch (e) {
            throw Exception(e.message);
          }
        }

        @override
        Future<List<${pascalCaseName}Model>> getAll${pascalCaseName}s() async {
          try {
            final response = await _restClient.get('/${camelCaseName}s');
            return (response as List).map((e) => ${pascalCaseName}Model.fromJson(e)).toList();
          } on RestClientException catch (e) {
            throw Exception(e.message);
          }
        }

        @override
        Future<${pascalCaseName}Model> create${pascalCaseName}(${pascalCaseName}Model ${camelCaseName}) async {
          try {
            final response = await _restClient.post('/${camelCaseName}s', data: ${camelCaseName}.toJson());
            return ${pascalCaseName}Model.fromJson(response.data as Map<String, dynamic>);
          } on RestClientException catch (e) {
            throw Exception(e.message);
          }
        }

        @override
        Future<${pascalCaseName}Model> update${pascalCaseName}(${pascalCaseName}Model ${camelCaseName}) async {
          try {
            final response = await _restClient.put('/${camelCaseName}s', data: ${camelCaseName}.toJson());
            return ${pascalCaseName}Model.fromJson(response.data as Map<String, dynamic>);
          } on RestClientException catch (e) {
            throw Exception(e.message);
          }
        }
      }
''';
  }
}
