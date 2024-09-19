import 'package:flutter/material.dart';

import 'package:shared_models/shared_models.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import '../wid_title_description.dart';

class ClienteDetailCard extends StatelessWidget {
  const ClienteDetailCard({
    super.key,
    required this.cliente,
    this.parentesco,
  });
  final UsrCliente cliente;
  final String? parentesco;
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
        title: Text(apptexts.segurosPage.clienteDetalle(n: 1)),
        subtitle: Text(cliente.nombreUsuario ?? ' - '),
        // subtitle: ,
        children: [
          if (parentesco != null)
            TitleDescripcion(
                isSubdescription: true,
                title: apptexts.perfilPage.memberFamily,
                value: parentesco!),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.perfilPage.fullName,
              value: cliente.fullName),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.perfilPage.correo,
              value: cliente.correoElectronico ?? ' - '),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.perfilPage.dob,
              value: cliente.formattedFechaNacimiento),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.perfilPage.identificacion,
              value: cliente.numeroIdentificacion ?? ' - '),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.perfilPage.tipoIdentificacion,
              value: cliente.tipoIdentificacion ?? ' - '),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.perfilPage.phone,
              value: cliente.tipoIdentificacion ?? ' - '),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.perfilPage.address,
              value: cliente.direccion?.direccionCompleta ?? ' - '),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.perfilPage.city,
              value: cliente.direccion?.ciudad ?? ' - '),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.perfilPage.state,
              value: cliente.direccion?.estadoNombreCompleto ?? ' - '),
        ],
      ),
    );
  }
}
