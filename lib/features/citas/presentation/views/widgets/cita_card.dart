import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';

import 'package:avalon_app/features/casos/presentation/views/widgets/wid_title_description.dart';
import 'package:avalon_app/features/citas/citas.dart';

class CitaCard extends StatelessWidget {
  const CitaCard(
      {super.key,
      required this.cita,
      required this.isClient,
      this.navigatePush = false});

  final CitaMedica cita;
  final bool isClient;
  final bool navigatePush;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.secondaryBlue.withOpacity(0.4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppLayoutConst.cardBorderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppLayoutConst.cardBorderRadius),
        child: InkWell(
          onTap: () {
            if (!navigatePush) {
              context.goNamed(
                PAGES.detalleCita.pageName,
                pathParameters: {
                  'citaId': cita.id?.toString() ?? '',
                },
                extra: cita,
              );
            } else {
              context.pushNamed(
                PAGES.detalleCita.pageName,
                pathParameters: {
                  'citaId': cita.id?.toString() ?? '',
                },
                extra: cita,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0), // Agrega el padding similar a ListTile
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isClient)
                        TitleDescripcion(
                          isSubdescription: true,
                          title: apptexts.appOptions.cliente,
                          value: cita.clientePoliza!.cliente!.fullName,
                        ),
                      // TitleDescripcion(
                      //   isSubdescription: true,
                      //   title: apptexts.segurosPage.polizaSeguros(n: 1),
                      //   value: cita.clientePoliza!.displayName!,
                      // ),
                      TitleDescripcion(
                        isSubdescription: true,
                        title: apptexts.citasPage.detailSintoma,
                        value: cita.padecimiento ?? '',
                      ),
                      TitleDescripcion(
                        isSubdescription: true,
                        title: apptexts.citasPage.estados,
                        value: UtilsFunctionsViews.getStateStrinByState(
                            cita.estado ?? ''),
                      ),
                      // TitleDescripcion(
                      //   isSubdescription: true,
                      //   title: '${apptexts.casosPage.title(n: 1)} Id',
                      //   value: cita.caso?.codigo ?? '',
                      // ),
                      TitleDescripcion(
                        isSubdescription: true,
                        title: apptexts.citasPage.title(n: 1),
                        value: cita.codigo!,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: AppLayoutConst.dotSize, // Tamaño del círculo
                  height: AppLayoutConst.dotSize,
                  decoration: BoxDecoration(
                    color:
                        UtilsFunctionsViews.getColorByState(cita.estado ?? ''),
                    shape: BoxShape.circle,
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
