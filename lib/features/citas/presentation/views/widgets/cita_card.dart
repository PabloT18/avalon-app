import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';

import 'package:avalon_app/features/casos/presentation/views/widgets/wid_title_description.dart';
import 'package:avalon_app/features/citas/citas.dart';

class CitaCard extends StatelessWidget {
  const CitaCard({super.key, required this.cita, required this.isClient});

  final CitaMedica cita;
  final bool isClient;

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
          context.goNamed(
            PAGES.detalleCita.pageName,
            pathParameters: {
              'citaId': cita.id?.toString() ?? '',
            },
            extra: cita,
          );
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
                        value: cita.clientePoliza!.displayName!,
                      ),
                    TitleDescripcion(
                      isSubdescription: true,
                      title: apptexts.citasPage.estados,
                      value: getStateStrinByState(cita.estado ?? ''),
                    ),
                    TitleDescripcion(
                      isSubdescription: true,
                      title: '${apptexts.citasPage.title(n: 1)} Id',
                      value: cita.codigo!,
                    ),
                    TitleDescripcion(
                      isSubdescription: true,
                      title: apptexts.appOptions.detalle(n: 1),
                      value: cita.padecimiento!,
                    ),
                  ],
                ),
              ),
              Container(
                width: 15, // Tamaño del círculo
                height: 15,
                decoration: BoxDecoration(
                  color: getColorByState(cita.estado ?? ''),
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
      case 'POR GESTIONAR' || "P":
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
      case 'POR GESTIONAR' || "P":
        return apptexts.citasPage.estadoPorGestionar;
      default:
        return ' - ';
    }
  }
}
