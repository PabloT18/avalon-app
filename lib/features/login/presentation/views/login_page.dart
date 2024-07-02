import 'dart:async';

import 'package:alumni_app/features/shared/widgets/app_widgets.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

import 'package:alumni_app/core/config/router/app_router.dart';

import 'package:alumni_app/features/shared/functions/fun_views.dart';
import 'package:alumni_app/features/shared/widgets/buttons/buttons_custom.dart';
import 'package:alumni_app/features/shared/widgets/loaders/loaders_widgets.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alumni_app/core/config/responsive/responsive_class.dart';
import 'package:alumni_app/core/config/router/app_routes_assets.dart';

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

    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
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
