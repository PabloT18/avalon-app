import 'package:avalon_app/core/error/erros.dart';
import 'package:avalon_app/core/use_case/base_use_case.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:dartz/dartz.dart';

import '../repository/settings_repository.dart';

class ToggleLanguageUseCase extends BaseUseCase<AppLocale, AppLocale> {
  const ToggleLanguageUseCase({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository;
  final SettingsRepository _settingsRepository;

  @override
  Future<Either<Failure, AppLocale>> call({required AppLocale param}) {
    return _settingsRepository.updateLanguage(param);
  }
}
