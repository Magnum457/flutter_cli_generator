#!/usr/bin/env.dartimport 'dart:ffi';

import 'dart:io';
import 'package:args/args.dart';
import 'package:path/path.dart' as path;

void main(List<String> args) {
  final parser = ArgParser()
    ..addOption(
      'name',
      abbr: 'n',
      mandatory: true,
      help: 'Nome do modulo a ser criado',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Ajuda',
    )
    ..addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Mostra a versão',
    );

  void _showHelp(ArgParser parser) {
    print('''
    Flutter Scaffold CLI

    Uso:
      fscaffold --name <nome_do_modulo>
      fscaffold -n <nome_do_modulo>

    Opções:
    ${parser.usage}

    Exemplos:
      fscaffold --name user
      fscaffold -n product
      fscaffold -n shopping_cart
    ''');
  }

  String _toPascalCase(String text) {
    if (text.isEmpty) return text;
    return text.split('_').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join();
  }

  String _toCamelCase(String text) {
    final pascal = _toPascalCase(text);
    if (pascal.isEmpty) return pascal;
    return pascal[0].toLowerCase() + pascal.substring(1);
  }

  String _toSnakeCase(String text) {
    return text.toLowerCase().replaceAll(' ', '_');
  }

  void _createDirectory(String path) {
    final directory = Directory(path);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      print('📁 Criado diretório: $path');
    }
  }

  void _writeFile(String filePath, String content) {
    final file = File(filePath);
    file.writeAsStringSync(content);
    print('📄 Criado: $filePath');
  }

  void _generateModel(
      String modelsPath, String pascalCaseName, String snakeCaseName) {
    final content = '''
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

    _writeFile('$modelsPath/${snakeCaseName}_model.dart', content);
  }

  void _generateRepository(String repositoriesPath, String pascalCaseName,
      String camelCaseName, String snakeCaseName) {
    // Interface
    final interfaceContent = '''
import '../models/${snakeCaseName}_model.dart';

abstract class I${pascalCaseName}Repository {
  Future<${pascalCaseName}Model> get${pascalCaseName}(String id);
  Future<List<${pascalCaseName}Model>> getAll${pascalCaseName}s();
  Future<void> save${pascalCaseName}(${pascalCaseName}Model ${camelCaseName});
}
''';

    // Implementação
    final implContent = '''
import '${snakeCaseName}_repository.dart';
import '../models/${snakeCaseName}_model.dart';
import '../services/${snakeCaseName}_service.dart';

class ${pascalCaseName}Repository implements I${pascalCaseName}Repository {
  final I${pascalCaseName}Service ${camelCaseName}Service;

  ${pascalCaseName}Repository(this.${camelCaseName}Service);

  @override
  Future<${pascalCaseName}Model> get${pascalCaseName}(String id) async {
    // TODO: Implementar lógica de busca
    throw UnimplementedError();
  }

  @override
  Future<List<${pascalCaseName}Model>> getAll${pascalCaseName}s() async {
    // TODO: Implementar lógica de listagem
    throw UnimplementedError();
  }

  @override
  Future<void> save${pascalCaseName}(${pascalCaseName}Model ${camelCaseName}) async {
    // TODO: Implementar lógica de salvamento
    throw UnimplementedError();
  }
}
''';

    _writeFile(
        '$repositoriesPath/${snakeCaseName}_repository.dart', interfaceContent);
    _writeFile(
        '$repositoriesPath/${snakeCaseName}_repository_impl.dart', implContent);
  }

  void _generateService(String servicesPath, String pascalCaseName,
      String camelCaseName, String snakeCaseName) {
    // Interface
    final interfaceContent = '''
import '../models/${snakeCaseName}_model.dart';

abstract class I${pascalCaseName}Service {
  Future<${pascalCaseName}Model> fetch${pascalCaseName}(String id);
  Future<List<${pascalCaseName}Model>> fetchAll${pascalCaseName}s();
}
''';

    // Implementação
    final implContent = '''
import '${snakeCaseName}_service.dart';
import '../models/${snakeCaseName}_model.dart';

class ${pascalCaseName}Service implements I${pascalCaseName}Service {
  @override
  Future<${pascalCaseName}Model> fetch${pascalCaseName}(String id) async {
    // TODO: Implementar chamada API ou acesso local
    throw UnimplementedError();
  }

  @override
  Future<List<${pascalCaseName}Model>> fetchAll${pascalCaseName}s() async {
    // TODO: Implementar chamada API ou acesso local
    throw UnimplementedError();
  }
}
''';

    _writeFile('$servicesPath/${snakeCaseName}_service.dart', interfaceContent);
    _writeFile('$servicesPath/${snakeCaseName}_service_impl.dart', implContent);
  }

  void _generateStore(String modulesPath, String pascalCaseName,
      String camelCaseName, String snakeCaseName) {
    final content = '''
import 'package:mobx/mobx.dart';
import '../../models/${snakeCaseName}_model.dart';
import '../../repositories/${snakeCaseName}_repository.dart';

part '${snakeCaseName}_store.g.dart';

class ${pascalCaseName}Store = _${pascalCaseName}StoreBase with _\$${pascalCaseName}Store;

abstract class _${pascalCaseName}StoreBase with Store {
  final I${pascalCaseName}Repository ${camelCaseName}Repository;

  _${pascalCaseName}StoreBase(this.${camelCaseName}Repository);

  @observable
  ObservableList<${pascalCaseName}Model> ${camelCaseName}List = ObservableList<${pascalCaseName}Model>();

  @observable
  ${pascalCaseName}Model? selected${pascalCaseName};

  @observable
  bool isLoading = false;

  @action
  Future<void> loadAll${pascalCaseName}s() async {
    isLoading = true;
    try {
      final list = await ${camelCaseName}Repository.getAll${pascalCaseName}s();
      ${camelCaseName}List.clear();
      ${camelCaseName}List.addAll(list);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> load${pascalCaseName}(String id) async {
    isLoading = true;
    try {
      selected${pascalCaseName} = await ${camelCaseName}Repository.get${pascalCaseName}(id);
    } finally {
      isLoading = false;
    }
  }
}
''';

    _writeFile('$modulesPath/${snakeCaseName}_store.dart', content);
  }

  void _generatePage(String modulesPath, String pascalCaseName,
      String camelCaseName, String snakeCaseName) {
    final content = '''
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '${snakeCaseName}_store.dart';

class ${pascalCaseName}Page extends StatefulWidget {
  const ${pascalCaseName}Page({Key? key}) : super(key: key);

  @override
  State<${pascalCaseName}Page> createState() => _${pascalCaseName}PageState();
}

class _${pascalCaseName}PageState extends State<${pascalCaseName}Page> {
  final ${pascalCaseName}Store store = Modular.get<${pascalCaseName}Store>();

  @override
  void initState() {
    super.initState();
    store.loadAll${pascalCaseName}s();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${pascalCaseName}'),
      ),
      body: Observer(
        builder: (context) {
          if (store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return ListView.builder(
            itemCount: store.${camelCaseName}List.length,
            itemBuilder: (context, index) {
              final item = store.${camelCaseName}List[index];
              return ListTile(
                title: Text(item.id),
                onTap: () => store.load${pascalCaseName}(item.id),
              );
            },
          );
        },
      ),
    );
  }
}
''';

    _writeFile('$modulesPath/${snakeCaseName}_page.dart', content);
  }

  void _generateModule(
      String modulesPath, String pascalCaseName, String snakeCaseName) {
    final content = '''
import 'package:flutter_modular/flutter_modular.dart';
import '${snakeCaseName}_page.dart';
import '${snakeCaseName}_store.dart';
import '../../repositories/${snakeCaseName}_repository.dart';
import '../../repositories/${snakeCaseName}_repository_impl.dart';
import '../../services/${snakeCaseName}_service.dart';
import '../../services/${snakeCaseName}_service_impl.dart';

class ${pascalCaseName}Module extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<I${pascalCaseName}Service>((i) => ${pascalCaseName}Service()),
        Bind.lazySingleton<I${pascalCaseName}Repository>((i) => ${pascalCaseName}Repository(i())),
        Bind.lazySingleton((i) => ${pascalCaseName}Store(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const ${pascalCaseName}Page(),
        ),
      ];
}
''';

    _writeFile('$modulesPath/${snakeCaseName}_module.dart', content);
  }

  void _generateScaffold(String moduleName) {
    final pascalCaseName = _toPascalCase(moduleName);
    final camelCaseName = _toCamelCase(moduleName);
    final snakeCaseName = _toSnakeCase(moduleName);

    print('🚀 Gerando scaffold para: $pascalCaseName...\n');

    // Define paths relativos ao diretório atual
    final basePath = 'lib/app';
    final modulesPath = '$basePath/modules/${snakeCaseName}_module';
    final modelsPath = '$basePath/models';
    final repositoriesPath = '$basePath/repositories';
    final servicesPath = '$basePath/services';

    // Cria os diretórios
    _createDirectory(modulesPath);
    _createDirectory(modelsPath);
    _createDirectory(repositoriesPath);
    _createDirectory(servicesPath);

    // Gera arquivos
    _generateModel(modelsPath, pascalCaseName, snakeCaseName);
    _generateRepository(
        repositoriesPath, pascalCaseName, camelCaseName, snakeCaseName);
    _generateService(
        servicesPath, pascalCaseName, camelCaseName, snakeCaseName);
    _generateStore(modulesPath, pascalCaseName, camelCaseName, snakeCaseName);
    _generatePage(modulesPath, pascalCaseName, camelCaseName, snakeCaseName);
    _generateModule(modulesPath, pascalCaseName, snakeCaseName);

    print('\n✅ Scaffold do módulo "$pascalCaseName" criado com sucesso!');
    print('📁 Estrutura criada em: $modulesPath');
    print('\n📋 Próximos passos:');
    print('   1. Adicione o módulo ao seu AppModule:');
    print(
        '      ModuleRoute(\'/$snakeCaseName\', module: ${pascalCaseName}Module()),');
    print('   2. Execute: flutter pub run build_runner watch');
    print(
        '   3. Execute: flutter pub run build_runner build --delete-conflicting-outputs');
  }

  try {
    final results = parser.parse(args);

    if (results['help'] as bool) {
      _showHelp(parser);
      return;
    }

    if (results['version'] as bool) {
      print('Flutter Scaffold CLI v1.0.0');
      return;
    }

    final featureName = results['name'] as String;

    _generateScaffold(featureName);
  } on FormatException catch (e) {
    print('Erro: ${e.message}');
    _showHelp(parser);
    exit(1);
  }
}
