import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';

import 'package:avalon_app/features/citas/presentation/views/widgets/cita_card.dart';
import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:avalon_app/features/casos/presentation/bloc/detallecaso/detallecaso_bloc.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';

class CitasDetalleBox extends StatelessWidget {
  const CitasDetalleBox({
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
                apptexts.citasPage.citaDetalle(n: 2),
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
              } else if (state.erroCitas != null) {
                return MessageError(
                    message: apptexts.appOptions.noData,
                    onTap: () {
                      detalleCasoBloc.add(const CDGetCitas());
                    });
              } else if (state.citas == null) {
                return const Center(child: CircularProgressIndicatorCustom());
              }

              if (state.citas!.isEmpty) {
                return MessageError(
                    message: apptexts.appOptions.noData,
                    onTap: () {
                      detalleCasoBloc.add(const CDGetCitas());
                    });
              } else {
                return Expanded(
                    child: ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppLayoutConst.paddingL),
                        children: [
                      ...state.citas!.map(
                        (cita) => Hero(
                          tag: cita.hashCode,
                          child: CitaCard(
                            navigatePush: true,
                            cita: cita,
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
