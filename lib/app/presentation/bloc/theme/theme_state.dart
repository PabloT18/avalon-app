part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState({
    required ThemeMode themeMode,
  }) : _themeMode = themeMode;

  final ThemeMode _themeMode;

  ThemeState copyWith({
    ThemeMode? themeMode,
  }) =>
      ThemeState(
        themeMode: themeMode ?? _themeMode,
      );

  ThemeMode get themeMode => _themeMode;

  bool get isDarkTheme => themeMode == ThemeMode.dark;

  @override
  List<Object> get props => [
        _themeMode,
      ];
}
