import 'package:flutter/material.dart';

import 'package:shared_models/shared_models.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import '../wid_title_description.dart';

class AsesorDetailCard extends StatelessWidget {
  const AsesorDetailCard({
    super.key,
    required this.asesor,
  });
  final UsrAsesor asesor;

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
      child: ExpansionTile(
        dense: true,

        childrenPadding: const EdgeInsets.all(AppLayoutConst.paddingL)
            .copyWith(top: AppLayoutConst.spaceS),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.centerLeft,
        title: Text(apptexts.segurosPage.asesosDetalle(n: 1)),
        subtitle: Text(asesor.nombreUsuario ?? ' - '),
        // subtitle: ,
        children: [
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.perfilPage.fullName,
              value: asesor.fullName),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.perfilPage.correo,
              value: asesor.correoElectronico ?? ' - '),

          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.perfilPage.phone,
              value: asesor.tipoIdentificacion ?? ' - '),
          // TitleDescripcion(
          //     isSubdescription: true,
          //     title: apptexts.perfilPage.address,
          //     value: agente.direccion?.direccionCompleta ?? ' - '),
          // TitleDescripcion(
          //     isSubdescription: true,
          //     title: apptexts.perfilPage.city,
          //     value: agente.direccion?.ciudad ?? ' - '),
          // TitleDescripcion(
          //     isSubdescription: true,
          //     title: apptexts.perfilPage.state,
          //     value: agente.direccion?.estadoNombreCompleto ?? ' - '),
        ],
      ),
    );
  }
}
