import 'package:alumni_app/core/config/responsive/responsive_class.dart';
import 'package:alumni_app/core/config/router/app_router.dart';
import 'package:alumni_app/core/config/router/app_routes_assets.dart';
import 'package:alumni_app/core/config/theme/app_colors.dart';
import 'package:authentication_repository/authentication_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final List<DrawerOption> drawerOptions = [
  DrawerOption(
      label: 'Home', icon: Icons.house, routeName: PAGES.home.pagePath),
  DrawerOption(
      label: 'Reclamaciones',
      icon: Icons.border_all,
      routeName: PAGES.reclamaciones.pageName),
  DrawerOption(
      label: 'Seguros',
      icon: Icons.security_rounded,
      routeName: PAGES.seguros.pageName),
  DrawerOption(
      label: 'Familiares',
      icon: Icons.family_restroom,
      routeName: PAGES.familiares.pageName),
  DrawerOption(
      label: 'Membresias',
      icon: Icons.badge_outlined,
      routeName: PAGES.membresias.pageName),
  DrawerOption(
      label: 'Preferencias de usuario',
      icon: Icons.person,
      isUserOption: false,
      routeName: PAGES.preferencias.pageName),
  DrawerOption(
      label: 'Formas de Pago',
      icon: Icons.question_answer,
      isUserOption: false,
      routeName: PAGES.formasPago.pageName),
  DrawerOption(
      label: 'Preguntas y respuestas',
      icon: Icons.question_answer,
      isUserOption: false,
      routeName: PAGES.preguntas.pageName),
  DrawerOption(
      label: 'Cerrar sesión',
      icon: Icons.logout,
      isUserOption: false,
      routeName: PAGES.login.pagePath),
];

int getDrawerOptionIndex(String routeName) {
  for (int i = 0; i < drawerOptions.length; i++) {
    if (drawerOptions[i].routeName == routeName) {
      return i;
    }
  }
  return -1; // Retorna -1 si no se encuentra
}

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({
    super.key,
    required this.indexInitial,
  });

  final int indexInitial;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);
    int index = indexInitial;

    final List<DrawerOption> generalOptions =
        drawerOptions.where((option) => option.isUserOption).toList();
    final List<DrawerOption> userOptions =
        drawerOptions.where((option) => !option.isUserOption).toList();

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
        }

        context.goNamed(drawerOptions[destination].routeName);
      },
      children: [
        Center(
          child: Image.asset(
            AppAssets.logotipo4,
            // color: Colors.white,
            // height: responsive.dp(7),
          ),
        ),
        SizedBox(height: responsive.hp(4)),
        ...generalOptions.map((option) {
          return NavigationDrawerDestination(
            label: Text(option.label),
            icon: Icon(
              option.icon,
              color: AppColors.primaryBlue,
            ),
          );
        }),
        const Divider(),
        ...userOptions.map((option) {
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
