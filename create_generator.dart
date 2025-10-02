import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: create_generator.dart <name>');
    return;
  }

  String featureName = arguments[0];
  String className = featureName[0].toUpperCase() + featureName.substring(1);
  String snakeCase = featureName.toLowerCase();

  // 1. Criando os diretorios
  Directory('lib/app/models/${snakeCase}').createSync(recursive: true);
  Directory('lib/app/repositories/${snakeCase}').createSync(recursive: true);
  Directory('lib/app/services/${snakeCase}').createSync(recursive: true);
  Directory('lib/app/modules/${snakeCase}').createSync(recursive: true);

  // 2. Criar e preencher o arquivo do Model
  File modelFile = File('lib/app/models/${snakeCase}/${snakeCase}_model.dart');

  modelFile.writeAsStringSync('''
    class ${className}Model {}
  ''');

  // 3. Criar e preencher o arquivo do Repository
  File repositoryFile =
      File('lib/app/repositories/${snakeCase}/${snakeCase}_repository.dart');

  repositoryFile.writeAsStringSync('''
    import '../../models/${snakeCase}/${snakeCase}_model.dart';

    abstract class ${className}Repository {
      Future<${className}Model> get${className}();
    }
  ''');

  // 4. Criar e preencher o arquivo do Service
  File serviceFile =
      File('lib/app/services/${snakeCase}/${snakeCase}_service.dart');

  serviceFile.writeAsStringSync('''
    import '../../models/${snakeCase}/${snakeCase}_model.dart';

    abstract class ${className}Service {
      Future<${className}Model> get${className}();
    }
  ''');

  // 2. Criar e preencher o arquivo do Store (MobX)
  File storeFile = File('lib/app/modules/${snakeCase}/${snakeCase}_store.dart');

  storeFile.writeAsStringSync('''
      import 'package:mobx/mobx.dart';

      part '${snakeCase}_store.g.dart';

      class ${className}Store = _${className}StoreBase with \$_${className}Store;

      abstract class _${className}StoreBase with Store {}
    ''');

// 3. Criar e preencher o arquivo do Widget (Flutter Modular)
  File widgetFile = File('lib/app/modules/${snakeCase}/${snakeCase}_page.dart');

  widgetFile.writeAsStringSync('''
      import 'package:flutter/material.dart';
      import 'package:flutter_modular/flutter_modular.dart';
      import '${snakeCase}_store.dart';

      class ${className}Page extends StatefulWidget {
        const ${className}Page({super.key});

        @override
        State<${className}Page> createState() => _${className}PageState();
      }

      class _${className}PageState extends PageLifeCycleState<${className}Store, ${className}Page> {
        @override
        Widget build(BuildContext context) {
          return Container();
        }
      }
    ''');

  // 4. Criar e preencher o arquivo do Module (Flutter Modular)
  File moduleFile =
      File('lib/app/modules/${snakeCase}/${snakeCase}_module.dart');

  moduleFile.writeAsStringSync('''
      import 'package:flutter_modular/flutter_modular.dart';

      import '${snakeCase}_store.dart';

      class ${className}Module extends Module {
        @override
        final List<Bind> binds = [
          Bind.lazySingleton((i) => ${className}Store()),
        ];

        @override
        final List<ModularRoute> routes = [];
      }
    ''');
}
