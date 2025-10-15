import 'dart:io';

class FileUtils {
  static void createDirectory(String path) {
    final directory = Directory(path);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      print('📁 Criado diretório: $path');
    }
  }

  static void writeFile(String filePath, String content) {
    final file = File(filePath);
    file.writeAsStringSync(content);
    print('📄 Criado arquivo: $filePath');
  }

  static bool fileExists(String path) {
    return File(path).existsSync();
  }
}
