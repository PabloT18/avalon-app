import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/casos/presentation/views/widgets/wid_title_description.dart';
import 'package:avalon_app/features/emergencias/emergencias.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

class EmergenciaCard extends StatelessWidget {
  const EmergenciaCard(
      {super.key,
      required this.emergenciaModel,
      required this.isClient,
      this.navigatePush = false});

  final EmergenciaModel emergenciaModel;
  final bool isClient;
  final bool navigatePush;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
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
                PAGES.emergenciaDetalle.pageName,
                pathParameters: {
                  'emergenciaId': emergenciaModel.id?.toString() ?? '',
                },
                extra: emergenciaModel,
              );
            } else {
              context.pushNamed(
                PAGES.emergenciaDetalle.pageName,
                pathParameters: {
                  'emergenciaId': emergenciaModel.id?.toString() ?? '',
                },
                extra: emergenciaModel,
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
                          value:
                              emergenciaModel.clientePoliza!.cliente!.fullName,
                        ),
                      // TitleDescripcion(
                      //   isSubdescription: true,
                      //   title: apptexts.casosPage.title(n: 1),
                      //   value: emergenciaModel.caso!.codigo!,
                      // ),
                      // TitleDescripcion(
                      //   isSubdescription: true,
                      //   title: apptexts.emergenciasPage.title(n: 1),
                      //   value: emergenciaModel.codigo!,
                      // ),
                      // TitleDescripcion(
                      //   isSubdescription: true,
                      //   title: apptexts.appOptions.cliente,
                      //   value: emergenciaModel.clientePoliza!.displayName!,
                      // ),
                      TitleDescripcion(
                        isSubdescription: true,
                        title: apptexts.emergenciasPage.sintomas,
                        value: emergenciaModel.sintomas!,
                      ),
                      TitleDescripcion(
                        isSubdescription: true,
                        title: apptexts.emergenciasPage.estado,
                        value: UtilsFunctionsViews.getStateStrinByState(
                            emergenciaModel.estado ?? ''),
                      ),
                      TitleDescripcion(
                        isSubdescription: true,
                        title: apptexts.emergenciasPage.title(n: 1),
                        value: emergenciaModel.codigo!,
                      ),
                      // TitleDescripcion(
                      //   isSubdescription: true,
                      //   title: apptexts.appOptions.detalle(n: 1),
                      //   value: emergenciaModel.padecimiento!,
                      // ),
                    ],
                  ),
                ),
                Container(
                  width: AppLayoutConst.dotSize, // Tamaño del círculo
                  height: AppLayoutConst.dotSize,
                  decoration: BoxDecoration(
                    color: UtilsFunctionsViews.getColorByState(
                        emergenciaModel.estado ?? ''),
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
