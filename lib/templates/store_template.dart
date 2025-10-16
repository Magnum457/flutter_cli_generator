class StoreTemplate {
  static String generate(
    String pascalCaseName,
    String camelCaseName,
    String snakeCaseName,
  ) {
    return '''
      import 'package:mobx/mobx.dart';
      import 'package:flutter_modular/flutter_modular.dart';
      
      import '../../services/${snakeCaseName}_service.dart';
      import '../../core/life_cycle/controller_life_cycle.dart';

      part '${snakeCaseName}_store.g.dart';

      class ${pascalCaseName}Store = _${pascalCaseName}StoreBase with \$${pascalCaseName}Store;

      abstract class _${pascalCaseName}StoreBase with Store, ControllerLifeCycle {
        final I${pascalCaseName}Service _${camelCaseName}Service;

        _${pascalCaseName}StoreBase({
          required I${pascalCaseName}Service ${camelCaseName}Service,
        }) : _${camelCaseName}Service = ${camelCaseName}Service;
      }

      @override
      void onReady() {
        super.onReady();
      }

      @override
      void dispose() {
        super.dispose();
      }
''';
  }
}
