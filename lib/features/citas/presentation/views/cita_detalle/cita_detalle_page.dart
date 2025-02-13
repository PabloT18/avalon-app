import 'package:avalon_app/features/citas/presentation/bloc/cita_detalle/cubit/comentario_nuev_cubit.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';

import 'package:flutter/material.dart';

import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';

import 'package:avalon_app/features/citas/citas.dart';

import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:shared_models/shared_models.dart';

import '../../bloc/cita_detalle/cita_detalle_bloc.dart';
import '../../bloc/cita_detalle/cita_detalle_panels_cubit.dart';
import '../widgets/cita_card.dart';
import '../widgets/comentario_tex_field.dart';
import '../widgets/wid_cita_detail_panel_button.dart';
import 'cita_detalle_panel_history.dart';
import 'cita_detalle_panel_info.dart';

class CitaDetallePage extends StatelessWidget {
  const CitaDetallePage({super.key, this.cita});

  final CitaMedica? cita;

  @override
  Widget build(BuildContext context) {
    final String? citaId = GoRouterState.of(context).pathParameters['citaId'];
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CitaDetalleBloc(user, cita: cita),
        ),
        BlocProvider(
          create: (context) => CitaDetallePanelsCubit(),
        ),
      ],
      child: CitaDetalleView(citaId: citaId, user: user),
    );
  }
}

class CitaDetalleView extends StatelessWidget {
  const CitaDetalleView({
    super.key,
    required this.citaId,
    required this.user,
  });

  final String? citaId;
  final User user;

  @override
  Widget build(BuildContext context) {
    final citaDetalleBloc = context.read<CitaDetalleBloc>();

    // Maneja el espacio del teclado

    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.citasPage.citaDetalle(n: 1)),
        elevation: 6,
      ),
      body: BlocBuilder<CitaDetalleBloc, CitaDetalleState>(
        builder: (context, stateCitaDetalle) {
          return switch (stateCitaDetalle) {
            CitaDetalleInitial() => const CircularProgressIndicatorCustom(),
            CitaDetalleError() => MessageError(
                message: stateCitaDetalle.message,
                onTap: () {
                  //TODO: ddescargar la cita del id
                  // casoBloc.add(const GetCasosUser());
                }),
            CitaDetalleLoaded() => BlocProvider(
                create: (context) => ComentarioNuevCubit(
                      citasRepository: citaDetalleBloc.citasRepository,
                      user: context.read<AppBloc>().state.user,
                      citaId:
                          (citaDetalleBloc.state as CitaDetalleLoaded).cita.id!,
                    ),
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<CitaDetallePanelsCubit,
                          CitaDetallePanelsState>(
                        builder: (context, statePanels) {
                          return SmartRefrehsCustom(
                              key: const Key('__caso_detalle_historial_key__'),
                              onRefresh: () async {
                                citaDetalleBloc.add(const GetCitaHistorial());
                                citaDetalleBloc.refreshController
                                  ..loadFailed()
                                  ..refreshCompleted();
                              },
                              refreshController:
                                  citaDetalleBloc.refreshController,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      AppLayoutConst.paddingL),
                                  child: Column(
                                    children: [
                                      Hero(
                                        tag: stateCitaDetalle.cita.hashCode,
                                        child: CitaCard(
                                          cita: stateCitaDetalle.cita,
                                          isClient: user.isClient,
                                        ),
                                      ),
                                      const SizedBox(
                                          height: AppLayoutConst.spaceL),
                                      Wrap(
                                        alignment: WrapAlignment.spaceEvenly,
                                        spacing: AppLayoutConst.spaceL,
                                        runSpacing: AppLayoutConst.spaceL,
                                        children: [
                                          CitaOptionButton(
                                            option: const CitaDetalleInfo(),
                                            optionSelected: statePanels,
                                            title: apptexts.citasPage
                                                .details(n: 1),
                                          ),
                                          CitaOptionButton(
                                            option:
                                                const CitaDetalleHistorial(),
                                            optionSelected: statePanels,
                                            title: apptexts.citasPage
                                                .seguimiento(n: 1),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                          height: AppLayoutConst.spaceL),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppLayoutConst.spaceM),
                                        child: statePanels.index == 0
                                            ? CitaDetalleMorePanel(
                                                citaMedica:
                                                    stateCitaDetalle.cita)
                                            : const CitaDetalleHistoryPanel(),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),
                    ),
                    BlocBuilder<CitaDetallePanelsCubit, CitaDetallePanelsState>(
                      builder: (context, state) {
                        if (state.index == 0) return const SizedBox();

                        // return const ComentarioCitaTextBox();
                        return const SafeArea(child: ComentarioCitaTextBox());
                      },
                    ),
                  ],
                )),
          };
        },
      ),
    );
  }
}
