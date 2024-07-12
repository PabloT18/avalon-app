import 'package:alumni_app/app/presentation/bloc/push_notifications/notifications_bloc.dart';
import 'package:alumni_app/core/config/responsive/responsive_layouts.dart';
import 'package:alumni_app/core/config/router/app_routes_pages.dart';
import 'package:alumni_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/wid_drawer.dart';

class PreferenciasPage extends StatelessWidget {
  const PreferenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferencias'),
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
              'Preferencias de usuario',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppLayoutConst.spaceXL),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Notificaciones',
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
                  title: const Text('Permiso de notificaciones'),
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
          ],
        ),
      ),
    );
  }
}
