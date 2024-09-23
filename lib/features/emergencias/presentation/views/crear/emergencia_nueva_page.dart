import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';

import 'package:avalon_app/features/casos/presentation/views/widgets/wid_caso_card.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/features/user_features.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/nuevaemergencia/emergencia_nueva_bloc.dart';

class CrearEmergenciaPage extends StatelessWidget {
  const CrearEmergenciaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => EmergenciaNuevaBloc(user),
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
    final cerarCitaBloc = context.read<EmergenciaNuevaBloc>();
    // cerarCitaBloc.add(const GetCasosCita());
    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.emergenciasPage.nuevaEmergencia),
        elevation: 6,
      ),
      body: BlocListener<EmergenciaNuevaBloc, EmergenciaNuevaState>(
        listener: (context, state) {
          if (state.waitForCreateCase) {
            showAlertCreateDialog(context, cerarCitaBloc);
          }
        },
        child: BlocBuilder<EmergenciaNuevaBloc, EmergenciaNuevaState>(
          builder: (context, state) {
            return SmartRefrehsCustom(
                key: const Key('__crear_cita_key__'),
                onRefresh: () async {
                  cerarCitaBloc.add(const GetCasoEmergencia());
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
                                  apptexts.emergenciasPage.emergenciaSinCaso,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(height: AppLayoutConst.spaceS),
                                Center(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        showAlertCreateDialog(
                                            context, cerarCitaBloc);
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
                                            cerarCitaBloc
                                                .add(const GetCasoEmergencia());
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
                                          CaseCard(
                                            caso: caso,
                                            enable: false,
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            )
                          : CaseCard(
                              caso: state.casoSeleccionado!,
                              enable: false,
                            )),
                ));
          },
        ),
      ),
    );
  }

  Future<void> showAlertCreateDialog(
      BuildContext context, EmergenciaNuevaBloc cerarCitaBloc) async {
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
      cerarCitaBloc.add(SelectCasoEmergencia(newCaso));
    }
  }
}
