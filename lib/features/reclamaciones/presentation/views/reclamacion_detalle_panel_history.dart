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
              const SizedBox(
                height: 53,
              ),
            ],
          ],
        );

        // const ComentarioTextBox(),
      },
    );
  }
}

// class ComentarioCard extends StatelessWidget {
//   const ComentarioCard({
//     super.key,
//     required this.comentario,
//   });

//   final Comentario comentario;

//   @override
//   Widget build(BuildContext context) {
//     final locale = TranslationProvider.of(context).locale;

//     final user = context.read<AppBloc>().state.user;
//     final userComent = user.id == comentario.usuarioComenta!.id;
//     final responsive = ResponsiveCustom.of(context);
//     return Padding(
//       padding: EdgeInsets.only(
//         left: userComent ? AppLayoutConst.paddingXL : AppLayoutConst.spaceZero,
//         right: userComent ? AppLayoutConst.spaceZero : AppLayoutConst.paddingXL,
//       ),
//       child: Tooltip(
//         message:
//             '${apptexts.appOptions.fecha} ${UtilsFunctionsLogic.formatFechaLocal(comentario.createdDate!, locale.languageCode)}',
//         child: Card(
//           elevation: 1,
//           shape: RoundedRectangleBorder(
//             side: BorderSide(
//               color: AppColors.secondaryBlue.withOpacity(0.4),
//               width: 1,
//             ),
//             borderRadius: BorderRadius.circular(18),
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: userComent
//                   ? AppLayoutConst.paddingL
//                   : AppLayoutConst.paddingM,
//               right: userComent
//                   ? AppLayoutConst.paddingM
//                   : AppLayoutConst.paddingL,
//               bottom: AppLayoutConst.paddingM,
//               top: AppLayoutConst.paddingM,
//             ), // Agrega el padding similar a ListTile
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (!userComent)
//                   Align(
//                       alignment: userComent
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: RichText(
//                         text: TextSpan(
//                           text: comentario.usuarioComenta!.fullName,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodySmall!
//                               .copyWith(fontWeight: FontWeight.bold),
//                         ),
//                       )),
//                 RichText(
//                   text: TextSpan(
//                     text: comentario.contenido!,
//                     style: Theme.of(context).textTheme.bodySmall!,
//                   ),
//                 ),
//                 // if (comentario.imagenId != null)
//                 //   FullScreenImageFromId(
//                 //     key: Key(comentario.imagenId.toString()),
//                 //     user: user,
//                 //     imageCode: comentario.imagenId!,
//                 //   ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     UtilsFunctionsLogic.formatFechaHoraLocal(
//                         comentario.createdDate, locale.languageCode),
//                     style: const TextStyle(
//                       fontSize: 10,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
