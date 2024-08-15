import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:avalon_app/features/user_features.dart';

import 'package:avalon_app/app/data/sources/remoteFB/puhs_notifications_fb.dart';
import 'package:avalon_app/app/presentation/bloc/settings_cubit/app_settings_cubit.dart';

import '../data/repository/app_repositories_impl.dart';
import '../domain/repository/app_repositories.dart';
import '../domain/usecases/general_uc/app_general_uses_cases.dart';
import '../domain/usecases/get_language_use_case.dart';
import '../domain/usecases/push_notifications/push_notifications_use_cases.dart';
import '../domain/usecases/togle_language_case.dart';

/// [AppDependencies] contains all the dependencies of the application to be
/// injected.
class AppDependencies {
  static List<RepositoryProvider<dynamic>> initDependencies() => [
        /// [AppSettingsCubit]
        ..._appSettingsDependencies,

        /// [Home Dependencies]
        ..._notficationsependencies,

        /// [General Data Dependencies]
        ..._generalDataDependencies,

        /// [Membresias Dependcies]
        ..._membresiasDependencies,
      ];

  /// Set up the AppSettingsCubit, which will glue user settings to multiple
  /// Flutter Widgets.
  static final List<RepositoryProvider<dynamic>> _appSettingsDependencies = [
    /// Dependencias de [RemoteConfig]

    // RepositoryProvider<RemoteConfigRepository>(
    //   create: (_) => RemoteConfigRepositoryImpl(RemoteConfingSourcesFB()),
    // ),
    // RepositoryProvider<RemoteConfigCubit>(
    //   create: (ctxtCub) =>
    //       RemoteConfigCubit(ctxtCub.read<RemoteConfigRepository>()),
    // ),

    /// Dependencias de [AppSettings]
    RepositoryProvider<SettingsRepositoryImpl>(
      create: (_) => SettingsRepositoryImpl(),
    ),
    RepositoryProvider<AppSettingsCubit>(
      create: (contextSettings) => AppSettingsCubit(
        toggleLanguageUseCase: ToggleLanguageUseCase(
          settingsRepository: contextSettings.read<SettingsRepositoryImpl>(),
        ),
        getLanguage: GetLanguage(
          settingsRepository: contextSettings.read<SettingsRepositoryImpl>(),
        ),
      ),
    ),
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

    /// Preguntas y respuestas
    RepositoryProvider<PreguntasRepository>(
      create: (context) => PreguntasRepositoryImpl(),
    ),

    /// Formas de pago
    RepositoryProvider<FormasPagoRepository>(
      create: (context) => FormasPagoRepositoryImpl(),
    ),

    /// Medicos
    RepositoryProvider<MedicosRepository>(
      create: (context) => MedicosRepositoryImpl(),
    ),

    /// Centros Medicos
    RepositoryProvider<CentrosmedicosRepository>(
      create: (context) => CentrosmedicosRepositoryImpl(),
    ),
  ];

  static final List<RepositoryProvider<dynamic>> _generalDataDependencies = [
    RepositoryProvider<GeneralDataRepository>(
      create: (context) => const GeneralDataRepositoryImpl(),
    ),
    RepositoryProvider<GetPaisesUseCase>(
      create: (contextPUC) => GetPaisesUseCase(
          generalDataRepository: contextPUC.read<GeneralDataRepository>()),
    ),
    RepositoryProvider<GetEstadosUseCase>(
      create: (contextPUC) =>
          GetEstadosUseCase(contextPUC.read<GeneralDataRepository>()),
    ),
  ];
  static final List<RepositoryProvider<dynamic>> _membresiasDependencies = [
    RepositoryProvider<GetMembresiasUC>(
      create: (context) => const GetMembresiasUC(
        MembresiasRepositoryImpl(),
      ),
    ),
  ];
  // static final List<RepositoryProvider<dynamic>> _membresiasDependencies = [];
}
