import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.light));

  void updateTheme() {
    SystemChrome.setSystemUIOverlayStyle(state.isDarkTheme
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light);

    emit(ThemeState(
      themeMode: state.isDarkTheme ? ThemeMode.light : ThemeMode.dark,
    ));
  }
}
