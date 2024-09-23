import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';

import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';

import 'package:avalon_app/features/casos/presentation/views/crear_caso_page.dart';
import 'package:avalon_app/features/casos/presentation/views/widgets/wid_caso_card.dart';

import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/fields/editable_date_description.dart';
import 'package:avalon_app/features/shared/widgets/fields/editable_text_area_description.dart';

import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import '../bloc/nuevareclamcacion/reclamacion_nueva_bloc.dart';

class CrearReclamacionPage extends StatelessWidget {
  const CrearReclamacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => ReclamacionNuevaBloc(
        user,
      ),
      child: const CrearEmergenciaView(),
    );
  }
}

class CrearEmergenciaView extends StatelessWidget {
  const CrearEmergenciaView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final reclamacionNuevaBloc = context.read<ReclamacionNuevaBloc>();
    // reclamacionNuevaBloc.add(const GetCasosCita());
    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.reclamacionesPage.nuevaReclamacion),
        elevation: 6,
      ),
      body: BlocListener<ReclamacionNuevaBloc, ReclamacionNuevaState>(
        listener: (context, state) {
          if (state.waitForCreateCase) {
            showAlertCreateDialog(context, reclamacionNuevaBloc);
          }
        },
        child: BlocBuilder<ReclamacionNuevaBloc, ReclamacionNuevaState>(
          builder: (context, state) {
            return SmartRefrehsCustom(
                key: const Key('__crear_emergencia_key__'),
                onRefresh: () async {
                  reclamacionNuevaBloc.add(const GetCasoReclamaciones());
                },
                refreshController: reclamacionNuevaBloc.refreshController,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: state.casoSeleccionado == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppLayoutConst.spaceM),
                            Text(
                              apptexts.reclamacionesPage.reclamacionSinCaso,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: AppLayoutConst.spaceS),
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    showAlertCreateDialog(
                                        context, reclamacionNuevaBloc);
                                  },
                                  child: Text(apptexts
                                      .reclamacionesPage.creaCasoReclamacion)),
                            ),
                            const SizedBox(height: AppLayoutConst.spaceS),
                            Text(
                              apptexts.reclamacionesPage.reclamacionEnCaso,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            BlocBuilder<ReclamacionNuevaBloc,
                                ReclamacionNuevaState>(
                              builder: (context, state) {
                                if (state.message != null) {
                                  return MessageError(
                                      message: state.message!,
                                      onTap: () {
                                        reclamacionNuevaBloc
                                            .add(const GetCasoReclamaciones());
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
                                          reclamacionNuevaBloc.add(
                                              SelectCasoReclamaciones(caso));
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
                      : FormNewReclamacion(
                          reclamacionNuevaBloc: reclamacionNuevaBloc,
                        ),
                )));
          },
        ),
      ),
    );
  }

  Future<void> showAlertCreateDialog(
      BuildContext context, ReclamacionNuevaBloc emergenciaNuevabloc) async {
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
      emergenciaNuevabloc.add(SelectCasoReclamaciones(newCaso));
    }
  }
}

class FormNewReclamacion extends StatelessWidget {
  const FormNewReclamacion({
    super.key,
    required this.reclamacionNuevaBloc,
  });

  final ReclamacionNuevaBloc reclamacionNuevaBloc;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: reclamacionNuevaBloc.formKey,
      child: Column(
        children: [
          CaseCard(
            caso: reclamacionNuevaBloc.state.casoSeleccionado!,
            enable: false,
          ),
          const SizedBox(height: AppLayoutConst.spaceM),
          Text(
            apptexts.citasPage.nuevaCita,
            style: Theme.of(context).textTheme.titleSmall,
          ),

          EditableTextAreaDescription(
            apptexts.reclamacionesPage.detailPadecimeientoDiagnostico,
            reclamacionNuevaBloc.detailPadecimeiento,
          ),
          EditableTextAreaDescription(
            apptexts.reclamacionesPage.detailAditionalInformation,
            reclamacionNuevaBloc.detailAditionalInformation,
          ),
          EditableDateDescription(
            label: apptexts.citasPage.detailFechaTentativa,
            dateTextController: reclamacionNuevaBloc.dateController,
          ),
          // Campos de dirección
          // Agrega el DropdownButtonFormField aquí
          _buildTipoAdmDropdown(reclamacionNuevaBloc),
          const SizedBox(height: AppLayoutConst.spaceM),
          BlocBuilder<ReclamacionNuevaBloc, ReclamacionNuevaState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state.isLoading != null && state.isLoading!
                    ? null
                    : () {
                        if (reclamacionNuevaBloc.formKey.currentState!
                            .validate()) {
                          // Envía el evento al Bloc
                          context
                              .read<ReclamacionNuevaBloc>()
                              .add(const SubmitReclamacionesEvent());
                        } else {
                          // Maneja la validación fallida
                        }
                      },
                child: Text(apptexts.appOptions.crate),
              );
            },
          ),
          const SizedBox(height: AppLayoutConst.spaceXL),
        ],
      ),
    );
  }

  Widget _buildTipoAdmDropdown(ReclamacionNuevaBloc bloc) {
    final List<Map<String, String>> tiposAdm = [
      {
        'value': tipoEmergencia,
        'label': apptexts.reclamacionesPage.tiposAdministacion.tipoEmergencia,
      },
      {
        'value': tipoProgramada,
        'label': apptexts.reclamacionesPage.tiposAdministacion.tipoProgramada,
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppLayoutConst.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            apptexts.reclamacionesPage.tipoAdministacion,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppLayoutConst.spaceM),
          BlocSelector<ReclamacionNuevaBloc, ReclamacionNuevaState, String?>(
            selector: (state) => state.tipoAdmSeleccionado,
            builder: (context, tipoAdmSeleccionado) {
              return DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                value: tipoAdmSeleccionado,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                items: tiposAdm.map((tipo) {
                  return DropdownMenuItem<String>(
                    value: tipo['value'],
                    child: Text(tipo['label']!),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    bloc.add(UpdateTipoAdmEvent(value));
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return apptexts.appOptions.validators.requiredField;
                  }
                  return null;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
