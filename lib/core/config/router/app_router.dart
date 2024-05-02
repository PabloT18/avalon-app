import 'dart:developer';

import 'package:alumni_app/features/menu/menu.dart';
import 'package:alumni_app/features/userFeatures/user_features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:go_router/go_router.dart';

import 'package:alumni_app/features/login/login.dart';
import 'package:alumni_app/features/home/home.dart';
import 'package:alumni_app/features/loading/loading.dart';
import 'package:alumni_app/features/welcome/welcome.dart';

import 'package:alumni_app/features/shared/widgets/wid_skeleton_page.dart';

import 'app_routes_pages.dart';
export 'app_routes_pages.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: PAGES.loading.pagePath,
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      log('Route -> ${state.uri.toString()}');
      return null;
    },
    routes: [
      /// [HOME] Page Route
      GoRoute(
        path: PAGES.loading.pagePath,
        name: PAGES.loading.pageName,
        // builder: (context, state) => const LoadingPage(),
        pageBuilder: (context, state) => pageBuilderByPlatform(
          context,
          state,
          const LoadingPage(),
        ),
      ),
      GoRoute(
        path: PAGES.welcome.pagePath,
        name: PAGES.welcome.pageName,
        pageBuilder: (context, state) => pageBuilderByPlatform(
          context,
          state,
          const WelcomePage(),
        ),
        // builder: (context, xstate) => const WelcomePage(),
      ),
      GoRoute(
        path: PAGES.login.pagePath,
        name: PAGES.login.pageName,
        // builder: (context, state) => const LoginPage(),
        pageBuilder: (context, state) => pageBuilderByPlatform(
          context,
          state,
          const LoginPage(),
        ),
      ),
      GoRoute(
        path: PAGES.home.pagePath,
        name: PAGES.home.pageName,
        pageBuilder: (context, state) => pageBuilderByPlatform(
          context,
          state,
          const HomePage(),
        ),
      ),
      GoRoute(
        path: PAGES.menu.pagePath,
        name: PAGES.menu.pageName,
        pageBuilder: (context, state) => pageBuilderByPlatform(
          context,
          state,
          const MenuPage(),
        ),
        routes: [
          GoRoute(
            path: PAGES.perfil.pagePath.substring(1),
            name: PAGES.perfil.pageName,
            pageBuilder: (context, state) => pageBuilderByPlatform(
              context,
              state,
              PerfilPage(
                title: state.extra as String,
              ),
            ),
          ),
          GoRoute(
            path: PAGES.beneficios.pagePath.substring(1),
            name: PAGES.beneficios.pageName,
            pageBuilder: (context, state) => pageBuilderByPlatform(
              context,
              state,
              BeneficiosPage(
                title: state.extra as String,
              ),
            ),
          ),
          GoRoute(
            path: PAGES.reservas.pagePath.substring(1),
            name: PAGES.reservas.pageName,
            pageBuilder: (context, state) => pageBuilderByPlatform(
              context,
              state,
              ReservasPage(
                title: state.extra as String,
              ),
            ),
          ),
          GoRoute(
            path: PAGES.beneficiarios.pagePath.substring(1),
            name: PAGES.beneficiarios.pageName,
            pageBuilder: (context, state) => pageBuilderByPlatform(
              context,
              state,
              BeneficiariosPage(
                title: state.extra as String,
              ),
            ),
          ),
          GoRoute(
            path: PAGES.noticias.pagePath.substring(1),
            name: PAGES.noticias.pageName,
            pageBuilder: (context, state) => pageBuilderByPlatform(
              context,
              state,
              NoticiasPage(
                title: state.extra as String,
              ),
            ),
          ),
          GoRoute(
            path: PAGES.calendario.pagePath.substring(1),
            name: PAGES.calendario.pageName,
            pageBuilder: (context, state) => pageBuilderByPlatform(
              context,
              state,
              CalendarioPage(
                title: state.extra as String,
              ),
            ),
          ),
          GoRoute(
            path: PAGES.contacto.pagePath.substring(1),
            name: PAGES.contacto.pageName,
            pageBuilder: (context, state) => pageBuilderByPlatform(
              context,
              state,
              ContactoPage(
                title: state.extra as String,
              ),
            ),
          ),
          GoRoute(
            path: PAGES.colegio.pagePath.substring(1),
            name: PAGES.colegio.pageName,
            pageBuilder: (context, state) => pageBuilderByPlatform(
              context,
              state,
              ColegioPage(
                title: state.extra as String,
              ),
            ),
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
  static GlobalKey<NavigatorState> get navigatorState => _rootNavigatorKey;

  static Page<dynamic> pageBuilderByPlatform(
    BuildContext context,
    GoRouterState state,
    Widget page, {
    Duration? duration,
    Curve? curve,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: SkeletonPage(
          panelWidget: page), // Aplica el fondo a todas las páginas
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Define la transición personalizada
        // const begin = Offset(1.0, 0.0); // Desliza desde la derecha
        // const end = Offset.zero;
        const curve = Curves.ease;

        // var tween =
        //     Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        // var offsetAnimation = animation.drive(tween);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        var fadeTween =
            Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        // Usa el FadeTransition para la animación de desvanecimiento
        return FadeTransition(
          opacity: animation.drive(fadeTween), // Controla la opacidad
          child: child,
        );
      },
    );
  }
}
