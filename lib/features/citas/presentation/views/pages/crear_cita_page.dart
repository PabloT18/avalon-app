import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';

import 'package:avalon_app/features/casos/presentation/views/widgets/wid_caso_card.dart';
import 'package:avalon_app/features/shared/functions/utils_functions.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/features/user_features.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/fields/editable_date_description.dart';
import '../../../../shared/widgets/fields/editable_text_area_description.dart';
import '../../../../shared/widgets/fields/editable_text_description.dart';
import '../../bloc/nuevacita/cita_nueva_bloc.dart';

class CrearCitaPage extends StatelessWidget {
  const CrearCitaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => CitaNuevaBloc(user),
      child: const CrearCitaView(),
    );
  }
}

class CrearCitaView extends StatelessWidget {
  const CrearCitaView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cerarCitaBloc = context.read<CitaNuevaBloc>();
    // cerarCitaBloc.add(const GetCasosCita());
    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.citasPage.nuevaCita),
        elevation: 6,
      ),
      body: BlocListener<CitaNuevaBloc, CitaNuevaState>(
        listener: (context, state) {
          if (state.waitForCreateCase) {
            showAlertCreateDialog(context, cerarCitaBloc);
          }
          if (state.message != null) {
            UtilsFunctionsViews.showFlushBar(
                    message: state.message!, isError: false)
                .show(context);
          }
        },
        child: BlocBuilder<CitaNuevaBloc, CitaNuevaState>(
          builder: (context, state) {
            return SmartRefrehsCustom(
                key: const Key('__crear_cita_key__'),
                onRefresh: () async {
                  cerarCitaBloc.add(const GetCasosCita());
                },
                refreshController: cerarCitaBloc.refreshController,
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: state.casoSeleccionado == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: AppLayoutConst.spaceM),
                                Text(
                                  apptexts.citasPage.citaSinCaso,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(height: AppLayoutConst.spaceS),
                                Center(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        showAlertCreateDialog(
                                            context, cerarCitaBloc);
                                      },
                                      child: Text(
                                          apptexts.citasPage.creaCasoCita)),
                                ),
                                const SizedBox(height: AppLayoutConst.spaceS),
                                Text(
                                  apptexts.citasPage.citaEnCaso,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                BlocBuilder<CitaNuevaBloc, CitaNuevaState>(
                                  builder: (context, state) {
                                    if (state.message != null) {
                                      return MessageError(
                                          message: state.message!,
                                          onTap: () {
                                            cerarCitaBloc
                                                .add(const GetCasosCita());
                                          });
                                    }
                                    if (state.casos == null) {
                                      return const Center(
                                          child:
                                              CircularProgressIndicatorCustom());
                                    } else if (state.casos!.isEmpty) {
                                      const Center(
                                          child:
                                              CircularProgressIndicatorCustom());
                                    }
                                    return Column(
                                      children: [
                                        for (final caso in state.casos!)
                                          InkWell(
                                            onTap: () => cerarCitaBloc
                                                .add(SelectCaso(caso)),
                                            child: CaseCard(
                                              caso: caso,
                                              enable: false,
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            )
                          : FormNewCita(cerarCitaBloc: cerarCitaBloc)),
                ));
          },
        ),
      ),
    );
  }

  Future<void> showAlertCreateDialog(
      BuildContext context, CitaNuevaBloc cerarCitaBloc) async {
    final CasoEntity? newCaso = await showAdaptiveDialog<CasoEntity>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(apptexts.casosPage.nuevoCaso(n: 1)),
            content: const CrearCasoPageView(
              fromAlert: true,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(apptexts.appOptions.cancelar),
              ),
            ],
          );
        });

    // Si el caso es creado, lo puedes manejar aquí
    if (newCaso != null) {
      cerarCitaBloc.add(SelectCaso(newCaso));
    }
  }
}

class FormNewCita extends StatelessWidget {
  const FormNewCita({
    super.key,
    required this.cerarCitaBloc,
  });

