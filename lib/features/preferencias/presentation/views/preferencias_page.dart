import 'package:avalon_app/app/presentation/bloc/push_notifications/notifications_bloc.dart';
import 'package:avalon_app/app/presentation/bloc/settings_cubit/app_settings_cubit.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/wid_drawer.dart';

class PreferenciasPage extends StatelessWidget {
  const PreferenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.preferenciasPage.preferenciasTitle),
        elevation: 4,
      ),
      drawer: DrawerCustom(
        indexInitial: getDrawerOptionIndex(PAGES.preferencias.pageName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppLayoutConst.paddingL)
            .copyWith(top: AppLayoutConst.paddingXL),
        child: Column(
          children: [
            Text(
              apptexts.preferenciasPage.preferenciasUser,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppLayoutConst.spaceXL),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                apptexts.preferenciasPage.notificaciones,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: AppLayoutConst.marginM,
              ),
              height: 1,
              color: AppColors.secondaryBlue.withOpacity(0.5),
            ),

            BlocBuilder<NotificationsBloc, NotificationsState>(
              builder: (context, state) {
                return CheckboxListTile(
                  value: state is NotificationsAuthorized,
                  title: Text(apptexts.preferenciasPage.notificacionesPermiso),
                  subtitle: Text(
                    state.title[0] + state.title.substring(1).toLowerCase(),
                  ),
                  onChanged: (_) {
                    context
                        .read<NotificationsBloc>()
                        .add(const NotificationToggleStatus());
                  },
                );
              },
            ),
            // Text(
            //   apptexts.comunicados.sec_topic_options_detalle,
            //   style: Theme.of(context).textTheme.bodyMedium,
            // ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                apptexts.preferenciasPage.idioma,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: AppLayoutConst.marginM,
              ),
              height: 1,
              color: AppColors.secondaryBlue.withOpacity(0.5),
            ),

            SwitchListTile(
              value: LocaleSettings.currentLocale.languageCode == "en",
              title: Text(LocaleSettings.currentLocale.languageCode == "en"
                  ? apptexts.preferenciasPage.lanES
                  : apptexts.preferenciasPage.lanEN),
              subtitle: Text(LocaleSettings.currentLocale.languageCode == "en"
                  ? apptexts.preferenciasPage.spanish
                  : apptexts.preferenciasPage.ingles),
              onChanged: (_) {
                if (LocaleSettings.currentLocale.languageCode == "en") {
                  context.read<AppSettingsCubit>().setES();
                } else {
                  context.read<AppSettingsCubit>().setEN();
                }
              },
            ),
            //   value: LocaleSettings.currentLocale.languageCode == "en",
            //   title: const Text('Cambiar de idioma'),
            //   subtitle: Text(LocaleSettings.currentLocale.languageCode),
            //   onChanged: (_) {
            //     if (LocaleSettings.currentLocale.languageCode == "en") {
            //       context.read<AppSettingsCubit>().setES();
            //     } else {
            //       context.read<AppSettingsCubit>().setEN();
            //     }
            //   },
            // ),

            // BlocBuilder<AppSettingsCubit, AppSettingsState>(
            //   builder: (context, state) {
            //     return Column(
            //       children: [
            //         SettingsSpecificOption(
            //           tooltip: apptexts.preferenciasPage.lanES,
            //           title: apptexts.preferenciasPage.spanish,
            //           onChanged: () {
            //             context
            //                 .read<AppSettingsCubit>()
            //                 .toggleLanguage(AppLocale.es);
            //           },
            //           value: state.appLocale == AppLocale.es,
            //           isDarkTheme: false,
            //         ),
            //         SettingsSpecificOption(
            //           tooltip: apptexts.preferenciasPage.lanEN,
            //           title: apptexts.preferenciasPage.ingles,
            //           onChanged: () {
            //             context
            //                 .read<AppSettingsCubit>()
            //                 .toggleLanguage(AppLocale.en);
            //           },
            //           value: state.appLocale == AppLocale.en,
            //           isDarkTheme: false,
            //         ),
            //       ],
            //     );
            //     // return Column(
            //     //   children: [
            //     //     SettingsSpecificOption(
            //     //       tooltip: apptexts.preferenciasPage.lanES,
            //     //       title: apptexts.preferenciasPage.spanish,
            //     //       onChanged: () {
            //     //         context
            //     //             .read<AppSettingsCubit>()
            //     //             .toggleLanguage(AppLocale.es);
            //     //       },
            //     //       value: state.appLocale == AppLocale.es,
            //     //       isDarkTheme: false,
            //     //     ),
            //     //     SettingsSpecificOption(
            //     //       tooltip: apptexts.preferenciasPage.lanEN,
            //     //       title: apptexts.preferenciasPage.ingles,
            //     //       onChanged: () {
            //     //         context
            //     //             .read<AppSettingsCubit>()
            //     //             .toggleLanguage(AppLocale.en);
            //     //       },
            //     //       value: state.appLocale == AppLocale.en,
            //     //       isDarkTheme: false,
            //     //     ),
            //     //   ],
            //     // );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
