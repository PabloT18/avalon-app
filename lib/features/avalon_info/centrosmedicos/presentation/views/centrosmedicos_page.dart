import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/features/shared/widgets/wid_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/centros_medicos_bloc.dart';

class CentrosMedicosPage extends StatelessWidget {
  const CentrosMedicosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<CentrosMedicosBloc>(),
      child: const CentrosMedicosPageView(),
    );
  }
}

class CentrosMedicosPageView extends StatelessWidget {
  const CentrosMedicosPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final centrosMedicosBloc = context.read<CentrosMedicosBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Centrosm Medicos'),
        elevation: 6,
      ),
      drawer: DrawerCustom(
        indexInitial: getDrawerOptionIndex(PAGES.centrosMedicos.pageName),
      ),
      body: BlocBuilder<CentrosMedicosBloc, CentrosMedicosState>(
        builder: (context, state) {
          return SmartRefrehsCustom(
              key: const Key('__centrosMedicos_list_key__'),
              onRefresh: () async {
                centrosMedicosBloc.add(const GetCentrosMedicos());
              },
              refreshController: centrosMedicosBloc.refreshController,
              child: getChildByState(state, context, centrosMedicosBloc));
        },
      ),
    );
  }

  Widget getChildByState(
      CentrosMedicosState state, BuildContext context, centrosMedicosBloc) {
    return switch (state) {
      CentrosMedicosLoading() =>
        const Center(child: CircularProgressIndicator()),
      CentrosMedicosError() => MessageError(
          message:
              'Error al cargar las preguntas, por favor intente nuevamente',
          onTap: () {
            centrosMedicosBloc.add(const GetCentrosMedicos());
          }),
      CentrosMedicosLoaded() => ListView(
          children: [
            for (final centromedico in state.centrosMedicos)
              ListTile(
                title: Text(centromedico.nombre ?? ''),
                subtitle: Text(centromedico.descripcion ?? ''),
              ),
          ],
        ),
    };
  }
}
