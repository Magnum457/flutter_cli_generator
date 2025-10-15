class NameUtils {
  static String toPascalCase(String text) {
    if (text.isEmpty) return text;
    return text.split('_').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join();
  }

  static String toCamelCase(String text) {
    final pascal = toPascalCase(text);
    if (pascal.isEmpty) return pascal;
    return pascal[0].toLowerCase() + pascal.substring(1);
  }

  static String toSnakeCase(String text) {
    return text.toLowerCase().replaceAll(' ', '_');
  }
}
