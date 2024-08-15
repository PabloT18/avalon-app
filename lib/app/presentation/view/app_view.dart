import 'package:avalon_app/app/app.dart';

import 'package:avalon_app/app/presentation/bloc/push_notifications/notifications_bloc.dart';
import 'package:avalon_app/core/config/router/app_router.dart';
import 'package:avalon_app/core/config/theme/app_theme.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:avalon_app/features/user_features.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../domain/usecases/push_notifications/push_notifications_use_cases.dart';
import '../bloc/settings_cubit/app_settings_cubit.dart';

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
            create: (_) => RepositoryProvider.of<AppSettingsCubit>(context),
          ),
          BlocProvider(
            create: (_) => AppBloc(
              authenticationRepository: _authenticationRepository,
              getMembresias: RepositoryProvider.of<GetMembresiasUC>(context),
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
        child: const _BuildApp(),
      ),
    );
  }
}

/// [TranslationProvider] for Slang package to Localizations generate a
///  `ingereted` widget para
///
/// BlocBuilder to rebuild by change only `themeMode` from [AppSettingsCubit]
class _BuildApp extends StatelessWidget {
  const _BuildApp();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return TranslationProvider(child: const AppView());
      },
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
      locale: TranslationProvider.of(context).flutterLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocaleUtils.supportedLocales,
      theme: AppTheme.light,
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listenWhen: (previous, current) {
            return !(previous is AppAuthenticated &&
                current is AppAuthenticated);
          },
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
    );
  }
}
