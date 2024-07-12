import 'package:hive_flutter/hive_flutter.dart';

import 'constant_keys_cahce.dart';

class CacheInitializer {
  static Future<void> initialize() async {
    await Hive.initFlutter();
    // Aquí podrías abrir las cajas necesarias o registrar adaptadores
    await Hive.openBox(ConstHiveBox.kHiveBoxName);
  }
}
