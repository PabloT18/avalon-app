import 'package:avalon_app/features/shared/widgets/wid_comentario_card.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_class.dart';

import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/detalle/bloc/reclamcaion_detalle_bloc.dart';

class ReclamacionDetalleHistoryPanel extends StatelessWidget {
  const ReclamacionDetalleHistoryPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final blocObjet = context.read<ReclamacionDetalleBloc>();

    if (blocObjet.state is! ReclamacionDetalleLoaded) return const SizedBox();

    if ((blocObjet.state as ReclamacionDetalleLoaded).comentarios == null) {
      blocObjet.add(const GetReclamacionHistorial());
    }
    final user = context.read<AppBloc>().state.user;

    // final currentstate = (blocObjet.state as ReclamacionDetalleLoaded);
    return BlocBuilder<ReclamacionDetalleBloc, ReclamacionDetalleState>(
      builder: (context, state) {
        final currentstate = (blocObjet.state as ReclamacionDetalleLoaded);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              apptexts.reclamacionesPage.historial(n: 2),
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
            if (currentstate.messageErrorLoadComentarios != null)
              MessageError(
                  message: currentstate.messageErrorLoadComentarios!,
                  onTap: () {
                    blocObjet.add(const GetReclamacionHistorial());
                  }),
            if (currentstate.comentarios == null &&
                currentstate.messageErrorLoadComentarios == null)
              const CircularProgressIndicatorCustom(),
            if (currentstate.comentarios != null &&
                currentstate.comentarios!.isEmpty)
              MessageError(
                  message: apptexts.appOptions.historialEmpty,
                  onTap: () {
                    blocObjet.add(const GetReclamacionHistorial());
                  }),
            if (currentstate.comentarios != null &&
                currentstate.comentarios!.isNotEmpty) ...[
              ...currentstate.comentarios!.map((comentario) {
                final userComent = user.id == comentario.usuarioComenta!.id;

                return ComentarioCard(
                  key: Key(comentario.hashCode.toString()),
                  comentario: comentario,
                  userComent: userComent,
                );
              }),
            ],
          ],
        );

        // const ComentarioTextBox(),
      },
    );
  }
}
