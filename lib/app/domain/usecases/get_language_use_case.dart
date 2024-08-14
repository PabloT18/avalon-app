import 'package:avalon_app/i18n/generated/translations.g.dart';

import '../repository/settings_repository.dart';

class GetLanguage {
  const GetLanguage({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository;
  final SettingsRepository _settingsRepository;

  AppLocale call() => _settingsRepository.appLocal;
}
