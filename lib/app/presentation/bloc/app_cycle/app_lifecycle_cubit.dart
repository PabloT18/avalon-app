import 'package:flutter/material.dart' show AppLifecycleState;
export 'package:flutter/material.dart' show AppLifecycleState;

import 'package:flutter_bloc/flutter_bloc.dart';

class AppLifeCubit extends Cubit<AppLifecycleState> {
  AppLifeCubit() : super(AppLifecycleState.resumed);

  void changeState(AppLifecycleState state) {
    emit(state);
  }
}
