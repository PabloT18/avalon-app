import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:avalon_app/app/presentation/bloc/settings_cubit/app_settings_cubit.dart';
import 'package:avalon_app/core/config/responsive/responsive_class.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/core/config/router/app_router.dart';

import 'package:avalon_app/app/presentation/bloc/app_cycle/app_lifecycle_cubit.dart';

import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import '../../../shared/widgets/wid_drawer.dart';
import '../cubit/home_navigation_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('State  $state');
    context.read<AppLifeCubit>().changeState(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    /// Incio de [NotificationsBloc]
    ///
    ///
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    ///TODO: ACTIVAE NOTIFICACTIONS 5L
    // final notificacionesBloc = context.read<NotificationsBloc>();
    // notificacionesBloc.add(const InitiNotifications());

    // if (user.nombreUsuario != null) {
    //   notificacionesBloc.add(SubscribeTopics([user.nombreUsuario!]));
    // }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationCubit(),
        ),
        // BlocProvider(create: (context) => CitasBloc(user)),
        // BlocProvider(create: (context) => ReclamacionesBloc(user)),
        // BlocProvider(create: (context) => EmergenciasBloc(user)),
      ],
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    // final navigationCubit = context.read<NavigationCubit>();
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'AvalonPlus',
              style: TextStyle(
                // color: AppColors.primaryBlue,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white, // Cambia el color del icono de hamburguesa
            ),
            backgroundColor: AppColors.primaryBlue,
            centerTitle: true,
            elevation: 6,
            actions: [
              Material(
                elevation: 1, // Cambia este valor para ajustar la elevación
                shape: const CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: AppColors.secondaryBlue,
                  child: IconButton(
                    icon: const Icon(
                      Icons.person,
                    ),
                    onPressed: () {
                      context.pushNamed(PAGES.perfil.pageName);
                    },
                  ),
                ),
              ),
            ],
          ),
          drawer: DrawerCustom(
            indexInitialName: PAGES.home.pageName,
            isInHome: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppLayoutConst.paddingL),
            child: Column(
              children: [
                HomeOption(
                  icon: FontAwesomeIcons.fileMedical,
                  title: apptexts.reclamacionesPage.title(n: 2),
                  onTap: () {
                    context.goNamed(PAGES.reclamaciones.pageName);
                  },
                ),
                HomeOption(
                  icon: FontAwesomeIcons.calendarPlus,
                  title: apptexts.citasPage.title(n: 2),
                  onTap: () {
                    context.goNamed(PAGES.citas.pageName);
                  },
                ),
                HomeOption(
                  icon: FontAwesomeIcons.kitMedical,
                  title: apptexts.emergenciasPage.title(n: 2),
                  onTap: () {
                    context.goNamed(PAGES.emergencia.pageName);
                  },
                ),
              ],
            ),
          ),
          // floatingActionButton: BlocBuilder<NavigationCubit, int>(
          //   builder: (context, state) {
          //     return FloatingActionButton(
          //       mini: true,
          //       onPressed: state == 1
          //           ? () {
          //               context.goNamed(PAGES.crearCita.pageName);
          //             }
          //           : state == 2
          //               ? () {
          //                   context.goNamed(PAGES.crearEmergencia.pageName);
          //                 }
          //               : () {
          //                   context.goNamed(PAGES.crearReclamacion.pageName);
          //                 },
          //       child: const Icon(Icons.add),
          //     );
          //   },
          // ),
          // bottomNavigationBar: BlocBuilder<AppSettingsCubit, AppSettingsState>(
          //   builder: (context, state) {
          //     return BlocBuilder<NavigationCubit, int>(builder: (context, state) {
          //       return BottomNavigationBar(
          //         currentIndex: state,
          //         onTap: (index) {
          //           navigationCubit.setPage(index);
          //         },
          //         items: [
          //           BottomNavigationBarItem(
          //             icon: const FaIcon(FontAwesomeIcons.fileMedical),
          //             label: apptexts.reclamacionesPage.title(n: 2),
          //           ),
          //           BottomNavigationBarItem(
          //             icon: const FaIcon(FontAwesomeIcons.calendarPlus),
          //             label: apptexts.citasPage.title(n: 2),
          //           ),
          //           BottomNavigationBarItem(
          //             icon: const FaIcon(FontAwesomeIcons.kitMedical),
          //             label: apptexts.emergenciasPage.title(n: 2),
          //           ),
          //         ],
          //       );
          //     });
          //   },
          // ),
          // body: PageView(
          //   controller: context.read<NavigationCubit>().pageController,
          //   onPageChanged: (index) {
          //     navigationCubit.onPageChanged(index);
          //   },
          //   children: const <Widget>[
          //     ReclamacionesPanel(),
          //     CitasPanel(),
          //     EmergenciaPanel(),
          //   ],
          // ),
        );
      },
    );
  }
}

class HomeOption extends StatelessWidget {
  const HomeOption({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);
    return FadeInLeft(
      from: 30,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: responsive.dp(9),
            child: Align(
              alignment: Alignment.center,
              child: ListTile(
                leading: FaIcon(
                  icon,
                  size: responsive.dp(5),
                  color: color,
                ),
                title: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                titleAlignment: ListTileTitleAlignment.center,
                minLeadingWidth: 60,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class NoticiasPanel extends StatelessWidget {
//   const NoticiasPanel({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final refreshController = RefreshController(initialRefresh: false);

//     return SmartRefrehsCustom(
//       key: const Key('__noticias_list_key__'),
//       onRefresh: () async {
//         await Future.delayed(const Duration(seconds: 1));
//         refreshController
//           ..refreshCompleted()
//           ..loadComplete();
//       },
//       refreshController: refreshController,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Card(
//             clipBehavior: Clip.hardEdge,
//             child: Column(
//               children: [
//                 ListTile(
//                   title: const Text('AvalonPlus Noti'),
//                   subtitle: const Text('Prueba de mensaje como notificación'),
//                   onTap: () {
//                     // AppRouter.goToLogin();
//                   },
//                 ),
//                 Image.network(
//                     'https://avalonplus.com/wp-content/uploads/2023/12/avalon.png',
//                     fit: BoxFit.cover)
//               ],
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Divider(),
//           ),
//           Card(
//             clipBehavior: Clip.hardEdge,
//             child: Column(
//               children: [
//                 ListTile(
//                   title: const Text('AvalonPlus Noti'),
//                   subtitle: const Text(
//                       'Prueba de mensaje como notificación sin imagen'),
//                   onTap: () {
//                     // AppRouter.goToLogin();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
