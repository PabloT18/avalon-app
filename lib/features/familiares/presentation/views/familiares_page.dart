import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';

import 'package:avalon_app/features/familiares/presentation/bloc/bloc/familiares_bloc.dart';
import 'package:avalon_app/features/shared/widgets/wid_drawer.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_models/shared_models.dart';

class FamiliaresPage extends StatelessWidget {
  const FamiliaresPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
        create: (context) => FamiliaresBloc(
              user,
            ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(apptexts.familiaresPage.title(n: 1)),
            elevation: 6,
          ),
          drawer: DrawerCustom(indexInitialName: PAGES.familiares.pageName),
          body: FamiliaresBody(
            user: user,
          ),
        ));
  }
}

class FamiliaresBody extends StatelessWidget {
  const FamiliaresBody({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FamiliaresBloc, FamiliaresState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildClienteDropdown(context, user),
              const SizedBox(height: 20),
              _buildPolizaDropdown(context, user),
              const SizedBox(height: 20),

              if (state.familiares != null && state.familiares!.isEmpty)
                Text(apptexts.familiaresPage.noFamily),
              if (state.familiares != null && state.familiares!.isNotEmpty)
                ...state.familiares!.map((clientePolizaFamiliar) => Card(
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                                clientePolizaFamiliar.displayName ?? ' - '),
                            // subtitle: Text(
                            //    clientePolizaFamiliar.par),
                          ),
                          // if (clientePolizaFamiliar['urlImagen'] != null)
                          //   Image.network(
                          //     familiar['urlImagen'],
                          //     fit: BoxFit.cover,
                          //   ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(clientePolizaFamiliar.cliente!.fullName),
                                Text(clientePolizaFamiliar.parentesco ?? ' - '),
                                Text(clientePolizaFamiliar.tipo ?? ' - '),
                                Text(clientePolizaFamiliar.numeroCertificado ??
                                    ' - '),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))

              // _buildSubmitButton(context),
            ],
          ),
        );
      },
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
          BlocBuilder<FamiliaresBloc, FamiliaresState>(
            builder: (context, state) {
              return DropdownButtonFormField<UsrCliente>(
                decoration: InputDecoration(
                  labelText: apptexts.appOptions.cliente,
                  isDense: true,
                ),
                menuMaxHeight: 500,
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
                        .read<FamiliaresBloc>()
                        .add(SelectClienteEvent(cliente, cliente.id!));
                  }
                },
                selectedItemBuilder: (BuildContext context) {
                  // Aquí se define cómo mostrar el elemento seleccionado
                  return state.clientes.map<Widget>((UsrCliente cliente) {
                    return SizedBox(
                      // width: MediaQuery.of(context).size.width *
                      //     (fromAlert ? 0.45 : 0.75),
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
          BlocBuilder<FamiliaresBloc, FamiliaresState>(
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
                        .read<FamiliaresBloc>()
                        .add(SelectPolizaEvent(poliza));
                  }
                },
                selectedItemBuilder: (BuildContext context) {
                  // Aquí se define cómo mostrar el elemento seleccionado
                  return state.polizas.map<Widget>((ClientePoliza poliza) {
                    return SizedBox(
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
}

class AddFamiliarPage extends StatefulWidget {
  final int polizaId;

  const AddFamiliarPage({
    super.key,
    required this.polizaId,
  });

  @override
  State<AddFamiliarPage> createState() => _AddFamiliarPageState();
}

class _AddFamiliarPageState extends State<AddFamiliarPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombresController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _parentescoController = TextEditingController();
  final _correoController = TextEditingController();
  final _telefonoController = TextEditingController();

  Future<void> _addFamiliar() async {
    const String url =
        'http://149.56.110.32:8086/clientesPolizas/agregarFamiliar';
    const String token = 'widget.user.token!';

    final dio = Dio();
    try {
      await dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'polizaId': widget.polizaId,
          'nombres': _nombresController.text,
          'apellidos': _apellidosController.text,
          'parentesco': _parentescoController.text,
          'correoElectronico': _correoController.text,
          'numeroTelefono': _telefonoController.text,
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      print('Error adding familiar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al agregar familiar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Familiar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: _nombresController,
                decoration: const InputDecoration(labelText: 'Nombres'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los nombres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _apellidosController,
                decoration: const InputDecoration(labelText: 'Apellidos'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los apellidos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _parentescoController,
                decoration: const InputDecoration(labelText: 'Parentesco'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el parentesco';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _correoController,
                decoration:
                    const InputDecoration(labelText: 'Correo Electrónico'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el correo electrónico';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _telefonoController,
                decoration:
                    const InputDecoration(labelText: 'Número de Teléfono'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de teléfono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addFamiliar();
                  }
                },
                child: const Text('Agregar Familiar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
