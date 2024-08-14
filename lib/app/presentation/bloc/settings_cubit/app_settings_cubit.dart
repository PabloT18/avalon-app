import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_language_use_case.dart';
import '../../../domain/usecases/togle_language_case.dart';

part 'app_settings_state.dart';

/// Takes a [Create] function that is responsible for creating the repository
/// and a `child` which will have access to the repository via
/// `RepositoryProvider.of(context)`.
/// It is used as a dependency injection (DI) widget so that a single instance
/// of a repository can be provided to multiple widgets within a subtree.
///
/// ```dart
/// RepositoryProvider(
///   create: (context) => RepositoryA(),
///   child: ChildA(),
/// );
/// ```
///
/// Lazily creates the repository unless `lazy` is set to `false`.
///
/// ```dart
/// RepositoryProvider(
///   lazy: false,`
///   create: (context) => RepositoryA(),
///   child: ChildA(),
/// );
/// ```
/// /// * [or separated out][ref link]
///
///
///
class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit({
    required this.getLanguage,
    required ToggleLanguageUseCase toggleLanguageUseCase,
  })  : _toggleLanguageUseCase = toggleLanguageUseCase,
        super(
          AppSettingsState(
            appLocale: getLanguage.call(),
          ),
        ) {
    LocaleSettings.setLocale(state.appLocale);
  }

  final ToggleLanguageUseCase _toggleLanguageUseCase;
  final GetLanguage getLanguage;

  // Change and Persis Language change
  // void toggleLanguage(AppLocale appLocale) async {
  //   if (appLocale != state.appLocale) {
  //     // Persis Language change
  //     await _toggleLanguageUseCase.call(param: appLocale);
  //     // Emit state copied
  //     emit(state.copyWith(appLocale: appLocale));

  //     // cahnge language
  //     LocaleSettings.setLocale(appLocale);
  //   }
  // }

  void setEN() async {
    LocaleSettings.setLocale(AppLocale.en);
  }

  void setES() async {
    LocaleSettings.setLocale(AppLocale.es);
  }
}
