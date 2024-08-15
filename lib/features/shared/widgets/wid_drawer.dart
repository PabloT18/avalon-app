import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/core/config/router/app_router.dart';
import 'package:avalon_app/core/config/router/app_routes_assets.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({
    super.key,
    required this.indexInitialName,
    this.isInHome = false,
  });

  final String indexInitialName;
  final bool isInHome;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);
    // int index = indexInitial;

    final List<DrawerOption> generalOptions = [
      DrawerOption(
          label: apptexts.medicosPage.title(n: 2),
          icon: Icons.medication_sharp,
          isUserOption: false,
          routeName: PAGES.medicos.pageName),
      DrawerOption(
          label: apptexts.centrosMedicos.title(n: 2),
          icon: Icons.local_hospital_rounded,
          isUserOption: false,
          routeName: PAGES.centrosMedicos.pageName),
      DrawerOption(
          label: apptexts.metodosPagoPage.title(n: 2),
          icon: Icons.question_answer,
          isUserOption: false,
          routeName: PAGES.formasPago.pageName),
      DrawerOption(
          label: apptexts.preferenciasPage.preferenciasUser,
          icon: Icons.person,
          isUserOption: false,
          routeName: PAGES.preferencias.pageName),
      DrawerOption(
          label: apptexts.faqsPAge.title(n: 2),
          icon: Icons.question_answer,
          isUserOption: false,
          routeName: PAGES.preguntas.pageName),
      DrawerOption(
          label: apptexts.appOptions.logout,
          icon: Icons.logout,
          isUserOption: false,
          routeName: PAGES.login.pagePath),
    ].where((option) => !option.isUserOption).toList();

    final List<DrawerOption> userOptions = [
      DrawerOption(
          label: 'Home', icon: Icons.house, routeName: PAGES.home.pagePath),
      DrawerOption(
          label: apptexts.reclamacionesPage.title(n: 2),
          icon: Icons.border_all,
          routeName: PAGES.reclamaciones.pageName),
      DrawerOption(
          label: apptexts.segurosPage.title(n: 2),
          icon: Icons.security_rounded,
          routeName: PAGES.seguros.pageName),
      DrawerOption(
          label: apptexts.familiaresPage.title(n: 2),
          icon: Icons.family_restroom,
          routeName: PAGES.familiares.pageName),
      DrawerOption(
          label: apptexts.membresiasPage.membresia(n: 2),
          icon: Icons.badge_outlined,
          routeName: PAGES.membresias.pageName),
    ].where((option) => option.isUserOption).toList();

    // final List<DrawerOption> generalOptions =
    //     drawerOptions.where((option) => option.isUserOption).toList();
    // final List<DrawerOption> userOptions =
    //     drawerOptions.where((option) => !option.isUserOption).toList();
    final List<DrawerOption> drawerOptions = [
      ...userOptions,
      ...generalOptions
    ];
    int index = getDrawerOptionIndex(drawerOptions, indexInitialName);
    return NavigationDrawer(
      indicatorColor: AppColors.secondaryBlue.withOpacity(0.2),
      backgroundColor: AppColors.white,
      selectedIndex: index,
      onDestinationSelected: (destination) {
        bool isSameDestination = index == destination;
        index = destination;

        Scaffold.of(context).closeDrawer();
        if (isSameDestination) return;

        if (destination == 0) {
          context.pop();
          return;
        }
        if (destination == drawerOptions.length - 1) {
          context.read<AuthenticationRepository>().logOut();
        } else {
          context.goNamed(drawerOptions[destination].routeName);
        }
      },
      children: [
        Center(
          child: Image.asset(
            AppAssets.logotipo4,
            // color: Colors.white,
            height: responsive.dp(8),
          ),
        ),
        SizedBox(height: responsive.hp(2)),
        ...userOptions.map((option) {
          return NavigationDrawerDestination(
            label: Text(option.label),
            icon: Icon(
              option.icon,
              color: AppColors.primaryBlue,
            ),
          );
        }),
        const Divider(),
        ...generalOptions.map((option) {
          return NavigationDrawerDestination(
            label: Text(option.label),
            icon: Icon(
              option.icon,
              color: AppColors.primaryBlue,
            ),
          );
        }),
      ],
    );
  }

  int getDrawerOptionIndex(List drawerOptions, String routeName) {
    for (int i = 0; i < drawerOptions.length; i++) {
      if (drawerOptions[i].routeName == routeName) {
        return i;
      }
    }
    return -1; // Retorna -1 si no se encuentra
  }
}

class DrawerOption {
  final String label;
  final IconData icon;
  final String routeName;
  final bool isUserOption;

  DrawerOption({
    required this.label,
    required this.icon,
    required this.routeName,
    this.isUserOption = true,
  });
}
