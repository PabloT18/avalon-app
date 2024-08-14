import 'package:avalon_app/core/error/erros.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart' show ThemeMode;

import '../../domain/repository/settings_repository.dart';
import '../sources/local/settings_local_source.dart';

///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsRepositoryImpl implements SettingsRepository {
  /// Loads the User's preferred ThemeMode from local   storage.

  /// Persists the user's preferred ThemeMode to local storage.
  // @override
  // Future<Either<Failure, bool>> updateThemeMode(bool isDarkTheme) async {
  //   // Use the shared_preferences package to persist settings locally or the
  //   try {
  //     await SettingsLocalSource.saveThemeDark(isDarkTheme);
  //     return (const Right(true));
  //   } catch (e) {
  //     return const Left(CacheFailure());
  //   }
  // }

  /// Loads the User's preferred Language from local   storage.

  @override
  AppLocale get appLocal => AppLocale.en;
  // AppLocaleUtils.parse(SettingsLocalSource.getLanguage());

  /// Persists the user's preferred Language to local storage.
  @override
  Future<Either<Failure, AppLocale>> updateLanguage(AppLocale appLocale) async {
    // Use the shared_preferences package to persist settings locally or the
    try {
      await SettingsLocalSource.saveLanguage(appLocale.languageCode);
      return (Right(appLocale));
    } catch (e) {
      return const Left(CacheFailure());
    }
  }
}
