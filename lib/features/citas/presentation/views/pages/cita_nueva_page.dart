import 'package:avalon_app/app/domain/usecases/general_uc/app_general_uses_cases.dart';
import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/app/presentation/bloc/creationEntities/creation_cubit_cubit.dart';
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
import 'package:intl/intl.dart';
import 'package:shared_models/shared_models.dart';

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
      create: (context) => CitaNuevaBloc(
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

          if (state.citaCreada != null && !state.citaCreada!) {
            UtilsFunctionsViews.showFlushBar(
                    message: apptexts.reclamacionesPage.reclamacionCreadaError)
                .show(context);
          }
          if (state.citaCreada != null && state.citaCreada!) {
            context.read<CreationCubit>().itemCreated(ItemType.citas);
            Navigator.of(context).pop();
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

          TipoCitaMedica(
            cerarCitaBloc: cerarCitaBloc,
          ),
          FechasCitaNueva(cerarCitaBloc: cerarCitaBloc),

          EditableTextDescription(
            apptexts.citasPage.detailPreferenceCity,
            cerarCitaBloc.detailPreferenceCity,
          ),
          // EditableTextDescription(
          //   apptexts.citasPage.detailHospital,
          //   cerarCitaBloc.detailHospital,
          //   beNull: true,
          // ),
          // EditableTextDescription(
          //   apptexts.citasPage.detailPreferenceDoctor,
          //   cerarCitaBloc.detailPreferenceDoctor,
          //   beNull: true,
          // ),
          EditableTextAreaDescription(
            apptexts.citasPage.detailSintoma(n: 2),
            cerarCitaBloc.detailSintoma,
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

          //// ADREES
          ///
          const Divider(),
          _buildDropdownCountryField(cerarCitaBloc),
          // Dropdown de estado
          _buildDropdownStateField(cerarCitaBloc),
          EditableTextDescription(
            apptexts.perfilPage.city,
            cerarCitaBloc.detailCiudad,
          ),
          EditableTextDescription(
            apptexts.perfilPage.addressMain,
            cerarCitaBloc.detailDireccionUno,
          ),
          EditableTextDescription(
            apptexts.perfilPage.addressSecondary,
            cerarCitaBloc.detailDireccionDos,
            beNull: true,
          ),
          EditableTextDescription(
            apptexts.perfilPage.zipCode,
            cerarCitaBloc.detailCodigoPostal,
            beNull: true,
          ),
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
          const SizedBox(height: AppLayoutConst.spaceXL),
        ],
      ),
    );
  }

  Widget _buildDropdownCountryField(CitaNuevaBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<CitaNuevaBloc, CitaNuevaState>(
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

  Widget _buildDropdownStateField(CitaNuevaBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<CitaNuevaBloc, CitaNuevaState>(
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

class TipoCitaMedica extends StatelessWidget {
  const TipoCitaMedica({super.key, required this.cerarCitaBloc});

  final CitaNuevaBloc cerarCitaBloc;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tipoCitaOptions = [
      {"id": "PRESENCIAL", "nombre": apptexts.citasPage.tiposCita.presencial},
      {"id": "TELEMATICA", "nombre": apptexts.citasPage.tiposCita.telematica},
      {"id": "SEGUIMIENTO", "nombre": apptexts.citasPage.tiposCita.seguimiento},
      {
        "id": "SEGUNDA_OPINION",
        "nombre": apptexts.citasPage.tiposCita.segundaOp
      },
    ];

    final String? tipoSelected =
        context.select((CitaNuevaBloc bloc) => bloc.state.tipoCita);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${apptexts.citasPage.tipoCita} *',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppLayoutConst.spaceM),
            DropdownButtonFormField<String>(
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
              value: tipoSelected,
              items: tipoCitaOptions.map((op) {
                return DropdownMenuItem<String>(
                  value: op["id"],
                  child: Text(op["nombre"]),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  cerarCitaBloc.add(UpdateSelectedTipoCita(value));
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
        ));
  }
}

class FechasCitaNueva extends StatefulWidget {
  const FechasCitaNueva({
    super.key,
    required this.cerarCitaBloc,
  });

  final CitaNuevaBloc cerarCitaBloc;

  @override
  State<FechasCitaNueva> createState() => _FechasCitaNuevaState();
}

class _FechasCitaNuevaState extends State<FechasCitaNueva> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditableDateDescription(
          label: '${apptexts.citasPage.detailFechaTentativaDesde} *',
          dateTextController: widget.cerarCitaBloc.dateFrom,
          disablePastDates: true,
          onFieldSubmitted: (p0) {
            setState(() {
              widget.cerarCitaBloc.dateTo.text =
                  widget.cerarCitaBloc.dateFrom.text;
            });
          },
        ),
        EditableDateDescription(
          label: apptexts.citasPage.detailFechaTentativaHasta,
          dateTextController: widget.cerarCitaBloc.dateTo,
          disablePastDates: true,
          minSelectedDate: _tryParseDate(widget.cerarCitaBloc.dateFrom.text),
        ),
      ],
    );
  }

  DateTime? _tryParseDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return null;
    try {
      return DateFormat('dd/MM/yyyy').parse(rawDate);
    } catch (_) {
      return null;
    }
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

class ImageSelccion extends StatelessWidget {
  const ImageSelccion({super.key});

  @override
  Widget build(BuildContext context) {
    final image = context.select((CitaNuevaBloc bloc) => bloc.state.image);
    final pdfState = context.select((CitaNuevaBloc bloc) => bloc.state.pdf);

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
                    onTap: () => context.read<CitaNuevaBloc>().add(
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
                        context.read<CitaNuevaBloc>().add(const RemoveImage());
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
    final pdf = context.select((CitaNuevaBloc bloc) => bloc.state.pdf);
    final imageState = context.select((CitaNuevaBloc bloc) => bloc.state.image);

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
                    context.read<CitaNuevaBloc>().add(const PdfSelected());
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
                        context.read<CitaNuevaBloc>().add(const RemovePdf());
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
