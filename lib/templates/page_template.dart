class PageTemplate {
  static String generate(
      String pascalCaseName, String camelCaseName, String snakeCaseName) {
    return '''
      import 'package:flutter/material.dart';
      import 'package:flutter_mobx/flutter_mobx.dart';
      import 'package:flutter_modular/flutter_modular.dart';
      import '${snakeCaseName}_store.dart';
      import '../../core/life_cycle/page_life_cycle_state.dart';

      class ${pascalCaseName}Page extends PageLifeCycleState<${pascalCaseName}Store, ${pascalCaseName}Page> {
        @override
        void dispose() {
          super.dispose();
        }

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('${pascalCaseName}'),
            ),
            body: Observer(builder: (_) {
              return Container();
            }),
          );
        }
      }
''';
  }
}
