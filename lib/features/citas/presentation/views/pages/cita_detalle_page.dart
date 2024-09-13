import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/features/citas/citas.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_models/shared_models.dart';

import '../../bloc/cita/cita_detalle_bloc.dart';
import '../widgets/cita_card.dart';

class CitaDetallePage extends StatelessWidget {
  const CitaDetallePage({super.key, this.cita});

  final CitaMedica? cita;

  @override
  Widget build(BuildContext context) {
    final String? citaId = GoRouterState.of(context).pathParameters['citaId'];
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => CitaDetalleBloc(user, cita: cita),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.citasPage.casoDetalle(n: 1)),
        elevation: 6,
      ),
      body: BlocBuilder<CitaDetalleBloc, CitaDetalleState>(
        builder: (context, state) {
          return SmartRefrehsCustom(
              key: const Key('__caso_detalle_key__'),
              onRefresh: () async {
                // casoBloc.add(const GetCasosUser());
              },
              refreshController: citaDetalleBloc.refreshController,
              child: getChildByState(state, citaDetalleBloc, context));
        },
      ),
    );
  }

  Widget getChildByState(CitaDetalleState state,
      CitaDetalleBloc citaDetalleBloc, BuildContext context) {
    return switch (state) {
      CitaDetalleInitial() => const Center(child: CircularProgressIndicator()),
      CitaDetalleError() => MessageError(
          message: state.message,
          onTap: () {
            // casoBloc.add(const GetCasosUser());
          }),
      CitaDetalleLoaded() => Column(children: [
          Hero(
            tag: state.cita.hashCode,
            child: CitaCard(
              cita: state.cita,
              isClient: user.isClient,
            ),
          ),
        ])
    };
  }
}
