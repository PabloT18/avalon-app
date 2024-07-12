import 'package:alumni_app/app/data/repository/notifications_repository_impl.dart';
import 'package:alumni_app/app/data/sources/remoteFB/puhs_notifications_fb.dart';
// import 'package:flutter/material.dart' show GlobalKey, ScaffoldMessengerState;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/usecases/push_notifications/push_notifications_use_cases.dart';

/// [AppDependencies] contains all the dependencies of the application to be
/// injected.
class AppDependencies {
  static List<RepositoryProvider<dynamic>> initDependencies() => [
        /// [Home Dependencies]
        ..._notficationsependencies,
      ];

  /// [HomeBloc] se crea cuanod se ocupa en HomePage de no no se activa
  static final List<RepositoryProvider<dynamic>> _notficationsependencies = [
    /// [Notifications Dependencies] se ponen en home poruqe se usaran una vez
    /// el usuairo se haya logueado y pase a [HOME]
    RepositoryProvider<NotficationRepositoryImpl>(
      create: (contextUC) =>
          NotficationRepositoryImpl(PushNotificationSourceFCM()),
    ),
    RepositoryProvider<GetStatusCheckUseCase>(
      create: (ctxtUC) => GetStatusCheckUseCase(
          repository: ctxtUC.read<NotficationRepositoryImpl>()),
    ),
    RepositoryProvider<SubscribeTopicsUseCase>(
      create: (ctxtUC) =>
          SubscribeTopicsUseCase(ctxtUC.read<NotficationRepositoryImpl>()),
    ),
    RepositoryProvider<ToggleNotificationStateUseCase>(
      create: (ctxtUC) => ToggleNotificationStateUseCase(
          repository: ctxtUC.read<NotficationRepositoryImpl>()),
    ),
  ];
}
