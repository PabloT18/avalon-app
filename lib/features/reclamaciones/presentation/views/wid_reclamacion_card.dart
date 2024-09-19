import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/casos/presentation/views/widgets/wid_title_description.dart';

import 'package:avalon_app/features/reclamaciones/data/models/reclamaciones_response.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

class ReclamacionCard extends StatelessWidget {
  const ReclamacionCard(
      {super.key,
      required this.reclamacion,
      required this.isClient,
      this.navigatePush = false});

  final ReclamacionModel reclamacion;
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
      child: InkWell(
        onTap: () {
          if (!navigatePush) {
            context.goNamed(
              PAGES.reclamacionDetalle.pageName,
              pathParameters: {
                'reclamacionId': reclamacion.id?.toString() ?? '',
              },
              extra: reclamacion,
            );
          } else {
            context.pushNamed(
              PAGES.reclamacionDetalle.pageName,
              pathParameters: {
                'reclamacionId': reclamacion.id?.toString() ?? '',
              },
              extra: reclamacion,
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
                        title: apptexts.appOptions.cliente,
                        value: reclamacion.clientePoliza!.displayName!,
                      ),
                    TitleDescripcion(
                      isSubdescription: true,
                      title: apptexts.reclamacionesPage.detailPadecimeiento,
                      value: reclamacion.padecimientoDiagnostico!,
                    ),
                    TitleDescripcion(
                      isSubdescription: true,
                      title: '${apptexts.reclamacionesPage.title(n: 1)} Id',
                      value: reclamacion.codigo!,
                    ),
                    TitleDescripcion(
                      isSubdescription: true,
                      title: apptexts.reclamacionesPage.estado,
                      value: getStateStrinByState(reclamacion.estado ?? ''),
                    ),
                  ],
                ),
              ),
              Container(
                width: 10, // Tamaño del círculo
                height: 10,
                decoration: BoxDecoration(
                  color: getColorByState(reclamacion.estado ?? ''),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getColorByState(String state) {
    switch (state.toUpperCase()) {
      case 'CERRADO' || "C":
        return Colors.red;
      case 'GESTIONANDO' || "G":
        return Colors.blue;
      case 'POR GESTIONAR' || "P" || "N":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String getStateStrinByState(String state) {
    switch (state.toUpperCase()) {
      case 'CERRADO' || "C":
        return apptexts.citasPage.estadoCerrado;
      case 'GESTIONANDO' || "G":
        return apptexts.citasPage.estadoGestionando;
      case 'POR GESTIONAR' || "P" || "N":
        return apptexts.citasPage.estadoPorGestionar;
      default:
        return ' - ';
    }
  }
}
