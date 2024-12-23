import 'package:avalon_app/app/presentation/bloc/creationEntities/creation_cubit_cubit.dart';
import 'package:avalon_app/features/shared/functions/utils_functions.dart';
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
          if (state.reclamacionCreada != null && !state.reclamacionCreada!) {
            UtilsFunctionsViews.showFlushBar(
                    message: apptexts.reclamacionesPage.reclamacionCreadaError)
                .show(context);
          }
          if (state.reclamacionCreada != null && state.reclamacionCreada!) {
            context.read<CreationCubit>().itemCreated(ItemType.reclamaciones);
            Navigator.of(context).pop();
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
            apptexts.reclamacionesPage.nuevaReclamacion,
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              apptexts.appOptions.attachments(n: 2),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 20,
            children: [
              ImageSelccion(),
              PdfSeleccion(),
            ],
          ),
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

class ImageSelccion extends StatelessWidget {
  const ImageSelccion({super.key});

  @override
  Widget build(BuildContext context) {
    final image =
        context.select((ReclamacionNuevaBloc bloc) => bloc.state.image);
    final pdfState =
        context.select((ReclamacionNuevaBloc bloc) => bloc.state.pdf);

    return Opacity(
      opacity: pdfState == null ? 1 : 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              apptexts.citasPage.detalleFoto,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: AppLayoutConst.spaceM,
            ),
            if (image == null)
              Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                    onTap: () => context.read<ReclamacionNuevaBloc>().add(
                          const ImageSelected(),
                        ),
                    child: const SizedBox(
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.photo,
                        size: 50,
                      ),
                    )),
              ),
            if (image != null)
              Stack(
                children: [
                  // Imagen seleccionada
                  GestureDetector(
                    onTap: () {
                      UtilsFunctionsViews.showFullScreenImage(
                        image,
                        context,
                      ); // Llamamos a la función para mostrar la imagen en un dialogo
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Botón de eliminar (X) en la esquina superior derecha
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<ReclamacionNuevaBloc>()
                            .add(const RemoveImage());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class PdfSeleccion extends StatelessWidget {
  const PdfSeleccion({super.key});

  @override
  Widget build(BuildContext context) {
    final pdf = context.select((ReclamacionNuevaBloc bloc) => bloc.state.pdf);
    final imageState =
        context.select((ReclamacionNuevaBloc bloc) => bloc.state.image);

    return Opacity(
      opacity: imageState == null ? 1 : 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PDF', // O usa tu apptexts...
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppLayoutConst.spaceM),
            if (pdf == null)
              Card(
                child: InkWell(
                  onTap: () {
                    // Disparamos evento para abrir FilePicker
                    context
                        .read<ReclamacionNuevaBloc>()
                        .add(const PdfSelected());
                  },
                  child: const SizedBox(
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.picture_as_pdf,
                      size: 50,
                    ),
                  ),
                ),
              )
            else
              Stack(
                children: [
                  // Muestra algo como un ícono o nombre del archivo
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 200,
                    height: 50,
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.grey.shade200,
                    child: Row(
                      children: [
                        const Icon(Icons.picture_as_pdf, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            pdf.path.split('/').last,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Botón de eliminar
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<ReclamacionNuevaBloc>()
                            .add(const RemovePdf());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
