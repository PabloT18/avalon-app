import 'package:alumni_app/app/app.dart';
import 'package:alumni_app/app/presentation/bloc/push_notifications/notifications_bloc.dart';
import 'package:alumni_app/core/config/router/app_router.dart';
import 'package:alumni_app/core/config/theme/app_colors.dart';
import 'package:alumni_app/features/perfil/perfil.dart';
import 'package:alumni_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:flutter/material.dart';

import 'package:alumni_app/core/config/responsive/responsive_class.dart';

import 'package:alumni_app/core/config/router/app_routes_assets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../comunicados/comunicados.dart';
import '../../../shared/widgets/app_widgets.dart';
import '../../../shared/widgets/wid_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageView();
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int _currentIndex = 1;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // late RefreshController refreshController;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AppBloc>().state.user;
    final userName = user.nombreUsuario?.toLowerCase() ?? '';
    final rol = user.rol?.nombre?.toLowerCase() ?? '';
    context.read<NotificationsBloc>().add(SubscribeTopics([
          'todos',
          'Todos',
          userName,
          rol,
        ]));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AvalonPlus',
          style: TextStyle(
            color: AppColors.primaryBlue,
          ),
        ),
        elevation: 6,
        // backgroundColor: AppColors.primaryBlue,
        // foregroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            // color: Colors.white,
            onPressed: () {
              context.pushNamed(PAGES.preferencias.pageName);
            },
          ),
        ],
      ),
      drawer: const DrawerCustom(
        indexInitial: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTapped,
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
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: const <Widget>[
          // NoticiasPanel(),
          ComunicadosPage(),

          CitasPanel(),
          PerfilPage(),
        ],
      ),
    );
  }
}

class CitasPanel extends StatelessWidget {
  const CitasPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: false);

    return SmartRefrehsCustom(
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
    );
  }
}

class NoticiasPanel extends StatelessWidget {
  const NoticiasPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: false);

    return SmartRefrehsCustom(
      key: const Key('__noticias_list_key__'),
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
            child: Column(
              children: [
                ListTile(
                  title: const Text('AvalonPlus Noti'),
                  subtitle: const Text('Prueba de mensaje como notificación'),
                  onTap: () {
                    // AppRouter.goToLogin();
                  },
                ),
                Image.network(
                    'https://avalonplus.com/wp-content/uploads/2023/12/avalon.png',
                    fit: BoxFit.cover)
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(),
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  title: const Text('AvalonPlus Noti'),
                  subtitle: const Text(
                      'Prueba de mensaje como notificación sin imagen'),
                  onTap: () {
                    // AppRouter.goToLogin();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
