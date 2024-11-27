import 'dart:async';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/features/login/presentation/bloc/login/login_bloc.dart';
import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';

class AlertChangePassword extends StatelessWidget {
  const AlertChangePassword({
    super.key,
    required this.loginBloc,
  });

  final LoginBloc loginBloc;
  @override
  Widget build(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final repeatPasswordController = TextEditingController();
    return AlertDialog(
      title: Text(apptexts.appOptions.changePassword),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: currentPasswordController,
            decoration: InputDecoration(
              labelText: apptexts.appOptions.currentPassword,
            ),
            // obscureText: true,
          ),
          const SizedBox(
            height: AppLayoutConst.spaceL,
          ),
          // TextField(
          //   controller: newPasswordController,
          //   decoration: const InputDecoration(labelText: 'Nueva contraseña'),
          //   obscureText: true,
          // ),
          PasswordFieldController(
            controller: newPasswordController,
            label: apptexts.appOptions.newPassword,
          ),
          const SizedBox(
            height: AppLayoutConst.spaceL,
          ),
          PasswordFieldController(
            controller: repeatPasswordController,
            label: apptexts.appOptions.confirmPassword,
          ),
          // const SizedBox(
          //   height: AppLayoutConst.spaceL,
          // ),
          // TextField(
          //   controller: repeatPasswordController,
          //   decoration:
          //       const InputDecoration(labelText: 'Repetir nueva contraseña'),
          //   obscureText: true,
          // ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(apptexts.appOptions.cancel),
        ),
        TextButton(
          onPressed: () {
            final currentPassword = currentPasswordController.text;
            final newPassword = newPasswordController.text;
            final repeatPassword = repeatPasswordController.text;

            if (_validatePasswords(context, newPassword, repeatPassword)) {
              loginBloc.add(
                ChangePasswordEvent(currentPassword, newPassword),
              );
              Navigator.of(context).pop();
            }
          },
          child: Text(apptexts.appOptions.continuar),
        ),
      ],
    );
  }

  bool _validatePasswords(
      BuildContext context, String newPassword, String repeatPassword) {
    final passwordRegExp =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$');

    if (newPassword != repeatPassword) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Las contraseñas no coinciden")));

      UtilsFunctionsViews.showFlushBar(
        message: apptexts.appOptions.passwordNotMatch,
      ).show(context);
      return false;
    }

    if (!passwordRegExp.hasMatch(newPassword)) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text(
      //       "La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula y un número"),
      // ));
      UtilsFunctionsViews.showFlushBar(
        message: apptexts.appOptions.passwordDebil,
      ).show(context);
      return false;
    }

    return true;
  }
}

class PasswordFieldController extends StatefulWidget {
  const PasswordFieldController({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

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
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_isPasswordVisible,
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
