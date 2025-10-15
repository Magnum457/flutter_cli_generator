import 'dart:io';

import '../utils/file_utils.dart';
import '../utils/dependency_utils.dart';

class InitCommand {
  bool isFlutterProject() {
    return FileUtils.fileExists('pubspec.yaml');
  }

  Future<void> execute() async {
    print('🚀 Inicializando dependências...');

    final needsUpdate = DependecyUtils.addDependencies();

    if (needsUpdate) {
      print('✅ Dependências adicionadas ao pubspec.yaml');

      // Executa o comando flutter pub get
      print('📦 Baixando dependências...');
      final result = await Process.run('flutter', ['pub', 'get']);
      if (result.exitCode == 0) {
        print('✅ Dependências baixadas com sucesso');
      } else {
        print('❌ Erro ao baixar dependências: ${result.stderr}');
      }
    } else {
      print('✅ Todas as dependências já estão configuradas');
    }
  }
}
