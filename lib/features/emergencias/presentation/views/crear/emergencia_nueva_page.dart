import 'package:avalon_app/app/domain/usecases/general_uc/get_estados_by_pais_uc.dart';
import 'package:avalon_app/app/domain/usecases/general_uc/get_paises_uc.dart';
import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';

import 'package:avalon_app/features/casos/presentation/views/widgets/wid_caso_card.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/fields/editable_text_area_description.dart';
import 'package:avalon_app/features/shared/widgets/fields/editable_text_description.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/features/user_features.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

import '../../bloc/nuevaemergencia/emergencia_nueva_bloc.dart';

class CrearEmergenciaPage extends StatelessWidget {
  const CrearEmergenciaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => EmergenciaNuevaBloc(
        user,
        getPaisesUseCase: RepositoryProvider.of<GetPaisesUseCase>(context),
        getEstadosUseCase: RepositoryProvider.of<GetEstadosUseCase>(context),
      ),
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
    final emergenciaNuevabloc = context.read<EmergenciaNuevaBloc>();
    // emergenciaNuevabloc.add(const GetCasosCita());
    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.emergenciasPage.nuevaEmergencia),
        elevation: 6,
      ),
      body: BlocListener<EmergenciaNuevaBloc, EmergenciaNuevaState>(
        listener: (context, state) {
          if (state.waitForCreateCase) {
            showAlertCreateDialog(context, emergenciaNuevabloc);
          }
        },
        child: BlocBuilder<EmergenciaNuevaBloc, EmergenciaNuevaState>(
          builder: (context, state) {
            return SmartRefrehsCustom(
                key: const Key('__crear_emergencia_key__'),
                onRefresh: () async {
                  emergenciaNuevabloc.add(const GetCasoEmergencia());
                },
                refreshController: emergenciaNuevabloc.refreshController,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: state.casoSeleccionado == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppLayoutConst.spaceM),
                            Text(
                              apptexts.emergenciasPage.emergenciaSinCaso,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: AppLayoutConst.spaceS),
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    showAlertCreateDialog(
                                        context, emergenciaNuevabloc);
                                  },
                                  child: Text(apptexts
                                      .emergenciasPage.creaCasoEmergencia)),
                            ),
                            const SizedBox(height: AppLayoutConst.spaceS),
                            Text(
                              apptexts.emergenciasPage.emergenciaEnCaso,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            BlocBuilder<EmergenciaNuevaBloc,
                                EmergenciaNuevaState>(
                              builder: (context, state) {
                                if (state.message != null) {
                                  return MessageError(
                                      message: state.message!,
                                      onTap: () {
                                        emergenciaNuevabloc
                                            .add(const GetCasoEmergencia());
                                      });
                                }
                                if (state.casos == null) {
                                  return const Center(
                                      child: CircularProgressIndicatorCustom());
                                } else if (state.casos!.isEmpty) {
                                  const Center(
                                      child: CircularProgressIndicatorCustom());
                                }
                                return Column(
                                  children: [
                                    for (final caso in state.casos!)
                                      InkWell(
                                        onTap: () {
                                          emergenciaNuevabloc
                                              .add(SelectCasoEmergencia(caso));
                                        },
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
                      : FormNewEmergencia(
                          emergenciaNuevabloc: emergenciaNuevabloc,
                        ),
                )));
          },
        ),
      ),
    );
  }

  Future<void> showAlertCreateDialog(
      BuildContext context, EmergenciaNuevaBloc emergenciaNuevabloc) async {
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
      emergenciaNuevabloc.add(SelectCasoEmergencia(newCaso));
    }
  }
}

class FormNewEmergencia extends StatelessWidget {
  const FormNewEmergencia({
    super.key,
    required this.emergenciaNuevabloc,
  });

  final EmergenciaNuevaBloc emergenciaNuevabloc;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: emergenciaNuevabloc.formKey,
      child: Column(
        children: [
          CaseCard(
            caso: emergenciaNuevabloc.state.casoSeleccionado!,
            enable: false,
          ),
          const SizedBox(height: AppLayoutConst.spaceM),
          Text(
            apptexts.citasPage.nuevaCita,
            style: Theme.of(context).textTheme.titleSmall,
          ),

          EditableTextAreaDescription(
            apptexts.emergenciasPage.diagnostico,
            emergenciaNuevabloc.detailPadecimeiento,
          ),
          EditableTextAreaDescription(
            apptexts.emergenciasPage.sintomas,
            emergenciaNuevabloc.detailAditionalInformation,
          ),
          // Campos de dirección
          EditableTextDescription(
            apptexts.perfilPage.addressMain,
            emergenciaNuevabloc.detailDireccionUno,
          ),
          EditableTextDescription(
            apptexts.perfilPage.addressSecondary,
            emergenciaNuevabloc.detailDireccionDos,
            beNull: true,
          ),
          EditableTextDescription(
            apptexts.perfilPage.city,
            emergenciaNuevabloc.detailCiudad,
          ),
          EditableTextDescription(
            apptexts.perfilPage.zipCode,
            emergenciaNuevabloc.detailCodigoPostal,
            beNull: true,
          ),
          // Dropdown de país
          _buildDropdownCountryField(emergenciaNuevabloc),
          // Dropdown de estado
          _buildDropdownStateField(emergenciaNuevabloc),
          const SizedBox(height: AppLayoutConst.spaceM),
          ElevatedButton(
            onPressed: () {
              if (emergenciaNuevabloc.formKey.currentState!.validate()) {
                // Envía el evento al Bloc
                context
                    .read<EmergenciaNuevaBloc>()
                    .add(const SubmitEmergenciaEvent());
              } else {
                // Maneja la validación fallida
              }
            },
            child: Text(apptexts.appOptions.crate),
          ),
          const SizedBox(height: AppLayoutConst.spaceXL),
        ],
      ),
    );
  }

  Widget _buildDropdownCountryField(EmergenciaNuevaBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<EmergenciaNuevaBloc, EmergenciaNuevaState>(
        buildWhen: (previous, current) =>
            previous.paises != current.paises ||
            previous.selectedCountryId != current.selectedCountryId,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                apptexts.perfilPage.country,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppLayoutConst.spaceM),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                menuMaxHeight: 500,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                value: state.selectedCountryId,
                items: state.paises
                    .map((Pais pais) => DropdownMenuItem<int>(
                          value: pais.id!,
                          child: Text(pais.nombre ?? '-'),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    bloc.add(UpdateSelectedCountryEvent(value));
                  }
                },
                isExpanded: false,
                validator: (value) {
                  if (value == null || value == 0) {
                    return apptexts.appOptions.validators.requiredField;
                  }
                  return null;
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDropdownStateField(EmergenciaNuevaBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<EmergenciaNuevaBloc, EmergenciaNuevaState>(
        buildWhen: (previous, current) =>
            previous.estados != current.estados ||
            previous.selectedEstadoId != current.selectedEstadoId,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                apptexts.perfilPage.state,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppLayoutConst.spaceM),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                menuMaxHeight: 500,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                value: state.selectedEstadoId,
                items: state.estados
                    .map((Estado estado) => DropdownMenuItem<int>(
                          value: estado.id!,
                          child: Text(estado.nombre ?? '-'),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    bloc.add(UpdateSelectedEstadoEvent(value));
                  }
                },
                isExpanded: false,
                validator: (value) {
                  if (value == null || value == 0) {
                    return apptexts.appOptions.validators.requiredField;
                  }
                  return null;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
