import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';
import 'package:avalon_app/features/casos/presentation/bloc/detallecaso/detallecaso_bloc.dart';

import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'cd_caso_detalle_box.dart';

import 'cd_citas_datalle_box.dart';
import 'cd_emergencias_datalle_box.dart';
import 'cd_rembolsos_datalle_box.dart';
import 'widgets/wid_caso_card.dart';

class CasoDetallePage extends StatelessWidget {
  const CasoDetallePage({super.key, this.caso});

  final CasoEntity? caso;

  @override
  Widget build(BuildContext context) {
    final String? casoId = GoRouterState.of(context).pathParameters['casoId'];
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => DetalleCasoBloc(user, caso: caso),
      child: DetalleCasoView(casoId: casoId),
    );
  }
}

class DetalleCasoView extends StatelessWidget {
  const DetalleCasoView({
    super.key,
    required this.casoId,
  });

  final String? casoId;

  @override
  Widget build(BuildContext context) {
    final casoBloc = context.read<DetalleCasoBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.casosPage.casoDetalle(n: 1)),
        elevation: 6,
      ),
      body: BlocBuilder<DetalleCasoBloc, DetalleCasoState>(
        builder: (context, state) {
          return SmartRefrehsCustom(
              key: const Key('__caso_detalle_key__'),
              onRefresh: () async {
                // casoBloc.add(const GetCasosUser());
              },
              refreshController: casoBloc.refreshController,
              child: getChildByState(state, casoBloc, context));
        },
      ),
    );
  }

  Widget getChildByState(
      DetalleCasoState state, casoBloc, BuildContext context) {
    return switch (state) {
      DetallecasoInitial() => const Center(child: CircularProgressIndicator()),
      DetalleCasoError() => MessageError(
          message: state.message,
          onTap: () {
            // casoBloc.add(const GetCasosUser());
          }),
      DetalleCasoLoaded() => Column(
          children: [
            Hero(
              tag: state.caso.hashCode,
              child: CaseCard(
                caso: state.caso,
              ),
            ),
            const SizedBox(height: AppLayoutConst.spaceM),
            BlocBuilder<DetalleCasoBloc, DetalleCasoState>(
              builder: (context, state) {
                if (state is! DetalleCasoLoaded) return const SizedBox();
                return Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: AppLayoutConst.spaceL,
                  runSpacing: AppLayoutConst.spaceL,
                  children: [
                    CaseOption(
                        option: CasoOption.caso,
                        optionSelected: state.optionSelected),
                    CaseOption(
                        option: CasoOption.citas,
                        optionSelected: state.optionSelected),
                    CaseOption(
                        option: CasoOption.reembolso,
                        optionSelected: state.optionSelected),
                    CaseOption(
                        option: CasoOption.emergencia,
                        optionSelected: state.optionSelected),
                  ],
                );
              },
            ),
            const SizedBox(height: AppLayoutConst.spaceM),
            BlocBuilder<DetalleCasoBloc, DetalleCasoState>(
              builder: (context, state) {
                if (state is! DetalleCasoLoaded) return const SizedBox();

                switch (state.optionSelected) {
                  case CasoOption.caso:
                    return state.caso.clientePoliza != null
                        ? CasoDetalleBox(
                            clientePoliza: state.caso.clientePoliza!,
                          )
                        : const SizedBox();
                  case CasoOption.citas:
                    return const CitasDetalleBox();
                  case CasoOption.reembolso:
                    return const CDRembolososDetalleBox();
                  case CasoOption.emergencia:
                    return const CDEmergenciasDetalleBox();
                  default:
                    return const SizedBox();
                }
              },
            ),
          ],
        ),
    };
  }
}

class CaseOption extends StatelessWidget {
  const CaseOption(
      {super.key, required this.option, required this.optionSelected});

  final CasoOption option;
  final CasoOption? optionSelected;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: Key(option.toString()),
      heroTag: null,
      onPressed: () {
        if (option == optionSelected) {
          return;
        } else {
          context.read<DetalleCasoBloc>().add(SelectCasoOption(option));
        }
      },
      elevation: option == optionSelected ? 8 : 1,
      backgroundColor: option == optionSelected ? null : null,
      foregroundColor:
          option == optionSelected ? AppColors.primaryBlue : Colors.black45,
      child: iconByOption(),
    );
  }

  Widget iconByOption() {
    return switch (option) {
      CasoOption.caso => const FaIcon(FontAwesomeIcons.notesMedical),
      CasoOption.citas => const FaIcon(FontAwesomeIcons.calendarPlus),
      CasoOption.reembolso => const FaIcon(FontAwesomeIcons.fileMedical),
      CasoOption.emergencia => const FaIcon(FontAwesomeIcons.kitMedical),
    };
  }
}
