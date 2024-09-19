import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';

import 'package:avalon_app/features/citas/presentation/views/widgets/cita_card.dart';
import 'package:avalon_app/features/reclamaciones/presentation/views/wid_reclamacion_card.dart';
import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:avalon_app/features/casos/presentation/bloc/detallecaso/detallecaso_bloc.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';

class CDRembolososDetalleBox extends StatelessWidget {
  const CDRembolososDetalleBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final detalleCasoBloc = context.read<DetalleCasoBloc>();
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                apptexts.reclamacionesPage.reclamacionDetalle(n: 2),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              IconButton(
                icon: const Icon(Icons.info_outline, size: 20),
                onPressed: () {
                  UtilsFunctionsViews.showInfoStatesTypesDialog(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          BlocBuilder<DetalleCasoBloc, DetalleCasoState>(
            builder: (context, state) {
              if (state is! DetalleCasoLoaded) {
                return const SizedBox();
              } else if (state.errorReclamaciones != null) {
                return MessageError(
                    message: apptexts.appOptions.noData,
                    onTap: () {
                      detalleCasoBloc.add(const CDGetCitas());
                    });
              } else if (state.reclamaciones == null) {
                return const Center(child: CircularProgressIndicatorCustom());
              }

              if (state.citas!.isEmpty) {
                return MessageError(
                    message: apptexts.appOptions.noData,
                    onTap: () {
                      detalleCasoBloc.add(const CDGetReclamaciones());
                    });
              } else {
                return Expanded(
                    child: ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppLayoutConst.paddingL),
                        children: [
                      ...state.reclamaciones!.map(
                        (reclamacion) => Hero(
                          tag: reclamacion.hashCode,
                          child: ReclamacionCard(
                            navigatePush: true,
                            reclamacion: reclamacion,
                            isClient: user.isClient,
                          ),
                        ),
                      ),
                    ]));
              }
            },
          ),
        ],
      ),
    );
  }
}
