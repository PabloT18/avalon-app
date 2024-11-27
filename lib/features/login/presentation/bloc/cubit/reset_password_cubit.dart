import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:avalon_app/features/shared/functions/fun_logic.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._authenticationRepository)
      : super(const ResetPasswordInitial()) {
    correoController = TextEditingController();
    codigoF2AController = TextEditingController();
    newPasswordController = TextEditingController();
    repeatPasswordController = TextEditingController();
  }

  final AuthenticationRepository _authenticationRepository;

  late TextEditingController correoController;
  late TextEditingController codigoF2AController;
  late TextEditingController newPasswordController;
  late TextEditingController repeatPasswordController;

  final GlobalKey<FormState> formEmailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formChangePswKey = GlobalKey<FormState>();

  void testBack() {
    emit(const ResetPasswordInitial());
  }

  @override
  Future<void> close() {
    correoController.clear();
    codigoF2AController.clear();
    newPasswordController.clear();
    repeatPasswordController.clear();
    return super.close();
  }

  void reqeuestEmailValidation() async {
    emit(const ResetPasswordInitial(isLoading: true));

    if (formEmailKey.currentState!.validate()) {
      try {
        await _authenticationRepository.requesResetPsw(correoController.text);
        emit(const ResetPasswordDataReques());
      } on LogInWithEmailAndPasswordFailure catch (e) {
        emit(ResetPasswordInitial(isLoading: false, error: e.message));
      }
    } else {
      emit(const ResetPasswordInitial(
        isLoading: false,
      ));
    }
  }

  void requestNewPassword() async {
    emit(const ResetPasswordDataReques(isLoading: true));
    if (formChangePswKey.currentState!.validate()) {
      try {
        await _authenticationRepository.restartPassword(
          correoController.text,
          codigoF2AController.text,
          newPasswordController.text,
        );
        emit(const ResetPasswordsucces());
      } on LogInWithEmailAndPasswordFailure catch (e) {
        emit(ResetPasswordDataReques(isLoading: false, error: e.message));
      }
    } else {
      emit(const ResetPasswordDataReques(isLoading: false));
    }
  }

  ///// validators
  ///
  String? validateEmpty(String? data) => UtilsFunctionsLogic.validateDataNull(
      data, apptexts.appOptions.validators.requiredField);
  String? validateCorreo(String? correo) => UtilsFunctionsLogic.validateCorreo(
      correo, apptexts.appOptions.notEmptyCorreo,
      correoInsMsg: apptexts.appOptions.notValidCorreo);

  String? validateContrasena(String? password, {String? confirmPassword}) {
    if (password == null || password.isEmpty) {
      return apptexts.appOptions.notEmptyPassword;
    }

    if (confirmPassword != null && password != confirmPassword) {
      return apptexts.appOptions.passwordNotMatch;
    }
    final passwordRegExp =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$');

    if (!passwordRegExp.hasMatch(password)) {
      return apptexts.appOptions.passwordDebil;
    }
    return null; // Sin errores
  }
}
