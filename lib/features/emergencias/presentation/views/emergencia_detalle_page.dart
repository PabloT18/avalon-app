import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';

import 'package:avalon_app/features/emergencias/emergencias.dart';
import 'package:avalon_app/features/emergencias/presentation/bloc/detalle/emergencia_detalle_bloc.dart';

import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_models/shared_models.dart';

import '../bloc/detalle/cubit/comentario_nuev_cubit.dart';
import '../bloc/detalle/emergencia_detalle_panels_cubit.dart';
import 'emergencia_detalle_panel_history.dart';
import 'emergencia_detalle_panel_info.dart';
import 'wid_emergencia_card.dart';
import 'wid_emergencia_comentario_text_field.dart';

class EmergenciaDetallePage extends StatelessWidget {
  const EmergenciaDetallePage({super.key, this.emergencia});
  final EmergenciaModel? emergencia;

  @override
  Widget build(BuildContext context) {
    final String? emergenciaId =
        GoRouterState.of(context).pathParameters['emergenciaId'];
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmergenciaDetalleBloc(
            user,
            emergencia: emergencia,
          ),
        ),
        BlocProvider(
          create: (context) => DetallePanelsCubit(),
        ),
      ],
      child: EmergenciaDetalleView(
        emergenciaId: emergenciaId,
        user: user,
      ),
    );
  }
}

class EmergenciaDetalleView extends StatelessWidget {
  const EmergenciaDetalleView({
    super.key,
    required this.user,
    this.emergenciaId,
  });

  final User user;
  final String? emergenciaId;

  @override
  Widget build(BuildContext context) {
    final blocObjet = context.read<EmergenciaDetalleBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.emergenciasPage.emergenciaDetalle(n: 1)),
        elevation: 6,
      ),
      body: BlocBuilder<EmergenciaDetalleBloc, EmergenciaDetalleState>(
        builder: (context, state) {
          return switch (state) {
            EmergenciaDetalleInitial() =>
              const CircularProgressIndicatorCustom(),
            EmergenciaDetalleError() => MessageError(
                message: state.message,
                onTap: () {
                  //TODO: ddescargar la cita del id
                  // casoBloc.add(const GetCasosUser());
                }),
            EmergenciaDetalleLoaded() => BlocProvider(
                create: (context) => ComentarioNuevCubit(
                      emergenciaId: state.emergenciaModel.id!,
                      user: user,
                      repository: blocObjet.emerRepository,
                    ),
                child: Column(
                  children: [
                    Expanded(
                      child:
                          BlocBuilder<DetallePanelsCubit, DetallePanelsState>(
                        builder: (context, statePanels) {
                          return SmartRefrehsCustom(
                              key: const Key(
                                  '__emergencias_detalle_historial_key__'),
                              enablePullDown: statePanels.index == 1,
                              onRefresh: statePanels.index == 1
                                  ? () async {
                                      blocObjet
                                          .add(const GetEmergenciaHistorial());
                                      blocObjet.refreshController
                                        ..loadFailed()
                                        ..refreshCompleted();
                                    }
                                  : null,
                              refreshController: blocObjet.refreshController,
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(
                                    AppLayoutConst.paddingL),
                                child: Column(
                                  children: [
                                    Hero(
                                      tag: blocObjet.emergencia.hashCode,
                                      child: EmergenciaCard(
                                        emergenciaModel: state.emergenciaModel,
                                        isClient: user.isClient,
                                      ),
                                    ),
                                    const SizedBox(
                                        height: AppLayoutConst.spaceL),
                                    Wrap(
                                      alignment: WrapAlignment.spaceEvenly,
                                      spacing: AppLayoutConst.spaceL,
                                      runSpacing: AppLayoutConst.spaceL,
                                      children: [
                                        OptionButton(
                                          option: const DetalleInfo(),
                                          optionSelected: statePanels,
                                          title:
                                              apptexts.citasPage.details(n: 1),
                                        ),
                                        OptionButton(
                                          option: const DetalleHistorial(),
                                          optionSelected: statePanels,
                                          title: apptexts.citasPage
                                              .historyTxt(n: 1),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: AppLayoutConst.spaceL),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppLayoutConst.spaceM),
                                        child: statePanels.index == 0
                                            ? DetalleMorePanel(
                                                emergencia:
                                                    state.emergenciaModel)
                                            : const DetalleHistoryPanel()),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                    BlocBuilder<DetallePanelsCubit, DetallePanelsState>(
                      builder: (context, statePanels) {
                        if (statePanels.index == 0) return const SizedBox();

                        return const SafeArea(child: ComentarioTextBox());
                      },
                    ),
                  ],
                )),
          };
        },
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton(
      {super.key,
      required this.option,
      required this.optionSelected,
      required this.title});

  final DetallePanelsState option;
  final DetallePanelsState? optionSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          key: Key(option.toString()),
          heroTag: null,
          onPressed: () {
            if (option == optionSelected) {
              return;
            } else {
              context.read<DetallePanelsCubit>().togglePanel(option);
            }
          },
          elevation: option == optionSelected ? 8 : 1,
          // backgroundColor: option == optionSelected ? null : null,
          backgroundColor: AppColors.primaryBlue,
          foregroundColor:
              option == optionSelected ? AppColors.white : Colors.white30,
          child: iconByOption(),
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 12,
              fontWeight: option == optionSelected
                  ? FontWeight.bold
                  : FontWeight.normal),
        ),
      ],
    );
  }

  Widget iconByOption() {
    return switch (option) {
      DetalleInfo() => const FaIcon(FontAwesomeIcons.notesMedical),
      DetalleHistorial() => const FaIcon(FontAwesomeIcons.book),
      // DetalleOption.reembolso => const FaIcon(FontAwesomeIcons.fileMedical),
    };
  }
}
