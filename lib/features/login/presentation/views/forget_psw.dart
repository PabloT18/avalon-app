import 'dart:async';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/features/login/presentation/bloc/login/login_bloc.dart';
import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/reset_password_cubit.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
    required this.loginBloc,
  });

  final LoginBloc loginBloc;
  @override
  Widget build(BuildContext context) {
    final resetPasswordCubit = context.read<ResetPasswordCubit>();
    return AlertDialog(
      title: Text(apptexts.appOptions.restartPassword),
      content: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordsucces) {
            Navigator.of(context).pop();
          }
          if (state.error != null) {
            UtilsFunctionsViews.showFlushBar(
              message: state.error!,
              isError: true,
            ).show(context);
          }
        },
        child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
          builder: (context, state) {
            switch (state) {
              case ResetPasswordInitial():
                return const SetEmailToChange();
              case ResetPasswordDataReques():
                return const SetNewPassword();

              default:
                return const SizedBox();
            }
          },
        ),
      ),
      actions: [
        BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
            builder: (context, state) {
          return TextButton(
            onPressed: state.isLoading
                ? null
                : () {
                    FocusScope.of(context).unfocus();

                    Navigator.of(context).pop();
                  },
            child: Text(apptexts.appOptions.cancelar),
          );
        }),
        BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
          builder: (context, state) {
            return TextButton(
              onPressed: state.isLoading
                  ? null
                  : () {
                      FocusScope.of(context).unfocus();
                      if (resetPasswordCubit.state is ResetPasswordInitial) {
                        resetPasswordCubit.reqeuestEmailValidation();
                      } else {
                        resetPasswordCubit.requestNewPassword();
                      }

                      // final currentPassword = currentPasswordController.text;
                      // final newPassword = newPasswordController.text;
                      // final repeatPassword = repeatPasswordController.text;

                      // if (_validatePasswords(context, newPassword, repeatPassword)) {
                      //   loginBloc.add(
                      //     ChangePasswordEvent(currentPassword, newPassword),
                      //   );
                      //   Navigator.of(context).pop();
                      // }
                    },
              child: Text(apptexts.appOptions.continuar),
            );
          },
        ),
      ],
    );
  }
}

class SetEmailToChange extends StatelessWidget {
  const SetEmailToChange({super.key});

  @override
  Widget build(BuildContext context) {
    final resetPasswordCubit = context.read<ResetPasswordCubit>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
          builder: (context, state) {
            return Form(
              key: resetPasswordCubit.formEmailKey,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: resetPasswordCubit.correoController,
                validator: resetPasswordCubit.validateCorreo,
                textCapitalization: TextCapitalization.none,
                enabled: !state.isLoading,
                decoration: UtilsFunctionsViews.buildInputDecoration(
                  label: apptexts.appOptions.ingreseCorre,
                  hint: 'jperez@mail.com',
                  icon: Icons.mail,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SetNewPassword extends StatelessWidget {
  const SetNewPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final resetPasswordCubit = context.read<ResetPasswordCubit>();

    return Form(
      key: resetPasswordCubit.formChangePswKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: resetPasswordCubit.codigoF2AController,
              keyboardType: TextInputType.number,
              validator: resetPasswordCubit.validateEmpty,
              decoration: InputDecoration(
                labelText: apptexts.appOptions.ingresarCode,
              ),
              // obscureText: true,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppLayoutConst.paddingM,
                ).copyWith(top: AppLayoutConst.paddingM),
                child: Text(
                  apptexts.appOptions.verificarText,
                  style: Theme.of(context).textTheme.bodySmall,
                )),
            const SizedBox(
              height: AppLayoutConst.spaceL,
            ),
            PasswordFieldController(
              controller: resetPasswordCubit.newPasswordController,
              validator: resetPasswordCubit.validateContrasena,
              label: apptexts.appOptions.newPassword,
            ),
            const SizedBox(
              height: AppLayoutConst.spaceL,
            ),
            PasswordFieldController(
              controller: resetPasswordCubit.repeatPasswordController,
              label: apptexts.appOptions.confirmPassword,
              validator: (value) => resetPasswordCubit.validateContrasena(
                value,
                confirmPassword: resetPasswordCubit.newPasswordController.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordFieldController extends StatefulWidget {
  const PasswordFieldController({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  @override
  State<PasswordFieldController> createState() =>
      _PasswordFieldStateController();
}

class _PasswordFieldStateController extends State<PasswordFieldController> {
  bool _isPasswordVisible = false;
  Timer? _visibilityTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _visibilityTimer?.cancel();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
    if (_isPasswordVisible) {
      // Si la contraseña es visible, comienza un temporizador para ocultarla después de un tiempo
      _visibilityTimer
          ?.cancel(); // Cancela cualquier temporizador anterior si existe
      _visibilityTimer = Timer(const Duration(seconds: 3), () {
        // Oculta la contraseña después de 5 segundos
        setState(() {
          _isPasswordVisible = false;
        });
      });
    } else {
      // Si la contraseña se va a ocultar, no es necesario un temporizador
      _visibilityTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_isPasswordVisible,
      textCapitalization: TextCapitalization.none,
      validator: widget.validator,
      controller: widget.controller,
      decoration: UtilsFunctionsViews.buildInputDecoration(
        label: widget.label,

        hint: '****',
        // icon: Icons.lock,
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: _isPasswordVisible ? Colors.black : null,
          ),
          onPressed:
              _togglePasswordVisibility, // Cambia el estado de visibilidad cuando se presiona
        ),
      ),
    );
  }
}
