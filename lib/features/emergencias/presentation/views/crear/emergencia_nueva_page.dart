import 'package:avalon_app/app/domain/usecases/general_uc/get_estados_by_pais_uc.dart';
import 'package:avalon_app/app/domain/usecases/general_uc/get_paises_uc.dart';
import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/app/presentation/bloc/creationEntities/creation_cubit_cubit.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';

import 'package:avalon_app/features/casos/presentation/views/widgets/wid_caso_card.dart';
import 'package:avalon_app/features/shared/functions/fun_views.dart';
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
    final emergenciaNuevabloc = context.read<EmergenciaNuevaBloc>();

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
          if (state.emergenciaCreada != null && !state.emergenciaCreada!) {
            UtilsFunctionsViews.showFlushBar(
                    message: apptexts.reclamacionesPage.reclamacionCreadaError)
                .show(context);
          }
          if (state.emergenciaCreada != null && state.emergenciaCreada!) {
            context.read<CreationCubit>().itemCreated(ItemType.emergencia);
            Navigator.of(context).pop();
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
                            //   ],
                            // )
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
            apptexts.emergenciasPage.nuevaEmergencia,
            style: Theme.of(context).textTheme.titleSmall,
          ),

          EditableTextAreaDescription(
            apptexts.emergenciasPage.diagnostico,
            emergenciaNuevabloc.detailPadecimiento,
          ),
          EditableTextAreaDescription(
            apptexts.emergenciasPage.sintomas,
            emergenciaNuevabloc.detailAditionalInformation,
          ),
          // Campos de dirección
          const Divider(),

          _buildDropdownCountryField(emergenciaNuevabloc),
          // Dropdown de estado
          _buildDropdownStateField(emergenciaNuevabloc),
          EditableTextDescription(
            apptexts.perfilPage.city,
            emergenciaNuevabloc.detailCiudad,
          ),
          EditableTextDescription(
            apptexts.perfilPage.address,
            emergenciaNuevabloc.detailDireccionUno,
          ),
          EditableTextDescription(
            apptexts.perfilPage.addressSecondary,
            emergenciaNuevabloc.detailDireccionDos,
            beNull: true,
          ),
          EditableTextDescription(
            apptexts.perfilPage.zipCode,
            emergenciaNuevabloc.detailCodigoPostal,
            beNull: true,
          ),
          // Dropdown de país

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
                '${apptexts.perfilPage.country}:',
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
                '${apptexts.perfilPage.state}:',
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

class ImageSelccion extends StatelessWidget {
  const ImageSelccion({super.key});

  @override
  Widget build(BuildContext context) {
    final image =
        context.select((EmergenciaNuevaBloc bloc) => bloc.state.image);
    final pdfState =
        context.select((EmergenciaNuevaBloc bloc) => bloc.state.pdf);

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
                    onTap: () => context.read<EmergenciaNuevaBloc>().add(
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
                            .read<EmergenciaNuevaBloc>()
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
    final pdf = context.select((EmergenciaNuevaBloc bloc) => bloc.state.pdf);
    final imageState =
        context.select((EmergenciaNuevaBloc bloc) => bloc.state.image);

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
                        .read<EmergenciaNuevaBloc>()
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
                            .read<EmergenciaNuevaBloc>()
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
