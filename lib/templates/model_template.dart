class ModelTemplate {
  static String generate(String pascalCaseName, String snakeCaseName) {
    return '''
    import 'package:json_annotation/json_annotation.dart';

    part '${snakeCaseName}_model.g.dart';

    @JsonSerializable()
    class ${pascalCaseName}Model {
      final String id;

      ${pascalCaseName}Model({
        required this.id,
      });

      factory ${pascalCaseName}Model.fromJson(Map<String, dynamic> json) => _\$${pascalCaseName}ModelFromJson(json);

      Map<String, dynamic> toJson() => _\$${pascalCaseName}ModelToJson(this);
    }

''';
  }
}
