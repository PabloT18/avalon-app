import 'package:alumni_app/app/app.dart';

import 'package:alumni_app/app/presentation/bloc/push_notifications/notifications_bloc.dart';
import 'package:alumni_app/core/config/router/app_router.dart';
import 'package:alumni_app/core/config/theme/app_theme.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/push_notifications/push_notifications_use_cases.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => NotificationsBloc(
              subscribeTopicsUseCase: context.read<SubscribeTopicsUseCase>(),
              getStatusCheckUseCase: context.read<GetStatusCheckUseCase>(),
              toogleNotificationStateUC:
                  context.read<ToggleNotificationStateUseCase>(),
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    /// Incio de [NotificationsBloc]
    context.read<NotificationsBloc>().add(const InitiNotifications());

    return MaterialApp.router(
      debugShowCheckedModeBanner: true,
      title: 'AvalonPlus',
      routerConfig: AppRouter.router,

      theme: AppTheme.light,
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            switch (state) {
              case AppAuthenticated():
                AppRouter.router.go(PAGES.home.pagePath);
                break;
              case AppUnauthenticated():
                AppRouter.router.go(PAGES.login.pagePath);
                break;
              default:
            }
          },
          child: child,
        );
      },
      //      // darkTheme: AppTheme.dark,
      // themeMode: themeMode,
    );
  }
}
