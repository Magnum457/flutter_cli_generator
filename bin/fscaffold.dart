#!/usr/bin/env dart

import 'package:args/args.dart';
import '../lib/commands/init_command.dart';
import '../lib/commands/config_command.dart';
import '../lib/commands/scaffold_command.dart';

void main(List<String> args) {
  final parser = ArgParser()
    ..addOption(
      'name',
      abbr: 'n',
      help: 'Nome do módulo a ser criado',
    )
    ..addFlag(
      'init',
      abbr: 'i',
      negatable: false,
      help: 'Inicializa as dependências do projeto',
    )
    ..addFlag(
      'config',
      abbr: 'c',
      negatable: false,
      help: 'Configura a infraestrutura do projeto',
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
      help: 'Exibe a versão do CLI',
    );

  void showHelp() {
    print('''
      Flutter Scaffold CLI

      Uso:
      fscaffold [opções]

      Opções:
      -n, --name <nome>   Nome do módulo a ser criado
      -i, --init          Inicializa as dependências do projeto
      -c, --config        Configura a infraestrutura do projeto
      -h, --help          Ajuda
      ''');
  }

  try {
    final results = parser.parse(args);

    if (results.wasParsed('help')) {
      showHelp();
      return;
    }

    if (results.wasParsed('version')) {
      print('Flutter Scaffold CLI v0.1.0');
      return;
    }

    // Verifica se está em um projeto Flutter
    if (!InitCommand().isFlutterProject()) {
      print(
          '❌ O diretório atual não parece ser um projeto Flutter. (pubspec.yaml não encontrado)');
      return;
    }

    bool hasCommand = false;

    if (results['init'] as bool) {
      InitCommand().execute();
      hasCommand = true;
    }

    if (results['config'] as bool) {
      ConfigCommand().execute();
      hasCommand = true;
    }

    if (results.wasParsed('name')) {
      final moduleName = results['name'] as String;
      ScaffoldCommand().execute(moduleName);
      hasCommand = true;
    }

    if (!hasCommand) {
      showHelp();
    }
  } on FormatException catch (e) {
    print('Erro: ${e.message}');
    showHelp();
  }
}
