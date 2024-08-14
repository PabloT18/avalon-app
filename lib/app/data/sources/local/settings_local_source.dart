import 'package:cache/constant_keys_cahce.dart';
import 'package:hive/hive.dart';

/// CRUD [SettingsLocalSource]
class SettingsLocalSource {
  const SettingsLocalSource();

  static Box _getBox() => Hive.box(ConstHiveBox.kHiveBoxName);

  static const _indexThemeData = ConstHiveBox.kSettingsThemeData;
  static const _indexLanguage = ConstHiveBox.kSettingsLanguage;

  /// CRUD [indexThemeData]
  static Future<void> saveThemeDark(bool themeDark) async {
    Box box = _getBox();

    return await box.put(_indexThemeData, themeDark);
  }

  static bool getThemeDark() {
    Box box = _getBox();
    final theme = box.get(_indexThemeData);
    if (theme == null) return false;

    return theme;
  }

  static Future<void> deleteTheme() async {
    Box box = _getBox();
    await box.delete(_indexThemeData);
  }

  /// CRUD [indexLanguage]
  static Future<void> saveLanguage(String languageCode) async {
    Box box = _getBox();

    return await box.put(_indexLanguage, languageCode);
  }

  static String getLanguage() {
    Box box = _getBox();

    final languageCode = box.get(_indexLanguage);
    if (languageCode == null) return 'es';
    return languageCode;
  }

  static Future<void> deleteLanguage() async {
    Box box = _getBox();
    await box.delete(_indexLanguage);
  }
}
