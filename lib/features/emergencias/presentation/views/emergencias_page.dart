import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/app/presentation/bloc/settings_cubit/app_settings_cubit.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

import '../bloc/emergencias_bloc.dart';

// import 'package:avalon/features/shared/widgets/wid_drawer.dart';

class EmergenciasPage extends StatelessWidget {
  const EmergenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergencias'),
        elevation: 6,
      ),
      // drawer: const DrawerCustom(
      //     indexInitial: x,
      // ),
      body: const Center(
        child: Text('Welcome to Emergencias'),
      ),
    );
  }
}

class EmergenciaPanel extends StatelessWidget {
  const EmergenciaPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return const EmergenciasPanelView();
      },
    );
  }
}

class EmergenciasPanelView extends StatelessWidget {
  const EmergenciasPanelView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    final emergenciaBloc = context.read<EmergenciasBloc>();
    if (emergenciaBloc.state is! EmergenciasLoaded) {
      emergenciaBloc.add(const GetEmergencias());
    }

    return BlocBuilder<EmergenciasBloc, EmergenciasState>(
      builder: (context, state) {
        return SmartRefrehsCustom(
          key: const Key('__citas_list_key__'),
          onRefresh: () async {
            emergenciaBloc.add(const GetEmergencias());
          },
          refreshController: emergenciaBloc.refreshController,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppLayoutConst.paddingL),

            physics:
                const BouncingScrollPhysics(), // Asegura un desplazamiento suave

            child: Column(
              children: [
                const SizedBox(height: AppLayoutConst.spaceM),
                Text(
                  apptexts.emergenciasPage.title(n: 2),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppLayoutConst.spaceL),
                getChildByState(state, emergenciaBloc, context, user),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getChildByState(EmergenciasState state, EmergenciasBloc emergenciaBloc,
      BuildContext context, User user) {
    return switch (state) {
      EmergenciasInitial() =>
        const Center(child: CircularProgressIndicatorCustom()),
      EmergenciasError() => MessageError(
          message: state.message,
          onTap: () {
            emergenciaBloc.add(const GetEmergencias());
          }),
      EmergenciasLoaded() => Column(
          children: [
            for (final emergencia
                in state.emergencias) // Repite los elementos 5 veces
              Hero(
                tag: emergencia.hashCode,
                // child: EmergenciaCard(
                //   emergencia: emergencia,
                //   isClient: user.isClient,
                // ),
                child: Container(),
              ),
            const SizedBox(height: AppLayoutConst.spaceXL),
          ],
        ),
    };
  }
}
