import 'package:alumni_app/core/config/responsive/responsive_class.dart';
import 'package:alumni_app/core/config/router/app_router.dart';
import 'package:alumni_app/core/config/router/app_routes_assets.dart';
import 'package:alumni_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);
    return NavigationDrawer(
      indicatorColor: AppColors.secondaryBlue.withOpacity(0.2),
      backgroundColor: AppColors.white,
      onDestinationSelected: (destination) {
        switch (destination) {
          case 1:
            context.go(PAGES.login.pagePath);

            break;
          case 2:
            context.go(PAGES.login.pagePath);

            break;
          case 3:
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
          icon: Icon(Icons.house),
        ),
        const Divider(),
        const NavigationDrawerDestination(
          label: Text('Preferencias de usuario'),
          icon: Icon(Icons.person),
        ),
        const NavigationDrawerDestination(
          label: Text('Cerrar sesión'),
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }
}
