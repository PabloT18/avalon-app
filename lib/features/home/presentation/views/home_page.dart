import 'package:alumni_app/core/config/router/app_router.dart';
import 'package:alumni_app/core/config/theme/app_colors.dart';
import 'package:alumni_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:flutter/material.dart';

import 'package:alumni_app/core/config/responsive/responsive_class.dart';

import 'package:alumni_app/core/config/router/app_routes_assets.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../shared/widgets/app_widgets.dart';
import 'home_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageView();
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  // late RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);
    final refreshController = RefreshController(initialRefresh: false);

    String nombre = "Francisco Ávila";
    String promocion = "Promocion 2013";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AVALON',
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            // color: Colors.white,
            onPressed: () {
              // AppRouter.goToLogin();
            },
          ),
        ],
      ),
      drawer: const DrawerCustom(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Noticias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Citas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
      body: SmartRefrehsCustom(
        key: const Key('__citas_list_key__'),
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          refreshController
            ..refreshCompleted()
            ..loadComplete();
        },
        refreshController: refreshController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              child: ListTile(
                leading: const Icon(Icons.medical_services),
                title: const Text('Requirimineto Cita Médica'),
                subtitle: const Text('N. de Cita: 123456'),
                trailing: const Icon(Icons.more_vert),
                onTap: () {
                  // AppRouter.goToLogin();
                },
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: ListTile(
                leading: const Icon(Icons.medical_services),
                title: const Text('Requirimineto Cita Médica'),
                subtitle: const Text('N. de Cita: 123456'),
                trailing: const Icon(Icons.more_vert),
                onTap: () {
                  // AppRouter.goToLogin();
                },
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: ListTile(
                leading: const Icon(Icons.medical_services),
                title: const Text('Requirimineto Cita Médica'),
                subtitle: const Text('N. de Cita: 123456'),
                trailing: const Icon(Icons.more_vert),
                onTap: () {
                  // AppRouter.goToLogin();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
