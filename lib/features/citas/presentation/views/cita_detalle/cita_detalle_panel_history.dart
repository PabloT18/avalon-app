import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/features/citas/presentation/bloc/cita_detalle/cita_detalle_bloc.dart';

import 'package:avalon_app/features/shared/functions/utils_functions.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

import '../widgets/wid_image_id.dart';

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

    return BlocBuilder<CitaDetalleBloc, CitaDetalleState>(
      builder: (context, state) {
        final state = (blocObjet.state as CitaDetalleLoaded);

        return Column(
          children: [
            Expanded(
              child: SmartRefrehsCustom(
                key: const Key('__caso_detalle_historial_key__'),
                onRefresh: () async {
                  blocObjet.add(const GetCitaHistorial());
                  blocObjet.refreshController
                    ..loadFailed()
                    ..refreshCompleted();
                },
                refreshController: blocObjet.refreshController,
                child: SingleChildScrollView(
                  // padding: const EdgeInsets.all(AppLayoutConst.paddingL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        apptexts.citasPage.historial(n: 2),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: AppLayoutConst.marginM,
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
                      if (state.comentarios != null &&
                          state.comentarios!.isEmpty)
                        MessageError(
                            message: apptexts.appOptions.historialEmpty,
                            onTap: () {
                              blocObjet.add(const GetCitaHistorial());
                            }),
                      if (state.comentarios != null &&
                          state.comentarios!.isNotEmpty) ...[
                        ...state.comentarios!.map(
                          (comentario) =>
                              ComentarioCard(comentario: comentario),
                        ),
                        const SizedBox(
                          height: 53,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            // const ComentarioTextBox(),
          ],
        );
      },
    );
  }
}

class ComentarioCard extends StatelessWidget {
  const ComentarioCard({
    super.key,
    required this.comentario,
  });

  final Comentario comentario;

  @override
  Widget build(BuildContext context) {
    final locale = TranslationProvider.of(context).locale;

    final user = context.read<AppBloc>().state.user;
    final userComent = user.id == comentario.usuarioComenta!.id;
    return Padding(
      padding: EdgeInsets.only(
        left: userComent ? AppLayoutConst.paddingL : AppLayoutConst.spaceZero,
        right: userComent ? AppLayoutConst.spaceZero : AppLayoutConst.paddingL,
      ),
      child: Tooltip(
        message:
            '${apptexts.appOptions.fecha} ${UtilsFunctionsLogic.formatFechaLocal(comentario.createdDate!, locale.languageCode)}',
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColors.secondaryBlue.withOpacity(0.4),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: userComent
                  ? AppLayoutConst.paddingL
                  : AppLayoutConst.paddingM,
              right: userComent
                  ? AppLayoutConst.paddingM
                  : AppLayoutConst.paddingL,
              bottom: AppLayoutConst.paddingM,
              top: AppLayoutConst.paddingM,
            ), // Agrega el padding similar a ListTile
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: userComent
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: comentario.usuarioComenta!.fullName,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    )),
                RichText(
                  text: TextSpan(
                    text: comentario.contenido!,
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                ),
                if (comentario.imagenId != null)
                  FullScreenImageFromId(
                    user: user,
                    imageCode: comentario.imagenId!,
                  ),
                Align(
                  alignment: !userComent
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(
                    UtilsFunctionsLogic.formatFechaHoraLocal(
                        comentario.createdDate, locale.languageCode),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
