import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:avalon_app/features/shared/widgets/buttons/buttons_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

import '../bloc/creacCaso/nuevo_caso_bloc.dart';

class CrearCasoPage extends StatelessWidget {
  const CrearCasoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.casosPage.nuevoCaso(n: 1)),
        elevation: 6,
      ),
      body: const CrearCasoPageView(),
    );
  }
}

class CrearCasoPageView extends StatelessWidget {
  const CrearCasoPageView({
    super.key,
    this.fromAlert = false,
  });
  final bool fromAlert;

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => NuevoCasoBloc(
        user,
      ),
      child: NuevoCasoForm(
        user: user,
        fromAlert: fromAlert,
      ),
    );
  }
}

class NuevoCasoForm extends StatelessWidget {
  const NuevoCasoForm({
    super.key,
    required this.user,
    this.fromAlert = false,
  });

  final User user;

  final bool fromAlert;
  @override
  Widget build(BuildContext context) {
    return BlocListener<NuevoCasoBloc, NuevoCasoState>(
      listener: (context, state) {
        if (state.submitSuccess) {
          if (fromAlert) {
            Navigator.of(context).pop(state.casoCreado);
          } else {
            UtilsFunctionsViews.showFlushBar(
              message: apptexts.casosPage.casoCreado(n: 1),
              isError: false,
            ).show(context);
          }
        }
        if (state.hasError) {
          UtilsFunctionsViews.showFlushBar(
                  message: apptexts.casosPage.casoErrorCreate(n: 1),
                  isError: true)
              .show(context);
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: context.read<NuevoCasoBloc>().formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildClienteDropdown(context, user),
              const SizedBox(height: 20),
              _buildPolizaDropdown(context, user),
              const SizedBox(height: 20),
              _buildEditableProfileInfoRow(
                apptexts.casosPage.observationsCaso(n: 2),
                context.read<NuevoCasoBloc>().observacionesController,
              ),
              const SizedBox(height: 40),
              Center(
                child: BlocBuilder<NuevoCasoBloc, NuevoCasoState>(
                  builder: (context, state) {
                    return CustomButton(
                      title: apptexts.appOptions.save,
                      onPressed: !state.isSubmitting
                          ? () {
                              context
                                  .read<NuevoCasoBloc>()
                                  .add(SubmitCasoEvent());
                              FocusScope.of(context).unfocus();
                            }
                          : null,
                    );
                  },
                ),
              ),

              const SizedBox(height: AppLayoutConst.spaceXL),
              // _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClienteDropdown(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.isClient
                ? apptexts.appOptions.cliente
                : apptexts.casosPage.chooseClientCaso(n: 2),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: AppLayoutConst.spaceM,
          ),
          BlocBuilder<NuevoCasoBloc, NuevoCasoState>(
            builder: (context, state) {
              // if (state.isLoading) {
              //   return const CircularProgressIndicator();
              // }
              return DropdownButtonFormField<UsrCliente>(
                decoration: InputDecoration(
                  labelText: apptexts.appOptions.cliente,
                  isDense: true,
                ),
                menuMaxHeight: 500,
                isExpanded: true,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                items: state.clientes
                    .map((cliente) => DropdownMenuItem(
                          value: cliente,
                          // child: Text(poliza.nombrePoliza ?? '-'),
                          child: Text(
                            (cliente.fullName),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ))
                    .toList(),
                onChanged: (cliente) {
                  // if (cliente != null && cliente != state.selectedCliente) {
                  if (cliente != null) {
                    context
                        .read<NuevoCasoBloc>()
                        .add(SelectClienteEvent(cliente, cliente.id!));
                  }
                },
                selectedItemBuilder: (BuildContext context) {
                  // Aquí se define cómo mostrar el elemento seleccionado
                  return state.clientes.map<Widget>((UsrCliente cliente) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width *
                          (fromAlert ? 0.45 : 0.75),
                      child: Text(
                        cliente.fullName,
                        overflow:
                            TextOverflow.ellipsis, // Evita el desbordamiento
                        maxLines: 1, // Asegurarse que solo se muestre una línea
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList();
                },
                value: state.selectedCliente,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPolizaDropdown(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            apptexts.segurosPage.polizaSeguros(n: 2),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: AppLayoutConst.spaceM,
          ),
          BlocBuilder<NuevoCasoBloc, NuevoCasoState>(
            buildWhen: (previous, current) =>
                previous.polizas != current.polizas,
            builder: (context, state) {
              // if (state.isLoadingPolizas) {
              //   return const CircularProgressIndicator();
              // }
              return DropdownButtonFormField<ClientePoliza>(
                decoration: InputDecoration(
                  labelText: apptexts.segurosPage.polizaSeguros(n: 1),
                  isDense: true,
                ),
                isExpanded: true,
                menuMaxHeight: 500,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                items: state.polizas
                    .map((poliza) => DropdownMenuItem(
                          value: poliza,
                          // child: Text(poliza.nombrePoliza ?? '-'),
                          child: Text(
                            (poliza.nombrePoliza),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ))
                    .toList(),
                onChanged: (poliza) {
                  if (poliza != null) {
                    context
                        .read<NuevoCasoBloc>()
                        .add(SelectPolizaEvent(poliza));
                  }
                },
                selectedItemBuilder: (BuildContext context) {
                  // Aquí se define cómo mostrar el elemento seleccionado
                  return state.polizas.map<Widget>((ClientePoliza poliza) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width *
                          (fromAlert ? 0.45 : 0.75),
                      child: Text(
                        poliza.nombrePoliza,
                        overflow:
                            TextOverflow.ellipsis, // Evita el desbordamiento
                        maxLines: 1, // Asegurarse que solo se muestre una línea
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList();
                },
                value: state.selectedPoliza,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEditableProfileInfoRow(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: AppLayoutConst.spaceM,
          ),
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return apptexts.appOptions.validators.requiredField;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
