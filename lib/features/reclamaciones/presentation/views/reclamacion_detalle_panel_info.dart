import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/features/citas/presentation/views/widgets/wid_cita_detail_iamge.dart';

import 'package:avalon_app/features/reclamaciones/data/models/reclamaciones_response.dart';
import 'package:avalon_app/features/shared/functions/fun_logic.dart';
import 'package:avalon_app/features/shared/widgets/wid_detail_form_field.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/nuevareclamcacion/reclamacion_nueva_bloc.dart';

class ReclacmaionDetalleMorePanel extends StatelessWidget {
  const ReclacmaionDetalleMorePanel({
    super.key,
    required this.reclamacion,
  });

  final ReclamacionModel reclamacion;

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    final locale = TranslationProvider.of(context).locale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetalleClientePoliza(
          reclamacion: reclamacion,
        ),
        const SizedBox(height: AppLayoutConst.spaceM),
        Text(
          apptexts.reclamacionesPage.moreDetails(n: 2),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppLayoutConst.marginXS,
          ).copyWith(bottom: AppLayoutConst.marginM),
          height: 1,
          color: AppColors.secondaryBlue.withOpacity(0.5),
        ),

        DetailFormField(
            colorGray: true,
            label: apptexts.reclamacionesPage.detailAseguradoraName,
            value: reclamacion.clientePoliza?.poliza?.aseguradora?.nombre),
        DetailFormField(
            colorGray: true,
            label: apptexts.reclamacionesPage.reclamcionDate,
            value: reclamacion.fechaServicio != null
                ? UtilsFunctionsLogic.formatFechaLocal(
                    reclamacion.fechaServicio!, locale.languageCode)
                : ' - '),
        DetailFormField(
          colorGray: true,
          label: apptexts.citasPage.detailHospital,
          value:
              reclamacion.medicoCentroMedicoAseguradora?.centroMedico?.nombre,
        ),
        DetailFormField(
            colorGray: true,
            label: apptexts.citasPage.detailPreferenceDoctor,
            value: reclamacion
                .medicoCentroMedicoAseguradora?.medico?.nombreCompleto),

        DetailFormField(
            colorGray: true,
            label: apptexts.reclamacionesPage.tipoAdministacion,
            value: getTipoAdmi(reclamacion.tipoAdm)),

        DetailFormField(
            colorGray: true,
            label: apptexts.reclamacionesPage.detailPadecimientoDiagnostico,
            value: reclamacion.padecimientoDiagnostico),
        DetailFormField(
            colorGray: true,
            label: apptexts.reclamacionesPage.detailAditionalInformation,
            value: reclamacion.infoAdicional),

        // DetailFormField(
        //   label: apptexts.reclamacionesPage.reclamcionDate,
        //   value: UtilsFunctionsLogic.formatFechaLocal(
        //       reclamacion.fechaServicio, locale.languageCode),
        // ),

        // DetailFormField(
        //     label: apptexts.reclamacionesPage.detailAseguradoraName,
        //     value: reclamacion.clientePoliza?.poliza?.aseguradora?.nombre),
        // DetailFormField(
        //     label: apptexts.segurosPage.polizaSeguros(n: 1),
        //     value: reclamacion.clientePoliza?.poliza?.nombre),
        // DetailFormField(
        //   label: apptexts.reclamacionesPage.detailHospital,
        //   value:
        //       reclamacion.medicoCentroMedicoAseguradora?.centroMedico?.nombre,
        // ),
        // DetailFormField(
        //     label: apptexts.reclamacionesPage.detailPreferenceDoctor,
        //     value: reclamacion
        //         .medicoCentroMedicoAseguradora?.medico?.nombreCompleto),

        // DetailFormField(
        //     label: apptexts.reclamacionesPage.detailOthersRequaimentes,
        //     value: reclamacion.otrosRequisitos),
        if (reclamacion.imagenId != null)
          DetailPhotoFile(
            imageCode: reclamacion.imagenId!,
            user: user,
          ),
        const SizedBox(height: AppLayoutConst.spaceXL),
      ],
    );
  }

  String getTipoAdmi(String? tipoAd) {
    if (tipoAd == null) {
      return '-';
    } else if (tipoAd == tipoProgramada) {
      return apptexts.reclamacionesPage.tiposAdministacion.tipoProgramada;
    } else if (tipoAd == tipoEmergencia) {
      return apptexts.reclamacionesPage.tiposAdministacion.tipoEmergenciaa;
    } else if (tipoAd == tipoNoProgramada) {
      return apptexts.reclamacionesPage.tiposAdministacion.tipoNoProgramada;
    } else {
      return ' - ';
    }
  }
}

class DetalleClientePoliza extends StatelessWidget {
  const DetalleClientePoliza({
    super.key,
    required this.reclamacion,
  });

  final ReclamacionModel reclamacion;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          apptexts.segurosPage.polizaSeguros(n: 1),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppLayoutConst.marginXS,
          ).copyWith(bottom: AppLayoutConst.marginM),
          height: 1,
          color: AppColors.secondaryBlue.withOpacity(0.5),
        ),
        DetailFormField(
            padding: AppLayoutConst.spaceS,
            colorGray: true,
            value: reclamacion.clientePoliza!.cliente!.nombreUsuario),
        DetailFormField(
            padding: AppLayoutConst.spaceS,
            colorGray: true,
            value: reclamacion.clientePoliza!.displayName),
        DetailFormField(
            padding: AppLayoutConst.spaceS,
            colorGray: true,
            value: reclamacion.caso!.displayName),
      ],
    );
  }
}
