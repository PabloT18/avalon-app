import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/casos/presentation/views/widgets/wid_title_description.dart';
import 'package:avalon_app/features/seguros/presentation/bloc/seguros_bloc.dart';
import 'package:avalon_app/features/shared/functions/fun_logic.dart';
import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:flutter/material.dart';

import 'package:avalon_app/features/shared/widgets/wid_drawer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_models/shared_models.dart';

class SegurosPage extends StatelessWidget {
  const SegurosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => SegurosBloc(user),
      child: Scaffold(
        appBar: AppBar(
          title: Text(apptexts.segurosPage.title(n: 2)),
          elevation: 6,
        ),
        drawer: DrawerCustom(
          indexInitialName: PAGES.seguros.pageName,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SegurosBody(
            user: user,
          ),
        ),
      ),
    );
  }
}

class SegurosBody extends StatelessWidget {
  const SegurosBody({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SegurosBloc, SegurosState>(
        listener: (context, state) {
          if (state.submitSuccess) {
            UtilsFunctionsViews.showFlushBar(
              message: apptexts.casosPage.casoCreado(n: 1),
              isError: false,
            ).show(context);
            // Navigator.of(context).pop();
          }
          if (state.hasError) {
            UtilsFunctionsViews.showFlushBar(
                    message: apptexts.casosPage.casoErrorCreate(n: 1),
                    isError: true)
                .show(context);
          }
        },
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildClienteDropdown(context, user),
            const SizedBox(height: 20),
            Text(
              apptexts.segurosPage.polizaSeguros(n: 2),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<SegurosBloc, SegurosState>(
              builder: (context, state) {
                if (state.isLoadingPolizas) {
                  return const CircularProgressIndicatorCustom();
                } else if (state.polizas.isNotEmpty) {
                  return Column(
                    children: state.polizas
                        .map((poliza) => PoloziaCard(
                              clientePoliza: poliza,
                              isClient: user.isClient,
                            ))
                        .toList(),
                  );
                } else {
                  MessageError(
                    message: apptexts.appOptions.noData,
                    onTap: () {
                      context
                          .read<SegurosBloc>()
                          .add(SeguroLoadClientesEvent());
                    },
                  );
                }
                return Container();
              },
            )
          ],
        )));
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
          BlocBuilder<SegurosBloc, SegurosState>(
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                items: state.clientes
                    .map((cliente) => DropdownMenuItem(
                          value: cliente,
                          child: Text(cliente.fullName),
                        ))
                    .toList(),
                onChanged: (cliente) {
                  // if (cliente != null && cliente != state.selectedCliente) {
                  if (cliente != null) {
                    context
                        .read<SegurosBloc>()
                        .add(SeguroSelectClienteEvent(cliente, cliente.id!));
                  }
                },
                value: state.selectedCliente,
              );
            },
          ),
        ],
      ),
    );
  }

  void _showPolizaDetails(BuildContext context, dynamic poliza) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(poliza['poliza']['nombre']),
          // scrollable: true,

          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.45,
            ),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Descripción: ${poliza['poliza']['descripcion']}'),
                  Text(
                      'Cliente: ${poliza['cliente']['nombres']} ${poliza['cliente']['apellidos']}'),
                  Text('Correo: ${poliza['cliente']['correoElectronico']}'),
                  Text(
                      'Asesor: ${poliza['asesor']['nombres']} ${poliza['asesor']['apellidos']}'),
                  Text(
                      'Correo del asesor: ${poliza['asesor']['correoElectronico']}'),
                  Text(
                      'Agente: ${poliza['agente']['nombres']} ${poliza['agente']['apellidos']}'),
                  Text(
                      'Correo del agente: ${poliza['agente']['correoElectronico']}'),
                  Text(
                      'Aseguradora: ${poliza['poliza']['aseguradora']['nombre']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class PoloziaCard extends StatelessWidget {
  const PoloziaCard(
      {super.key,
      required this.clientePoliza,
      required this.isClient,
      this.navigatePush = false});

  final ClientePoliza clientePoliza;
  final bool isClient;
  final bool navigatePush;

  @override
  Widget build(BuildContext context) {
    final locale = TranslationProvider.of(context).locale;

    return Card(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.secondaryBlue.withOpacity(0.4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppLayoutConst.cardBorderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppLayoutConst.cardBorderRadius),
        child: InkWell(
          // onTap: () {
          //   if (!navigatePush) {
          //     context.goNamed(
          //       PAGES.detalleCita.pageName,
          //       pathParameters: {
          //         'citaId': clientePoliza.id?.toString() ?? '',
          //       },
          //       extra: clientePoliza,
          //     );
          //   } else {
          //     context.pushNamed(
          //       PAGES.detalleCita.pageName,
          //       pathParameters: {
          //         'citaId': clientePoliza.id?.toString() ?? '',
          //       },
          //       extra: clientePoliza,
          //     );
          //   }
          // },

          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0), // Agrega el padding similar a ListTile
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isClient)
                        TitleDescripcion(
                          isSubdescription: true,
                          title: apptexts.appOptions.cliente,
                          value: clientePoliza.displayName!,
                        ),
                      TitleDescripcion(
                        isSubdescription: true,
                        title: apptexts.appOptions.detalle(n: 1),
                        value: clientePoliza.displayName ?? ' ',
                      ),
                      TitleDescripcion(
                        isSubdescription: true,
                        title: apptexts.citasPage.estados,
                        value: UtilsFunctionsViews.getStateStrinByState(
                            clientePoliza.estado ?? ''),
                      ),
                      TitleDescripcion(
                        isSubdescription: true,
                        title: apptexts.segurosPage.initDate,
                        value: UtilsFunctionsLogic.formatFechaLocal(
                            clientePoliza.fechaInicio!, locale.languageCode),
                      ),
                      TitleDescripcion(
                        isSubdescription: true,
                        title: apptexts.segurosPage.endDate,
                        value: UtilsFunctionsLogic.formatFechaLocal(
                            clientePoliza.fechaInicio!, locale.languageCode),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 10, // Tamaño del círculo
                  height: 10,
                  decoration: BoxDecoration(
                    color: UtilsFunctionsViews.getColorByState(
                        clientePoliza.estado ?? ''),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
