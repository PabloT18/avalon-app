import 'package:avalon_app/app/presentation/bloc/permissions/permissions_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:avalon_app/app/presentation/bloc/push_notifications/notifications_bloc.dart';
import 'package:avalon_app/app/presentation/bloc/settings_cubit/app_settings_cubit.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import '../../../shared/widgets/wid_drawer.dart';

class PreferenciasPage extends StatelessWidget {
  const PreferenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PermissionsBloc>().checkPermissions();

    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.preferenciasPage.preferenciasTitle),
        elevation: 4,
      ),
      drawer: DrawerCustom(indexInitialName: PAGES.preferencias.pageName),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppLayoutConst.paddingL),
        child: Column(
          children: [
            Text(
              apptexts.preferenciasPage.preferenciasUser,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppLayoutConst.spaceXL),
            const LenguagePreferences(),
            const SizedBox(height: AppLayoutConst.spaceL),
            const PermisosPreferences(),
          ],
        ),
      ),
    );
  }
}

class PermisosPreferences extends StatelessWidget {
  const PermisosPreferences({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermissionsBloc, PermissionsState>(
      builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                apptexts.preferenciasPage.permisos.title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: AppLayoutConst.marginM,
              ),
              height: 1,
              color: AppColors.secondaryBlue.withOpacity(0.5),
            ),
            CheckboxListTile(
              value: state.cameraGranted,
              title: Text(apptexts.preferenciasPage.permisos.camara),
              subtitle: Text('${state.camera}'),
              onChanged: (_) {
                context.read<PermissionsBloc>().requestCameraPermission();
              },
            ),
            CheckboxListTile(
              value: state.pthotoLibraryGranted,
              title: Text(apptexts.preferenciasPage.permisos.almacenamiento),
              subtitle: Text('${state.pthotoLibrary}'),
              onChanged: (_) {
                context
                    .read<PermissionsBloc>()
                    .requestPthotoLibraryPermission();
              },
            ),
            CheckboxListTile(
              value: state.notificationGranted,
              title: Text(apptexts.preferenciasPage.permisos.notificaciones),
              subtitle: Text('${state.notification}'),
              onChanged: (_) {
                context.read<PermissionsBloc>().requestNotificationPermission();
              },
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
          ],
        );
      },
    );
  }
}

class LenguagePreferences extends StatelessWidget {
  const LenguagePreferences({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            apptexts.preferenciasPage.idioma,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppLayoutConst.marginM,
          ),
          height: 1,
          color: AppColors.secondaryBlue.withOpacity(0.5),
        ),
        BlocBuilder<AppSettingsCubit, AppSettingsState>(
          builder: (context, state) {
            return CheckboxListTile(
              value: state.appLocale == AppLocale.es,
              onChanged: (active) {
                if (active!) {
                  context.read<AppSettingsCubit>().toggleLanguage(AppLocale.es);
                }
              },
              title: Text(
                apptexts.preferenciasPage.lanES,
              ),
              subtitle: Text(
                apptexts.preferenciasPage.spanish,
              ),
            );
          },
        ),
        BlocBuilder<AppSettingsCubit, AppSettingsState>(
          builder: (context, state) {
            return CheckboxListTile(
              value: state.appLocale == AppLocale.en,
              onChanged: (active) {
                if (active!) {
                  context.read<AppSettingsCubit>().toggleLanguage(AppLocale.en);
                }
              },
              title: Text(
                apptexts.preferenciasPage.lanEN,
              ),
              subtitle: Text(
                apptexts.preferenciasPage.ingles,
              ),
            );
          },
        ),
      ],
    );
  }
}
