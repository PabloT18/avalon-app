import 'dart:async';

import 'package:alumni_app/features/shared/functions/fun_logic.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'
    show TextEditingController, GlobalKey, FormState, FocusNode;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authenticationRepository) : super(const LoginInitial()) {
    on<LogIn>(_onLogIn);

    _txtControllerContrasena = TextEditingController();
    _txtControllerCorreo = TextEditingController();

    _focusNodeContrasena = FocusNode();
    _focusNodeCorreo = FocusNode();
  }

  final AuthenticationRepository _authenticationRepository;

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

    if (formKey.currentState!.validate()) {
      try {
        await _authenticationRepository.logInWithEmailAndPassword(
          usuario: _txtControllerCorreo.text,
          password: _txtControllerContrasena.text,
        );

        emit(const LoginSucces('Inicio Correcto'));
      } on LogInWithEmailAndPasswordFailure catch (e) {
        emit(LoginError(e.message));
      } catch (_) {
        emit(const LoginError('Error al iniciar sesión'));
        _txtControllerContrasena.clear();
      }
    } else {
      emit(const LoginInitial());
    }
  }

  String? validateContrasena(String? nombre) =>
      UtilsFunctionsLogic.validateDataNull(nombre, "Password can not be empty");

  String? validateCorreo(String? correo) =>
      UtilsFunctionsLogic.validateDataNull(correo, "UserName can not be empty");
}
