import 'package:avalon_app/core/error/erros.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:dartz/dartz.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
abstract class SettingsRepository {
  /// Loads the User's preferred ThemeMode from local storage.
  // AppThemeMode themeMode();
  // ThemeMode get themeMode;

  /// Persists the user's preferred ThemeMode to local  storage.
  // Future<Either<Failure, bool>> updateThemeMode(bool darkTheme);

  /// Loads the User's preferred Language from local storage.
  // AppThemeMode themeMode();
  AppLocale get appLocal;

  /// Persists the user's preferred ThemeMode to local  storage.
  Future<Either<Failure, AppLocale>> updateLanguage(AppLocale appLocale);
}
