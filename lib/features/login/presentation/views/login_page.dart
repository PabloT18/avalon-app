import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:avalon_app/app/presentation/bloc/push_notifications/notifications_bloc.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/features/shared/widgets/app_widgets.dart';
// import 'package:authentication_repository/authentication_repository.dart';

import 'package:avalon_app/core/config/router/app_router.dart';

import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:avalon_app/features/shared/widgets/buttons/buttons_custom.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/core/config/router/app_routes_assets.dart';

import '../bloc/login/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(context.read<AuthenticationRepository>()),
      child: const _LoginPageView(),
    );
  }
}

class _LoginPageView extends StatelessWidget {
  const _LoginPageView();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: responsive.hp(5)),
            Hero(
              tag: '__tag_logo__',
              child: Center(
                child: Image(
                  image: const AssetImage(AppAssets.logotipo4),
                  fit: BoxFit.fill,
                  height: responsive.hp(11),
                ),
              ),
            ),
            SizedBox(height: responsive.hp(28)),
            FadeIn(
                delay: const Duration(milliseconds: 500),
                child: _LoginFormComponents(responsive: responsive)),
          ],
        ),
      ),
    );
  }
}

class _LoginFormComponents extends StatelessWidget {
  const _LoginFormComponents({
    required this.responsive,
  });

  final ResponsiveCustom responsive;

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    /// Incio de [NotificationsBloc]
    context.read<NotificationsBloc>().add(const NotificationDellFCM());

    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginTwoFactorRequired) {
        _showVerificacionDialog(context, loginBloc);
      }
      if (state is LoginPasswordChangeRequired) {
        _showChangePasswordDialog(context, loginBloc);
      }
      if (state is LoginSucces) {
        AppRouter.router.go(PAGES.home.pagePath);
        // if (state.message.contains('cliente')) {
        // AppRouter.router.go(PAGES.home.pagePath);

        // } else if (state.message.contains('asesor')) {
        //   AppRouter.router.go(PAGES.home.pagePath);
        // }
      }

      if (state is LoginError) {
        UtilsFunctionsViews.showFlushBar(
          message: state.errorMessage,
          positionOffset: responsive.hp(8),
        ).show(context);
      }
      if (state is LoginMessage) {
        UtilsFunctionsViews.showFlushBar(
          message: state.errorMessage,
          positionOffset: responsive.hp(8),
          isError: false,
        ).show(context);
      }
    }, builder: (context, state) {
      return Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppLayoutConst.spaceL)
                    .copyWith(top: AppLayoutConst.spaceXL),
            child: Form(
              key: loginBloc.formKey,
              child: Column(
                children: [
                  const SizedBox(height: AppLayoutConst.spaceXL),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: loginBloc.txtControllerCorreo,
                    focusNode: loginBloc.focusNodeCorreo,
                    validator: loginBloc.validateCorreo,
                    textCapitalization: TextCapitalization.none,
                    decoration: UtilsFunctionsViews.buildInputDecoration(
                      label: 'Enter your username',
                      hint: 'jperez',
                      icon: Icons.mail,
                    ),
                    onChanged: (_) {},
                    onFieldSubmitted: (term) {
                      loginBloc.focusNodeContrasena.requestFocus();
                    },
                    onEditingComplete: () =>
                        loginBloc.focusNodeCorreo.requestFocus(),
                  ),
                  const SizedBox(height: AppLayoutConst.spaceL),
                  PasswordField(loginBloc: loginBloc),
                  // const SizedBox(height: AppLayoutConst.spaceL),
                ],
              ),
            ),
          ),
          SizedBox(height: responsive.hp(5)),
          if (state is LoginLoading) const CircularProgressIndicatorCustom(),
          if (state is! LoginLoading)
            CustomButton(
              onPressed: () {
                loginBloc.add(const LogIn());
              },
              title: 'LOGIN',
              backgroundColor: Colors.transparent,
              onPrimary: Colors.white,
            ),
          SizedBox(height: responsive.hp(5)),
        ],
      );
    });
  }

  void _showVerificacionDialog(BuildContext context, loginBloc) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController codigoController = TextEditingController();
        return AlertDialog(
          title: Text(apptexts.appOptions.verificationCode),
          content: TextField(
            controller: codigoController,
            decoration:
                InputDecoration(hintText: apptexts.appOptions.ingresarCode),
          ),
          actions: [
            TextButton(
              child: Text(apptexts.appOptions.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(apptexts.appOptions.verificar),
              onPressed: () {
                loginBloc.add(VerifyTwoFactorCode(codigoController.text));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context, LoginBloc loginBloc) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertChangePassword(
            loginBloc: loginBloc,
          );
        });
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.loginBloc,
  });

  final LoginBloc loginBloc;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
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
      controller: widget.loginBloc.txtControllerContrasena,
      focusNode: widget.loginBloc.focusNodeContrasena,
      validator: widget.loginBloc.validateContrasena,
      decoration: UtilsFunctionsViews.buildInputDecoration(
        label: 'Password',
        hint: '****',
        icon: Icons.lock,
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: _isPasswordVisible ? Colors.black : null,
          ),
          onPressed:
              _togglePasswordVisibility, // Cambia el estado de visibilidad cuando se presiona
        ),
      ),
      onEditingComplete: () =>
          widget.loginBloc.focusNodeContrasena.requestFocus(),
      onFieldSubmitted: (_) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}

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
