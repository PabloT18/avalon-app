part of 'app_settings_cubit.dart';

enum AppThemeMode { dark, light }

class AppSettingsState extends Equatable {
  const AppSettingsState({
    // required ThemeMode themeMode,
    required AppLocale appLocale,
  }) : _appLocale = appLocale;

  // final ThemeMode _themeMode;
  final AppLocale _appLocale;

  AppSettingsState copyWith({
    // ThemeMode? themeMode,
    AppLocale? appLocale,
  }) =>
      AppSettingsState(
        // themeMode: themeMode ?? _themeMode,
        appLocale: appLocale ?? _appLocale,
      );

  // ThemeMode get themeMode => _themeMode;

  // bool get isDarkTheme => themeMode == ThemeMode.dark;

  AppLocale get appLocale => _appLocale;

  @override
  List<Object> get props => [
        _appLocale,
      ];
}
