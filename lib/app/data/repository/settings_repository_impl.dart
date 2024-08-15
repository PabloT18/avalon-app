import 'package:avalon_app/core/error/erros.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:cache/cache.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/settings_repository.dart';

///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsRepositoryImpl implements SettingsRepository {
  /// Loads the User's preferred ThemeMode from local   storage.

  final CacheClient _cache = CacheClient();

  // static const _indexThemeData = ConstHiveBox.kSettingsThemeData;
  static const String _indexLanguage = ConstHiveBox.kSettingsLanguage;

  @override
  AppLocale get appLocal => AppLocaleUtils.parse(getLanguage());

  String getLanguage() {
    final languageCode = _cache.read(key: _indexLanguage);
    if (languageCode == null) return 'es';
    return languageCode;
  }

  /// Persists the user's preferred Language to local storage.
  @override
  Future<Either<Failure, AppLocale>> updateLanguage(AppLocale appLocale) async {
    // Use the shared_preferences package to persist settings locally or the
    try {
      await _cache.write(key: _indexLanguage, value: appLocale.languageCode);
      return (Right(appLocale));
    } catch (e) {
      return const Left(CacheFailure());
    }
  }
}
