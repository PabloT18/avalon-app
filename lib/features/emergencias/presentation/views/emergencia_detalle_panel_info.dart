import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/features/citas/presentation/views/widgets/wid_cita_detail_iamge.dart';
import 'package:avalon_app/features/emergencias/emergencias.dart';
import 'package:avalon_app/features/shared/widgets/wid_detail_form_field.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DetalleMorePanel extends StatelessWidget {
  const DetalleMorePanel({
    super.key,
    required this.emergencia,
  });

  final EmergenciaModel emergencia;

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    // final locale = TranslationProvider.of(context).locale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          apptexts.emergenciasPage.moreDetails(n: 2),
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
        // DetailFormField(
        //   label: apptexts.citasPage.detailFechaTentativa,
        //   value: UtilsFunctionsLogic.formatFechaLocal(
        //       emergencia.diagnostico, locale.languageCode),
        // ),
        DetailFormField(
            label: apptexts.emergenciasPage.diagnostico,
            value: emergencia.diagnostico),
        DetailFormField(
            label: apptexts.emergenciasPage.sintomas,
            value: emergencia.sintomas),
        DetailFormField(
            label: apptexts.citasPage.detailAseguradoraName,
            value: emergencia.clientePoliza?.poliza?.aseguradora?.nombre),
        DetailFormField(
            label: apptexts.segurosPage.polizaSeguros(n: 1),
            value: emergencia.clientePoliza?.poliza?.nombre),
        DetailFormField(
          label: apptexts.citasPage.detailHospital,
          value: emergencia.medicoCentroMedicoAseguradora?.centroMedico?.nombre,
        ),
        DetailFormField(
            label: apptexts.citasPage.detailPreferenceDoctor,
            value: emergencia
                .medicoCentroMedicoAseguradora?.medico?.nombreCompleto),
        // DetailFormField(
        //     label: apptexts.citasPage.detailPadecimeiento,
        //     value: emergencia.padecimiento),

        // DetailFormField(
        //     label: apptexts.citasPage.detailOthersRequaimentes,
        //     value: emergencia.otrosRequisitos),
        if (emergencia.imagenId != null)
          DetailPhotoFile(
            imageCode: emergencia.imagenId!,
            user: user,
          ),
        const SizedBox(height: AppLayoutConst.spaceXL),
      ],
    );
  }
}
