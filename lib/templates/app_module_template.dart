class AppModuleTemplate {
  static const String appModule = '''
    import 'package:flutter_modular/flutter_modular.dart';
    import 'core/core_module.dart';

    class AppModule extends Module {
      @override
      List<Module> get imports => [
        CoreModule(),
      ];

      @override
      List<Bind> get binds => [];

      @override
      List<ModularRoute> get routes => [];
    }
''';
}
