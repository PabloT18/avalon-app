import 'package:avalon_app/features/shared/widgets/wid_comentario_card.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/features/citas/presentation/bloc/cita_detalle/cita_detalle_bloc.dart';

import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_models/shared_models.dart';

class CitaDetalleHistoryPanel extends StatelessWidget {
  const CitaDetalleHistoryPanel({
    super.key,
    this.comentarios,
  });

  final List<Comentario>? comentarios;

  @override
  Widget build(BuildContext context) {
    final blocObjet = context.read<CitaDetalleBloc>();

    if (blocObjet.state is! CitaDetalleLoaded) return const SizedBox();
    final user = context.read<AppBloc>().state.user;
    return BlocBuilder<CitaDetalleBloc, CitaDetalleState>(
      builder: (context, state) {
        final state = (blocObjet.state as CitaDetalleLoaded);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              apptexts.citasPage.historial(n: 1),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: AppLayoutConst.marginXS,
              ),
              height: 1,
              color: AppColors.secondaryBlue.withOpacity(0.5),
            ),
            if (state.messageErrorLoadComentarios != null)
              MessageError(
                  message: state.messageErrorLoadComentarios!,
                  onTap: () {
                    blocObjet.add(const GetCitaHistorial());
                  }),
            if (state.comentarios == null &&
                state.messageErrorLoadComentarios == null)
              const CircularProgressIndicatorCustom(),
            if (state.comentarios != null && state.comentarios!.isEmpty)
              MessageError(
                  message: apptexts.appOptions.historialEmpty,
                  onTap: () {
                    blocObjet.add(const GetCitaHistorial());
                  }),
            if (state.comentarios != null && state.comentarios!.isNotEmpty) ...[
              ...state.comentarios!.map((comentario) {
                final userComent = user.id == comentario.usuarioComenta!.id;

                return ComentarioCard(
                  key: Key(comentario.hashCode.toString()),
                  comentario: comentario,
                  userComent: userComent,
                  user: user,
                );
              }),
              // const SizedBox(
              //   height: 10,
              // ),
            ],
          ],
        );

        // const ComentarioTextBox(),
      },
    );
  }
}