  final CitaNuevaBloc cerarCitaBloc;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cerarCitaBloc.formKey,
      child: Column(
        children: [
          CaseCard(
            caso: cerarCitaBloc.state.casoSeleccionado!,
            enable: false,
          ),
          const SizedBox(height: AppLayoutConst.spaceM),
          Text(
            apptexts.citasPage.nuevaCita,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          EditableDateDescription(
            label: apptexts.citasPage.detailFechaTentativa,
            dateTextController: cerarCitaBloc.birthDateController,
            disablePastDates: true,
          ),
          EditableTextDescription(
            apptexts.citasPage.detailPreferenceCity,
            cerarCitaBloc.detailPreferenceCity,
          ),
          EditableTextDescription(
            apptexts.citasPage.detailHospital,
            cerarCitaBloc.detailHospital,
            beNull: true,
          ),
          EditableTextDescription(
            apptexts.citasPage.detailPreferenceDoctor,
            cerarCitaBloc.detailPreferenceDoctor,
            beNull: true,
          ),
          EditableTextAreaDescription(
            apptexts.citasPage.detailPadecimeiento,
            cerarCitaBloc.detailPadecimeiento,
          ),
          EditableTextAreaDescription(
            apptexts.citasPage.detailAditionalInformation,
            cerarCitaBloc.detailAditionalInformation,
          ),
          const EditableRequisitosAdicionales(),
          EditableTextAreaDescription(
            apptexts.citasPage.detailOthersRequaimentes,
            cerarCitaBloc.detailOthersRequaimentes,
            beNull: true,
          ),
          ElevatedButton(
            onPressed: () {
              if (cerarCitaBloc.formKey.currentState!.validate()) {
                // Envía el evento al Bloc
                context.read<CitaNuevaBloc>().add(const SubmitCitaEvent());
              } else {
                // Maneja la validación fallida
              }
            },
            child: Text(apptexts.appOptions.crate),
          ),
        ],
      ),
    );
  }
}

class EditableRequisitosAdicionales extends StatelessWidget {
  const EditableRequisitosAdicionales({super.key});

  @override
  Widget build(BuildContext context) {
    final requisitos = context
        .select((CitaNuevaBloc bloc) => bloc.state.requisitosAdicionales);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            apptexts.citasPage.detailAditionalRequaimentes,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppLayoutConst.spaceM),
          _buildCheckboxRow(
            context,
            apptexts.citasPage.aditionalRequaimentes.ambulanciaTerrestre,
            requisitos.ambTerrestre ?? false,
            'ambTerrestre',
          ),
          _buildCheckboxRow(
            context,
            apptexts.citasPage.aditionalRequaimentes.recetaMedica,
            requisitos.recetaMedica ?? false,
            'recetaMedica',
          ),
          _buildCheckboxRow(
            context,
            apptexts.citasPage.aditionalRequaimentes.ambulanciaAerea,
            requisitos.ambAerea ?? false,
            'ambAerea',
          ),
          _buildCheckboxRow(
            context,
            apptexts.citasPage.aditionalRequaimentes.sillaRuedas,
            requisitos.sillaRuedas ?? false,
            'sillaRuedas',
          ),
          _buildCheckboxRow(
            context,
            apptexts.citasPage.aditionalRequaimentes.servicioTransporte,
            requisitos.serTransporte ?? false,
            'serTransporte',
          ),
          _buildCheckboxRow(
            context,
            apptexts.citasPage.aditionalRequaimentes.viajes,
            requisitos.viajes ?? false,
            'viajes',
          ),
          _buildCheckboxRow(
            context,
            apptexts.citasPage.aditionalRequaimentes.hospedaje,
            requisitos.hospedaje ?? false,
            'hospedaje',
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxRow(
      BuildContext context, String label, bool value, String field) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (newValue) {
            context.read<CitaNuevaBloc>().add(
                  UpdateRequisitoAdicional(field: field, value: newValue!),
                );
          },
        ),
        Text(label),
      ],
    );
  }
}
