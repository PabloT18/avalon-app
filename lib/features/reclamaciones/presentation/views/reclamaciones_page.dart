import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/app/presentation/bloc/creationEntities/creation_cubit_cubit.dart';
import 'package:avalon_app/app/presentation/bloc/settings_cubit/app_settings_cubit.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';

import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_models/shared_models.dart';

import '../bloc/reclamaciones_bloc.dart';
import 'wid_reclamacion_card.dart';

class ReclamacionesPage extends StatelessWidget {
  const ReclamacionesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          apptexts.reclamacionesPage.title(n: 2),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 6,
        iconTheme: const IconThemeData(
          color: Colors.white, // Cambia el color del icono de hamburguesa
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // context.goNamed(PAGES.settings.pageName);
              _showInfoStatesDialog(context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // mini: true,
        onPressed: () {
          context.goNamed(PAGES.crearReclamacion.pageName);
        },
        backgroundColor: AppColors.primaryBlue,
        // child: const Icon(
        //   Icons.add,
        //   color: Colors.white,
        // ),
        label: Text(
          apptexts.reclamacionesPage.nuevaReclamacion,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => ReclamacionesBloc(user),
        child: const ReclamacionesPanel(),
      ),
    );
  }

  void _showInfoStatesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(apptexts.reclamacionesPage.estados,
              style: Theme.of(context).textTheme.titleSmall),
          content: Padding(
            padding: const EdgeInsets.all(AppLayoutConst.paddingM).copyWith(
              bottom: 0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: AppLayoutConst.spaceM),
                Row(
                  children: [
                    Container(
                      width: AppLayoutConst.dotSize, // Tamaño del círculo
                      height: AppLayoutConst.dotSize,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                        width: AppLayoutConst
                            .spaceL), // Espacio entre el círculo y el texto
                    Expanded(
                      child: Text(
                        apptexts.reclamacionesPage.estadoPorGestionar,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppLayoutConst.spaceM),
                Row(
                  children: [
                    Container(
                      width: AppLayoutConst.dotSize, // Tamaño del círculo
                      height: AppLayoutConst.dotSize,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                        width: AppLayoutConst
                            .spaceL), // Espacio entre el círculo y el texto
                    Expanded(
                      child: Text(
                        apptexts.reclamacionesPage.estadoGestionando,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppLayoutConst.spaceM),
                Row(
                  children: [
                    Container(
                      width: AppLayoutConst.dotSize, // Tamaño del círculo
                      height: AppLayoutConst.dotSize,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                        width: AppLayoutConst
                            .spaceL), // Espacio entre el círculo y el texto
                    Expanded(
                      child: Text(
                        apptexts.reclamacionesPage.estadoCerrado,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(apptexts.appOptions.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}

class ReclamacionesPanel extends StatelessWidget {
  const ReclamacionesPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return ReclamacionesPanelView(
          user: user,
        );
      },
    );
  }
}

class ReclamacionesPanelView extends StatelessWidget {
  const ReclamacionesPanelView({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final reclamacionesBloc = context.read<ReclamacionesBloc>();
    if (reclamacionesBloc.state is! ReclamacionesLoaded) {
      reclamacionesBloc.add(const GetReclamaciones());
    }

    return BlocListener<CreationCubit, CreationState>(
      listener: (context, state) {
        if (state is ItemCreated && state.itemType == ItemType.reclamaciones) {
          reclamacionesBloc.add(const GetReclamaciones());
        }
      },
      child: BlocBuilder<ReclamacionesBloc, ReclamacionesState>(
        builder: (context, state) {
          return SmartRefrehsCustom(
            key: const Key('__reclamaciones_list_key__'),
            onRefresh: () async {
              reclamacionesBloc.add(const GetReclamaciones());
            },
            enablePullDown: true,
            enablePullUp: true,
            onLoading: () =>
                reclamacionesBloc.add(const GetReclamacionesNextPage()),
            refreshController: reclamacionesBloc.refreshController,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppLayoutConst.paddingL),

              physics:
                  const BouncingScrollPhysics(), // Asegura un desplazamiento suave

              child: Column(
                children: [
                  const SizedBox(height: AppLayoutConst.spaceM),
                  // Text(
                  //   apptexts.reclamacionesPage.title(n: 2),
                  //   style: Theme.of(context).textTheme.titleSmall,
                  // ),
                  getChildByState(state, reclamacionesBloc, context),
                  // const SizedBox(height: AppLayoutConst.spaceL),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getChildByState(ReclamacionesState state,
      ReclamacionesBloc reclamacionesBloc, BuildContext context) {
    final TextEditingController busquedaController = TextEditingController();

    return switch (state) {
      ReclamacionesInitial() =>
        const Center(child: CircularProgressIndicatorCustom()),
      ReclamacionesError() => MessageError(
          message: state.message,
          onTap: () {
            reclamacionesBloc.add(const GetReclamaciones());
          }),
      ReclamacionesLoaded() => Column(
          children: [
            TextField(
              controller: busquedaController,
              onEditingComplete: () {
                final query = busquedaController.text;
                if (query.isNotEmpty) {
                  // Acción al presionar la lupa
                  reclamacionesBloc.add(GetReclamaciones(search: query));
                } else {
                  reclamacionesBloc.add(const GetReclamaciones());
                }
              },
              decoration: InputDecoration(
                hintText: apptexts.appOptions.search,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final query = busquedaController.text;
                    if (query.isNotEmpty) {
                      // Acción al presionar la lupa
                      reclamacionesBloc.add(GetReclamaciones(search: query));
                    } else {
                      reclamacionesBloc.add(const GetReclamaciones());
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: AppLayoutConst.spaceS),
            for (final recalmacion
                in state.recalmaciones) // Repite los elementos 5 veces
              Hero(
                  tag: recalmacion.hashCode,
                  child: ReclamacionCard(
                    navigatePush: true,
                    reclamacion: recalmacion,
                    isClient: user.isClient,
                  )),
            // const SizedBox(height: AppLayoutConst.spaceXL),
          ],
        ),
    };
  }
}
