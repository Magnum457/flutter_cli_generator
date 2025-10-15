import 'dart:io';

class DependecyUtils {
  static final Map<String, String> dependencies = {
    'dio': '^5.3.2',
    'flutter_mobx': '^2.0.6+5',
    'flutter_modular': '^5.0.3',
    'json_annotation': '^4.9.0',
    'mobx': '^2.2.0',
  };

  static final Map<String, String> devDependencies = {
    'build_runner': '^2.4.6',
    'json_serializable': '^6.8.0',
    'mobx_codegen': '^2.3.0',
    'test': '^1.16.9',
  };

  static bool addDependencies() {
    final file = File('pubspec.yaml');
    if (!file.existsSync()) return false;

    final content = file.readAsStringSync();
    String newContent = content;
    bool needsUpdate = false;

    // Adiciona as dependencias
    for (var dep in dependencies.entries) {
      if (!content.contains('${dep.key}:')) {
        newContent = newContent.replaceFirst(
          'dependencies:',
          'dependencies:\n  ${dep.key}: ${dep.value}\n',
        );
        needsUpdate = true;
      }
    }

    // Adiciona as dev dependencies
    for (var dep in devDependencies.entries) {
      if (!content.contains('${dep.key}:')) {
        newContent = newContent.replaceFirst(
          'dev_dependencies:',
          'dev_dependencies:\n  ${dep.key}: ${dep.value}\n',
        );
        needsUpdate = true;
      }
    }

    if (needsUpdate) {
      file.writeAsStringSync(newContent);
      return true;
    }

    return false;
  }
}
