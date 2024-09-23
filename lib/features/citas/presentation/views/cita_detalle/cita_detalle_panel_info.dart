import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/features/citas/domain/models/requisitos_adicionales_entity.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';

import 'package:avalon_app/features/shared/functions/fun_logic.dart';

import 'package:avalon_app/features/citas/citas.dart';
import 'package:avalon_app/features/shared/widgets/wid_detail_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/wid_cita_detail_iamge.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class CitaDetalleMorePanel extends StatelessWidget {
  const CitaDetalleMorePanel({
    super.key,
    required this.citaMedica,
  });

  final CitaMedica citaMedica;

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    final locale = TranslationProvider.of(context).locale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          apptexts.citasPage.moreDetails(n: 2),
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
          label: apptexts.citasPage.detailFechaTentativa,
          value: UtilsFunctionsLogic.formatFechaLocal(
              citaMedica.fechaTentativa, locale.languageCode),
        ),
        DetailFormField(
            label: apptexts.citasPage.detailPreferenceCity,
            value: citaMedica.ciudadPreferencia),
        DetailFormField(
            label: apptexts.citasPage.detailAseguradoraName,
            value: citaMedica.clientePoliza?.poliza?.aseguradora?.nombre),
        DetailFormField(
          label: apptexts.citasPage.detailHospital,
          value: citaMedica.medicoCentroMedicoAseguradora?.centroMedico?.nombre,
        ),
        DetailFormField(
            label: apptexts.citasPage.detailPreferenceDoctor,
            value: citaMedica
                .medicoCentroMedicoAseguradora?.medico?.nombreCompleto),
        DetailFormField(
            label: apptexts.citasPage.detailPadecimeiento,
            value: citaMedica.padecimiento),
        DetailFormField(
            label: apptexts.citasPage.detailAditionalInformation,
            value: citaMedica.informacionAdicional),
        DetailRequisitosAdicionales(
          requisitos: citaMedica.requisitosAdicionales,
        ),
        DetailFormField(
            label: apptexts.citasPage.detailOthersRequaimentes,
            value: citaMedica.otrosRequisitos),
        if (citaMedica.imagenId != null)
          DetailPhoto(
            imageCode: citaMedica.imagenId!,
            user: user,
          ),
        const SizedBox(height: AppLayoutConst.spaceXL),
      ],
    );
  }
}

class DetailRequisitosAdicionales extends StatelessWidget {
  final RequisitosAdicionales? requisitos;

  const DetailRequisitosAdicionales({super.key, required this.requisitos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            apptexts.citasPage.detailAditionalRequaimentes,
          ),
          const SizedBox(height: AppLayoutConst.spaceM),
          _buildCheckboxRow(
              apptexts.citasPage.aditionalRequaimentes.ambulanciaTerrestre,
              requisitos?.ambTerrestre),
          _buildCheckboxRow(
              apptexts.citasPage.aditionalRequaimentes.recetaMedica,
              requisitos?.recetaMedica),
          _buildCheckboxRow(
              apptexts.citasPage.aditionalRequaimentes.ambulanciaAerea,
              requisitos?.ambAerea),
          _buildCheckboxRow(
              apptexts.citasPage.aditionalRequaimentes.sillaRuedas,
              requisitos?.sillaRuedas),
          _buildCheckboxRow(
              apptexts.citasPage.aditionalRequaimentes.servicioTransporte,
              requisitos?.serTransporte),
          _buildCheckboxRow(apptexts.citasPage.aditionalRequaimentes.viajes,
              requisitos?.viajes),
          _buildCheckboxRow(apptexts.citasPage.aditionalRequaimentes.hospedaje,
              requisitos?.hospedaje),
        ],
      ),
    );
  }

  Widget _buildCheckboxRow(String label, bool? value) {
    return Row(
      children: [
        Checkbox(
          value: value ?? false, // Si el valor es nulo, muestra como falso.
          onChanged: null, // Deshabilita la interacción si solo es informativo.
        ),
        Text(label),
      ],
    );
  }
}
