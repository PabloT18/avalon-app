import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/features/citas/presentation/views/widgets/wid_cita_detail_iamge.dart';
import 'package:avalon_app/features/emergencias/emergencias.dart';
import 'package:avalon_app/features/shared/widgets/wid_detail_form_field.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

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
        DetalleClientePoliza(
          emergencia: emergencia,
        ),
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
            colorGray: true,
            label: apptexts.citasPage.detailAseguradoraName,
            value: emergencia.clientePoliza?.poliza?.aseguradora?.nombre),
        DetailFormField(
          colorGray: true,
          label: apptexts.citasPage.detailHospital,
          value: emergencia.medicoCentroMedicoAseguradora?.centroMedico?.nombre,
        ),
        DetailFormField(
            colorGray: true,
            label: apptexts.citasPage.detailPreferenceDoctor,
            value: emergencia
                .medicoCentroMedicoAseguradora?.medico?.nombreCompleto),
        DetailFormField(
            colorGray: true,
            label: apptexts.emergenciasPage.diagnostico,
            value: emergencia.diagnostico),
        DetailFormField(
            colorGray: true,
            label: apptexts.emergenciasPage.sintomas,
            value: emergencia.sintomas),
        if (emergencia.direccion != null)
          DetalleDireccionEmergencia(direcccion: emergencia.direccion!),

        // DetailFormField(
        //     label: apptexts.segurosPage.polizaSeguros(n: 1),
        //     value: emergencia.clientePoliza?.poliza?.nombre),

        // DetailFormField(
        //     label: apptexts.citasPage.detailPadecimiento,
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

class DetalleClientePoliza extends StatelessWidget {
  const DetalleClientePoliza({
    super.key,
    required this.emergencia,
  });

  final EmergenciaModel emergencia;
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
            colorGray: true,
            value: emergencia.clientePoliza!.cliente!.nombreUsuario),
        DetailFormField(
            colorGray: true, value: emergencia.clientePoliza!.displayName),
        DetailFormField(colorGray: true, value: emergencia.caso!.displayName),
      ],
    );
  }
}
