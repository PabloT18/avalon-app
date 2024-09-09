import 'dart:developer';

import 'package:avalon_app/app/domain/entity/push_notifications/push_message.dart';
import 'package:avalon_app/features/familiares/familiares.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:go_router/go_router.dart';

import 'package:avalon_app/features/login/login.dart';
import 'package:avalon_app/features/home/home.dart';
import 'package:avalon_app/features/loading/loading.dart';

import 'package:avalon_app/features/shared/widgets/wid_skeleton_page.dart';

import 'package:avalon_app/features/user_features.dart';

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
        pageBuilder: (context, state) => pageBuilderByPlatform(
          context,
          state,
          const LoadingPage(),
        ),
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
          routes: [
            GoRoute(
                path: PAGES.editPerfil.pageName,
                name: PAGES.editPerfil.pageName,
                pageBuilder: (context, state) => pageBuilderByPlatform(
                      context,
                      state,
                      const EditPerfilOptionsPage(),
                    ),
                routes: [
                  GoRoute(
                    path: PAGES.editPerfilDatPer.pageName,
                    name: PAGES.editPerfilDatPer.pageName,
                    pageBuilder: (context, state) => pageBuilderByPlatform(
                      context,
                      state,
                      const EditPerfilPage(),
                    ),
                  ),
                  GoRoute(
                    path: PAGES.editPerfilDir.pageName,
                    name: PAGES.editPerfilDir.pageName,
                    pageBuilder: (context, state) => pageBuilderByPlatform(
                      context,
                      state,
                      const EditAddressPage(),
                    ),
                  ),
                ]),
            GoRoute(
              path: PAGES.preferencias.pageName,
              name: PAGES.preferencias.pageName,
              pageBuilder: (context, state) => pageBuilderByPlatform(
                context,
                state,
                const PreferenciasPage(),
              ),
            ),
            GoRoute(
                path: PAGES.casos.pageName,
                name: PAGES.casos.pageName,
                pageBuilder: (context, state) => pageBuilderByPlatform(
                      context,
                      state,
                      const CasosPage(),
                    ),
                routes: [
                  GoRoute(
                    path: PAGES.crearCaso.pageName,
                    name: PAGES.crearCaso.pageName,
                    pageBuilder: (context, state) => pageBuilderByPlatform(
                      context,
                      state,
                      const CrearCasoPage(),
                    ),
                  ),
                  GoRoute(
                    path: '${PAGES.detaleCaso.pageName}/:casoId',
                    name: PAGES.detaleCaso.pageName,
                    pageBuilder: (context, state) => pageBuilderByPlatform(
                      context,
                      state,
                      const CasoDetallePage(),
                    ),
                  ),
                ]),
            GoRoute(
              path: PAGES.reclamaciones.pageName,
              name: PAGES.reclamaciones.pageName,
              pageBuilder: (context, state) => pageBuilderByPlatform(
                context,
                state,
                const ReclamacionesPage(),
              ),
            ),
            GoRoute(
              path: PAGES.seguros.pageName,
              name: PAGES.seguros.pageName,
              pageBuilder: (context, state) => pageBuilderByPlatform(
                context,
                state,
                const SegurosPage(),
              ),
            ),
            GoRoute(
              path: PAGES.familiares.pageName,
              name: PAGES.familiares.pageName,
              pageBuilder: (context, state) => pageBuilderByPlatform(
                context,
                state,
                const FamiliaresPage(),
              ),
            ),
            GoRoute(
                path: PAGES.addFamiliar.pageName,
                name: PAGES.addFamiliar.pageName,
                pageBuilder: (context, state) {
                  final polizaId = state.extra as int;

                  return pageBuilderByPlatform(
                      context, state, AddFamiliarPage(polizaId: polizaId));
                }),
            GoRoute(
                path: PAGES.membresias.pageName,
                name: PAGES.membresias.pageName,
                pageBuilder: (context, state) {
                  return pageBuilderByPlatform(
                      context, state, const MembresiasPage());
                }),
            GoRoute(
              path: PAGES.preguntas.pageName,
              name: PAGES.preguntas.pageName,
              pageBuilder: (context, state) => pageBuilderByPlatform(
                context,
                state,
                const PreguntasPage(),
              ),
            ),
            GoRoute(
              path: PAGES.formasPago.pageName,
              name: PAGES.formasPago.pageName,
              pageBuilder: (context, state) => pageBuilderByPlatform(
                context,
                state,
                const FormasPagoPage(),
              ),
            ),
            GoRoute(
              path: PAGES.centrosMedicos.pageName,
              name: PAGES.centrosMedicos.pageName,
              pageBuilder: (context, state) => pageBuilderByPlatform(
                context,
                state,
                const CentrosMedicosPage(),
              ),
            ),
            GoRoute(
              path: PAGES.medicos.pageName,
              name: PAGES.medicos.pageName,
              pageBuilder: (context, state) => pageBuilderByPlatform(
                context,
                state,
                const MedicosPage(),
              ),
            ),
            GoRoute(
              path: PAGES.aboutus.pageName,
              name: PAGES.aboutus.pageName,
              pageBuilder: (context, state) => pageBuilderByPlatform(
                context,
                state,
                const AboutusPage(),
              ),
            ),
          ]),
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

  static void navigateFromPushMessage(PushMessage pushMessage) {
    if (pushMessage.hasRoute) {
      final String location = _router.routeInformationParser.toString();
      if (!(location == pushMessage.routeValue!)) {
        if ((pushMessage.routeValue! == 'noticia' ||
                pushMessage.routeValue! == 'evento') &&
            pushMessage.hasDataId &&
            pushMessage.hasDataName) {
          _router.goNamed(pushMessage.routeValue!, pathParameters: {
            pushMessage.dataNameValue!: pushMessage.dataIdValue!
          });
        } else {
          _router.goNamed(pushMessage.routeValue!);
        }
      }
    }
  }
}
