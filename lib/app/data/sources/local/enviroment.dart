import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static bool appProd = dotenv.env['APP_PRO'] == 'true';

  static String pathAPIProd = dotenv.env['AVALON_SERVER_API_PRO'] ??
      'No hay URL de Servidor de produccion';
  static String pathAPIDev = dotenv.env['AVALON_SERVER_API_DEV'] ??
      'No hay URL de Servidor de Desarrollo';

  static String avalonApi = appProd ? pathAPIProd : pathAPIDev;
}
