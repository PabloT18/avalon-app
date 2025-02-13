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
import 'package:shared_models/shared_models.dart';

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
        DetalleClientePoliza(
          citaMedica: citaMedica,
        ),
        const SizedBox(height: AppLayoutConst.spaceM),
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
            colorGray: true,
            label: apptexts.citasPage.tipoCita,
            value: citaMedica.tipoCitaMedica),
        DetailFormField(
          colorGray: true,
          label: apptexts.citasPage.detailFechaTentativaDesde,
          value: UtilsFunctionsLogic.formatFechaLocal(
              citaMedica.fechaTentativa, locale.languageCode),
        ),
        DetailFormField(
          colorGray: true,
          label: apptexts.citasPage.detailFechaTentativaHasta,
          value: UtilsFunctionsLogic.formatFechaLocal(
              citaMedica.fechaTentativa, locale.languageCode),
        ),
        DetailFormField(
            colorGray: true,
            label: apptexts.citasPage.detailPreferenceCity,
            value: citaMedica.ciudadPreferencia),
        DetailFormField(
            colorGray: true,
            label: apptexts.citasPage.detailAseguradoraName,
            value: citaMedica.clientePoliza?.poliza?.aseguradora?.nombre),
        DetailFormField(
          colorGray: true,
          label: apptexts.citasPage.detailHospital,
          value: citaMedica.medicoCentroMedicoAseguradora?.centroMedico?.nombre,
        ),
        DetailFormField(
            colorGray: true,
            label: apptexts.citasPage.detailPreferenceDoctor,
            value: citaMedica
                .medicoCentroMedicoAseguradora?.medico?.nombreCompleto),
        DetailFormField(
            colorGray: true,
            label: apptexts.citasPage.detailSintoma(n: 2),
            value: citaMedica.padecimiento),
        DetailFormField(
            colorGray: true,
            label: apptexts.citasPage.detailAditionalInformation,
            value: citaMedica.informacionAdicional),
        DetailRequisitosAdicionales(
          requisitos: citaMedica.requisitosAdicionales,
        ),
        DetailFormField(
            colorGray: true,
            label: apptexts.citasPage.detailOthersRequaimentes,
            value: citaMedica.otrosRequisitos),
        if (citaMedica.direccion != null)
          DetalleDireccionEmergencia(direcccion: citaMedica.direccion!),
        if (citaMedica.imagenId != null)
          DetailPhotoFile(
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

class DetalleClientePoliza extends StatelessWidget {
  const DetalleClientePoliza({
    super.key,
    required this.citaMedica,
  });

  final CitaMedica citaMedica;

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
            value: citaMedica.clientePoliza!.cliente!.nombreUsuario),
        DetailFormField(
            padding: AppLayoutConst.spaceS,
            colorGray: true,
            value: citaMedica.clientePoliza!.displayName),
        DetailFormField(
            padding: AppLayoutConst.spaceS,
            colorGray: true,
            value: citaMedica.caso!.displayName),
      ],
    );
  }
}

class DetalleDireccionEmergencia extends StatelessWidget {
  const DetalleDireccionEmergencia({
    super.key,
    required this.direcccion,
  });

  final Direccion direcccion;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   width: double.infinity,
        //   padding: const EdgeInsets.all(10),
        //   decoration: BoxDecoration(
        //       color: Colors.white.withOpacity(0.3),
        //       border: Border.all(
        //         color: AppColors.primaryBlue.withOpacity(0.3),
        //       ),
        //       borderRadius: BorderRadius.circular(15)),
        //   child: Text(
        //     '${direcccion.pais?.nombre}\n${direcccion.estado?.nombre}\n${direcccion.ciudad}\n${direcccion.codigoPostal}',
        //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //           color: Colors.black54,
        //         ),
        //   ),
        // ),
        DetailFormField(
            colorGray: true,
            label: apptexts.perfilPage.country,
            value:
                '${direcccion.pais?.nombre}\n${direcccion.estado?.nombre}\n${direcccion.ciudad}\n${direcccion.codigoPostal}'),
        DetailFormField(
            colorGray: true,
            label: apptexts.perfilPage.state,
            value: direcccion.estado?.nombre),
        DetailFormField(
          colorGray: true,
          label: apptexts.perfilPage.city,
          value: direcccion.ciudad,
        ),
        DetailFormField(
          colorGray: true,
          label: apptexts.perfilPage.zipCode,
          value: direcccion.codigoPostal,
        ),
      ],
    );
  }
}
