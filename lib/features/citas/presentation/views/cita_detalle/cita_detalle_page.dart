import 'package:avalon_app/features/citas/presentation/bloc/cita_detalle/cubit/comentario_nuev_cubit.dart';
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
    final citaDetallePanelsCubit = context.read<CitaDetallePanelsCubit>();
    final bottomPadding = MediaQuery.of(context)
        .viewInsets
        .bottom; // Maneja el espacio del teclado

    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.citasPage.citaDetalle(n: 1)),
        elevation: 6,
      ),
      resizeToAvoidBottomInset: true,
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
                  citaId: (citaDetalleBloc.state as CitaDetalleLoaded).cita.id!,
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppLayoutConst.paddingL),
                      child: Column(
                        children: [
                          Hero(
                            tag: stateCitaDetalle.cita.hashCode,
                            child: CitaCard(
                              cita: stateCitaDetalle.cita,
                              isClient: user.isClient,
                            ),
                          ),
                          const SizedBox(height: AppLayoutConst.spaceL),
                          BlocBuilder<CitaDetallePanelsCubit,
                              CitaDetallePanelsState>(
                            builder: (context, state) {
                              return Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                spacing: AppLayoutConst.spaceL,
                                runSpacing: AppLayoutConst.spaceL,
                                children: [
                                  CitaOptionButton(
                                      option: const CitaDetalleInfo(),
                                      optionSelected: state),
                                  CitaOptionButton(
                                      option: const CitaDetalleHistorial(),
                                      optionSelected: state),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: AppLayoutConst.spaceL),
                          Expanded(
                            child: PageView(
                              controller: citaDetallePanelsCubit.pageController,
                              onPageChanged:
                                  citaDetallePanelsCubit.onPageChanged,
                              children: <Widget>[
                                CitaDetalleMorePanel(
                                    citaMedica: stateCitaDetalle.cita),
                                const CitaDetalleHistoryPanel(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: BlocBuilder<CitaDetallePanelsCubit,
                          CitaDetallePanelsState>(
                        builder: (context, state) {
                          if (state.index == 0) return const SizedBox();

                          return Container(
                              color: Colors.white,
                              child: const ComentarioTextBox());
                        },
                      ),
                    ),
                  ],
                ),
              )
          };
        },
      ),
    );
  }
}
