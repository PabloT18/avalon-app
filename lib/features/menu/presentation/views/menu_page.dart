import 'package:alumni_app/core/config/responsive/responsive_class.dart';
import 'package:alumni_app/core/config/responsive/responsive_layouts.dart';
import 'package:alumni_app/core/config/router/app_router.dart';
import 'package:alumni_app/core/config/router/app_routes_assets.dart';

import 'package:alumni_app/features/shared/widgets/wid_app_bar.dart';
import 'package:flutter/material.dart';

import '../../domain/models/menu_item_model.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MenuPageView();
  }
}

class _MenuPageView extends StatelessWidget {
  const _MenuPageView();

  @override
  Widget build(BuildContext context) {
    // final responsive = ResponsiveCustom.of(context);
    List<MenuOption> homeItems = [
      MenuOption(
          title: 'ID',
          icon: AppAssets.iconUser,
          route: PAGES.menu.pagePath + PAGES.perfil.pagePath),
      MenuOption(
          title: 'BENEFICIOS',
          icon: AppAssets.iconBeneficios,
          route: PAGES.menu.pagePath + PAGES.beneficios.pagePath),
      MenuOption(
          title: 'RESERVAS',
          icon: AppAssets.iconrRservas,
          route: PAGES.menu.pagePath + PAGES.reservas.pagePath),
      MenuOption(
          title: 'BENEFICIARIO',
          icon: AppAssets.iconBeneficiarios,
          route: PAGES.menu.pagePath + PAGES.beneficiarios.pagePath),
      MenuOption(
          title: 'NOTICIAS',
          icon: AppAssets.iconNoticias,
          route: PAGES.menu.pagePath + PAGES.noticias.pagePath),
      MenuOption(
          title: 'CALENDARIO',
          icon: AppAssets.iconCalendario,
          route: PAGES.menu.pagePath + PAGES.calendario.pagePath),
      MenuOption(
          title: 'CONTACTO',
          icon: AppAssets.iconContacto,
          route: PAGES.menu.pagePath + PAGES.contacto.pagePath),
      MenuOption(
          title: 'EL COLEGIO',
          icon: AppAssets.iconLogo,
          route: PAGES.menu.pagePath + PAGES.colegio.pagePath),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBarCustom(
        title: 'INICIO',
        route: PAGES.home.pagePath,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppLayoutConst
            .paddingXL), // Añade el padding que consideres necesario
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dos columnas
            crossAxisSpacing: AppLayoutConst
                .paddingL, // Espacio horizontal entre los elementos
            mainAxisSpacing: AppLayoutConst.paddingL,
            childAspectRatio: 1),
        itemCount:
            homeItems.length, // La cantidad de elementos en la cuadrícula
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // color: Colors.red,
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1, // Esto mantendrá el Card cuadrado.
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      color: Colors.blue.withOpacity(0.2),
                      child: InkWell(
                        onTap: () {
                          AppRouter.router.go(homeItems[index].route,
                              extra: homeItems[index].title);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(
                            homeItems[index].icon,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  homeItems[index].title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
