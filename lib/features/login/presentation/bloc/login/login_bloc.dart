import 'dart:async';

import 'package:alumni_app/features/shared/functions/fun_logic.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'
    show TextEditingController, GlobalKey, FormState, FocusNode;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LogIn>(_onLogIn);

    _txtControllerContrasena = TextEditingController();
    _txtControllerCorreo = TextEditingController();

    _focusNodeContrasena = FocusNode();
    _focusNodeCorreo = FocusNode();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _txtControllerContrasena;
  late TextEditingController _txtControllerCorreo;

  late FocusNode _focusNodeContrasena;
  late FocusNode _focusNodeCorreo;

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get txtControllerContrasena => _txtControllerContrasena;
  TextEditingController get txtControllerCorreo => _txtControllerCorreo;

  FocusNode get focusNodeContrasena => _focusNodeContrasena;
  FocusNode get focusNodeCorreo => _focusNodeCorreo;

  FutureOr<void> _onLogIn(LogIn event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());
    // if (formKey.currentState!.validate()) {
    ///TODO: validate fix
    if (formKey.currentState!.validate()) {
      print(_txtControllerCorreo.text);
      print(_txtControllerContrasena.text);

      // int randomChoice = Random().nextInt(2);
      int randomChoice = 1;

      await Future.delayed(const Duration(milliseconds: 2500));
      if (randomChoice == 0) {
        emit(const LoginError('Error al iniciar sesión'));
      } else {
        emit(LoginSucces(_txtControllerCorreo.text));
        // _txtControllerCorreo.clear();
        // _txtControllerContrasena.clear();
        // _txtControllerNombre.text = nombre ?? '';
        // _txtControllerCorreo.text = correo ?? '';

        // _txtControllerMensaje.clear();
      }
    } else {
      emit(const LoginInitial());

      print("Existe error");
    }
  }

  String? validateContrasena(String? nombre) =>
      UtilsFunctionsLogic.validateDataNull(nombre, "Contraseña no ser vacia");

  String? validateCorreo(String? correo) =>
      UtilsFunctionsLogic.validateCorreo(correo, "Correo no ser vacio",
          correoInsMsg: "Correo Invalido");
}
