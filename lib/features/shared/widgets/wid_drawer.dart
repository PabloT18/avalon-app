import 'package:alumni_app/core/config/responsive/responsive_class.dart';
import 'package:alumni_app/core/config/router/app_router.dart';
import 'package:alumni_app/core/config/router/app_routes_assets.dart';
import 'package:alumni_app/core/config/theme/app_colors.dart';
import 'package:authentication_repository/authentication_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    return NavigationDrawer(
      indicatorColor: AppColors.secondaryBlue.withOpacity(0.2),
      backgroundColor: AppColors.white,
      selectedIndex: index,
      onDestinationSelected: (destination) {
        bool isSameDestination = index == destination;
        index = destination;

        Scaffold.of(context).closeDrawer();
        if (isSameDestination) return;

        switch (destination) {
          case 0:
            context.go(PAGES.home.pagePath);
            break;
          case 1:
            context.pushNamed(PAGES.reclamaciones.pageName);
          case 2:
            context.pushNamed(PAGES.seguros.pageName);

            break;
          case 3:
            context.pushNamed(PAGES.familiares.pageName);

            break;
          case 4:
            context.pushNamed(PAGES.membresias.pageName);
          case 5:
            context.pushNamed(PAGES.preferencias.pageName);
            break;
          case 7:
            context.read<AuthenticationRepository>().logOut();
            context.go(PAGES.login.pagePath);
            break;
        }
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
        const NavigationDrawerDestination(
          label: Text('Home'),
          icon: Icon(
            Icons.house,
            color: AppColors.primaryBlue,
          ),
        ),
        const NavigationDrawerDestination(
          label: Text('Reclamaciones'),
          icon: Icon(
            Icons.border_all,
            color: AppColors.primaryBlue,
          ),
          // enabled: false,
        ),
        const NavigationDrawerDestination(
          label: Text('Seguros'),
          icon: Icon(
            Icons.security_rounded,
            color: AppColors.primaryBlue,
          ),
        ),
        const NavigationDrawerDestination(
          label: Text('Familiares'),
          icon: Icon(
            Icons.family_restroom,
            color: AppColors.primaryBlue,
          ),
        ),
        const NavigationDrawerDestination(
          label: Text('Membresias'),
          icon: Icon(
            Icons.badge_outlined,
            color: AppColors.primaryBlue,
          ),
        ),
        const Divider(),
        const NavigationDrawerDestination(
          label: Text('Preferencias de usuario'),
          icon: Icon(
            Icons.person,
            color: AppColors.primaryBlue,
          ),
        ),
        const NavigationDrawerDestination(
          label: Text('Preguntas y respuestas'),
          icon: Icon(
            Icons.person,
            color: AppColors.primaryBlue,
          ),
          enabled: false,
        ),
        const NavigationDrawerDestination(
          label: Text('Cerrar sesión'),
          icon: Icon(
            Icons.logout,
            color: AppColors.primaryBlue,
          ),
        ),
      ],
    );
  }
}
