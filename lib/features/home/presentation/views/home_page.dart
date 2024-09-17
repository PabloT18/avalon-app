import 'dart:developer';

import 'package:avalon_app/app/presentation/bloc/app_cycle/app_lifecycle_cubit.dart';
import 'package:avalon_app/app/presentation/bloc/push_notifications/notifications_bloc.dart';
import 'package:avalon_app/core/config/router/app_router.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/citas/presentation/views/pages/citas_page.dart';

import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../shared/widgets/wid_drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    /// Incio de [NotificationsBloc]
    context.read<NotificationsBloc>().add(const InitiNotifications());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AvalonPlus',
          style: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 6,
        actions: [
          Material(
            elevation: 1, // Cambia este valor para ajustar la elevación
            shape: const CircleBorder(),
            child: CircleAvatar(
              child: IconButton(
                icon: const Icon(Icons.person),
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
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              mini: true,
              onPressed: () {
                context.goNamed(PAGES.crearCita.pageName);
              },
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTapped,
        items: [
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.fileMedical),
            label: apptexts.reclamacionesPage.title(n: 2),
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.calendarPlus),
            label: apptexts.citasPage.title(n: 2),
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.kitMedical),
            label: apptexts.emergenciasPage.title(n: 2),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: const <Widget>[
          CitasPanel(),
          CitasPanel(),
          CitasPanel(),
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
