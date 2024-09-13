import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/casos/presentation/views/widgets/wid_title_description.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:avalon_app/features/casos/presentation/bloc/detallecaso/detallecaso_bloc.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:go_router/go_router.dart';

class CitasDetalleBox extends StatelessWidget {
  const CitasDetalleBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final detalleCasoBloc = context.read<DetalleCasoBloc>();

    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                apptexts.citasPage.casoDetalle(n: 2),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              IconButton(
                icon: const Icon(Icons.info_outline, size: 20),
                onPressed: () {
                  _showInfoDialog(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          BlocBuilder<DetalleCasoBloc, DetalleCasoState>(
            // buildWhen: (previous, current) {
            //   if (current is! DetalleCasoLoaded && previous is! DetalleCasoLoaded) {
            //     return false;
            //   }
            //   return (current as DetalleCasoLoaded).citas !=
            //       (previous as DetalleCasoLoaded).citas;
            // },
            builder: (context, state) {
              if (state is! DetalleCasoLoaded) {
                return const SizedBox();
              }
              if (state.citas == null ||
                  state.loadingCitas == null ||
                  state.loadingCitas!) {
                return const Center(child: CircularProgressIndicatorCustom());
              }
              // if (state.citas!.isEmpty) {
              //   return MessageError(
              //       message: 'No hay citas registradas',
              //       onTap: () {
              //         detalleCasoBloc.add(const GetCitas());
              //       });
              // }

              if (state.citas!.isEmpty) {
                return MessageError(
                    message: 'No hay citas registradas',
                    onTap: () {
                      detalleCasoBloc.add(const GetCitas());
                    });
              } else {
                return Expanded(
                    child: ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppLayoutConst.paddingL),
                        children: [
                      ...state.citas!.map((cita) => Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppColors.secondaryBlue.withOpacity(0.4),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(
                                AppLayoutConst.cardBorderRadius),
                          ),
                          child: ListTile(
                            // onTap: () => context.go(
                            //   '/home/casos/${PAGES.detalleCita.pageName}/${cita.id}',
                            //   extra: cita,
                            // ),
                            onTap: () {
                              context.goNamed(
                                PAGES.detalleCita.pageName,
                                pathParameters: {
                                  'citaId': cita.id?.toString() ?? '',
                                },
                                extra: cita,
                              );
                            },
                            title: TitleDescripcion(
                              title: apptexts.appOptions.detalle(n: 1),
                              value: cita.padecimiento!,
                            ),
                            subtitle: TitleDescripcion(
                              isSubdescription: true,
                              title: '${apptexts.citasPage.title(n: 1)} Id',
                              value: cita.codigo!,
                            ),
                            trailing: Container(
                              width: 15, // Tamaño del círculo
                              height: 15,
                              decoration: BoxDecoration(
                                color: getColorByState(cita.estado ?? ''),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ))),
                    ]));
              }
            },
          ),
        ],
      ),
    );
  }

  Color getColorByState(String state) {
    switch (state.toUpperCase()) {
      case 'CERRADO' || "C":
        return Colors.red;
      case 'GESTIONANDO' || "G":
        return Colors.blue;
      case 'POR GESTIONAR' || "P":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(apptexts.citasPage.estados),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text('${apptexts.citasPage.estadoCerrado} (C)'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text('${apptexts.citasPage.estadoGestionando} (G)'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text('${apptexts.citasPage.estadoPorGestionar} (P)'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
