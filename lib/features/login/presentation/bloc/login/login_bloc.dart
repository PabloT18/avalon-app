import 'dart:async';

import 'package:avalon_app/features/shared/functions/fun_logic.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'
    show TextEditingController, GlobalKey, FormState, FocusNode;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authenticationRepository) : super(const LoginInitial()) {
    on<LogIn>(_onLogIn);
    on<VerifyTwoFactorCode>(_onVerifyTwoFactorCode);
    on<ChangePasswordEvent>(_onChangePassword);
    on<ForgotPasswordIn>(_onForgotPasswordIn);
    on<ForgotPasswordVerify>(_onForgotPasswordVerify);

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

  Map<String, dynamic>? _responseTemp;
  FutureOr<void> _onLogIn(LogIn event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());

    if (formKey.currentState!.validate()) {
      try {
        _responseTemp =
            await _authenticationRepository.logInWithEmailAndPassword(
          usuario: _txtControllerCorreo.text,
          password: _txtControllerContrasena.text,
        );

        // // emit(const LoginSucces('Inicio Correcto'));
        // emit(const LoginTwoFactorRequired(
        //     "Código enviado. Ingresa tu código 2FA"));

        // Verifica el asunto de la respuesta
        final asunto = _responseTemp?['asunto'];

        if (asunto == "CAMBIO_CONTRASENIA") {
          // _tempToken = _responseTemp?['token'];
          emit(const LoginPasswordChangeRequired("Debe cambiar su contraseña"));
        } else if (asunto == "LOGIN_EXITOSO_2FA") {
          // _tempToken = _responseTemp?['token'];
          emit(const LoginTwoFactorRequired(
              "Código enviado. Ingresa tu código 2FA"));
        } else {
          emit(const LoginError("Asunto inesperado en la autenticación"));
        }
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

  Future<void> _onVerifyTwoFactorCode(
      VerifyTwoFactorCode event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());

    try {
      await _authenticationRepository.verifyTwoFactorCode(
        usuario: _txtControllerCorreo.text,
        codigo: event.codigo,
        token: _responseTemp!['token'],
        userId: _responseTemp!['id'].toString(),
      );
      //TODO: refat
      emit(const LoginSucces('Inicio Correcto'));
      // emit(const LoginError("Inicio Correcto"));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(LoginError(e.message));
    } catch (_) {
      emit(const LoginError('Error al iniciar sesión'));
      _txtControllerContrasena.clear();
    }
  }

  FutureOr<void> _onChangePassword(
      ChangePasswordEvent event, Emitter<LoginState> emit) async {
    try {
      await _authenticationRepository.changePassword(
        usuario: _txtControllerCorreo.text,
        contraseniaActual: event.currentPassword,
        contraseniaNueva: event.newPassword,
        token: _responseTemp!['token'],
      );
      emit(LoginMessage(apptexts.appOptions.passwordChanged));
    } catch (e) {
      emit(LoginError(apptexts.appOptions.passwordChangedError));
    }
  }

  String? validateContrasena(String? nombre) =>
      UtilsFunctionsLogic.validateDataNull(nombre, "Password can not be empty");

  String? validateCorreo(String? correo) =>
      UtilsFunctionsLogic.validateDataNull(correo, "UserName can not be empty");

  FutureOr<void> _onForgotPasswordIn(
      ForgotPasswordIn event, Emitter<LoginState> emit) {
    emit(const LoginInitial());
    emit(const LoginPasswordForgotRequest());
  }

  FutureOr<void> _onForgotPasswordVerify(
      ForgotPasswordVerify event, Emitter<LoginState> emit) {}
}
