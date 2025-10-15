#!/usr/bin/env dart

import 'package:args/args.dart';
import '../lib/commands/init_command.dart';
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
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Ajuda',
    );

  void showHelp() {
    print('''
      Flutter Scaffold CLI

      Uso:
      fscaffold [opções]

      Opções:
      -n, --name <nome>   Nome do módulo a ser criado
      -i, --init          Inicializa as dependências do projeto
      -h, --help          Ajuda
      ''');
  }

  try {
    final results = parser.parse(args);

    if (results['help'] as bool) {
      showHelp();
      return;
    }

    if (results['version'] as bool) {
      print('Flutter Scaffold CLI v1.0.0');
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

    if (!hasCommand) {
      showHelp();
    }
  } on FormatException catch (e) {
    print('Erro: ${e.message}');
    showHelp();
  }
}
