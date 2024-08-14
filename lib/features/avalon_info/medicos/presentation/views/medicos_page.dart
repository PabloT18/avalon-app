import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/features/shared/widgets/wid_drawer.dart';

import '../bloc/medicos_bloc.dart';

class MedicosPage extends StatelessWidget {
  const MedicosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<MedicosBloc>()..add(const GetMedicos()),
      child: const MedicosPageView(),
    );
  }
}

class MedicosPageView extends StatelessWidget {
  const MedicosPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final medicosBloc = context.read<MedicosBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicos'),
        elevation: 6,
      ),
      drawer: DrawerCustom(
        indexInitial: getDrawerOptionIndex(PAGES.medicos.pageName),
      ),
      body: BlocBuilder<MedicosBloc, MedicosState>(
        builder: (context, state) {
          return SmartRefrehsCustom(
              key: const Key('__medicos_list_key__'),
              onRefresh: () async {
                medicosBloc.add(const GetMedicos());
              },
              refreshController: medicosBloc.refreshController,
              child: getChildByState(state, medicosBloc));
        },
      ),
    );
  }

  Widget getChildByState(MedicosState state, medicosBloc) {
    return switch (state) {
      MedicosLoading() => const Center(child: CircularProgressIndicator()),
      MedicosError() => MessageError(
          message:
              'Error al cargar las preguntas, por favor intente nuevamente',
          onTap: () {
            medicosBloc.add(const GetMedicos());
          }),
      MedicosLoaded() => ListView(
          children: [
            for (final medico in state.medicos)
              ListTile(
                title: Text(medico.nombres ?? ''),
                subtitle: Text(medico.especialidad?.nombre ?? ''),
              ),
          ],
        ),
    };
  }
}
