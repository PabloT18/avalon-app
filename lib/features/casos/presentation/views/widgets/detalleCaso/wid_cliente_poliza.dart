import 'package:flutter/material.dart';

import 'package:shared_models/shared_models.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/shared/functions/fun_logic.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import '../wid_title_description.dart';

class ClientePolizaDetail extends StatelessWidget {
  const ClientePolizaDetail({
    super.key,
    required this.clientePoliza,
  });
  final ClientePoliza clientePoliza;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.secondaryBlue.withOpacity(0.4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppLayoutConst.cardBorderRadius),
      ),
      child: ExpansionTile(
        dense: true,
        childrenPadding: const EdgeInsets.all(AppLayoutConst.paddingL),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.centerLeft,
        title: Text(apptexts.segurosPage.detalleSeguro(n: 2)),
        subtitle: Text(clientePoliza.displayName ?? ' - '),
        children: [
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.segurosPage.aseguradora,
              value: clientePoliza.poliza?.aseguradora?.nombre ?? ' - '),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.segurosPage.polizaSeguros(n: 1),
              value: clientePoliza.poliza?.nombre ?? ' - '),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.segurosPage.tipoSeguro,
              value: clientePoliza.tipo ?? ' - '),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.segurosPage.initDate,
              value:
                  UtilsFunctionsLogic.formatFecha(clientePoliza.fechaInicio)),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.segurosPage.endDate,
              value: UtilsFunctionsLogic.formatFecha(clientePoliza.fechaFin)),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.appOptions.codigo,
              value: clientePoliza.codigo ?? ' - '),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.segurosPage.empresa,
              value: clientePoliza.empresa?.nombre ?? ' - '),
          TitleDescripcion(
              isSubdescription: true,
              title: apptexts.segurosPage.numeroCertificado,
              value: clientePoliza.numeroCertificado ?? ' - '),
        ],
      ),
    );
  }
}
