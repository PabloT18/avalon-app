import 'package:avalon_app/features/citas/presentation/views/widgets/wid_cita_detail_iamge.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/shared/functions/fun_logic.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:shared_models/shared_models.dart';

class ComentarioCard extends StatelessWidget {
  const ComentarioCard({
    super.key,
    required this.comentario,
    required this.userComent,
    required this.user,
  });

  final Comentario comentario;
  final bool userComent;
  final User user;

  @override
  Widget build(BuildContext context) {
    final locale = TranslationProvider.of(context).locale;

    return Padding(
      padding: EdgeInsets.only(
        left: userComent ? AppLayoutConst.paddingXL : AppLayoutConst.spaceZero,
        right: userComent ? AppLayoutConst.spaceZero : AppLayoutConst.paddingXL,
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
                if (!userComent)
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    UtilsFunctionsLogic.formatFechaHoraLocal(
                        comentario.createdDate, locale.languageCode),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
                if (comentario.imagenId != null)
                  DetailPhoto(
                    imageCode: comentario.imagenId!,
                    title: false,
                    user: user,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
