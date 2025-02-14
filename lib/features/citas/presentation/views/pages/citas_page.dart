import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/app/presentation/bloc/creationEntities/creation_cubit_cubit.dart';
import 'package:avalon_app/app/presentation/bloc/settings_cubit/app_settings_cubit.dart';
import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';

import 'package:avalon_app/features/citas/citas.dart';
import 'package:avalon_app/features/citas/presentation/bloc/cita/citas_bloc.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_models/shared_models.dart';

import '../widgets/cita_card.dart';

class CitasPage extends StatelessWidget {
  const CitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final locale = TranslationProvider.of(context).locale;
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              apptexts.citasPage.title(n: 2),
            ),
            elevation: 6,
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
            onPressed: () {
              context.goNamed(PAGES.crearCita.pageName);
            },
            // focusColor: Colors.white,
            backgroundColor: AppColors.primaryBlue,
            // child: const Icon(
            //   Icons.add,
            //   color: Colors.white,
            // ),
            label: Text(
              apptexts.citasPage.nuevaCita,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: BlocProvider(
            create: (context) => CitasBloc(user),
            child: const CitasPanel(),
          ),
        );
      },
    );
  }

  void _showInfoStatesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(apptexts.citasPage.estados,
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
                        apptexts.citasPage.estadoPorGestionar,
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
                        apptexts.citasPage.estadoGestionando,
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
                        apptexts.citasPage.estadoCerrado,
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

class CitasPanel extends StatelessWidget {
  const CitasPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return const CitasPanelView();
      },
    );
  }
}

class CitasPanelView extends StatelessWidget {
  const CitasPanelView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    final citasBloc = context.read<CitasBloc>();
    if (citasBloc.state is! CitasLoaded) {
      citasBloc.add(const GetCitas());
    }

    return BlocListener<CreationCubit, CreationState>(
      listener: (context, state) {
        if (state is ItemCreated && state.itemType == ItemType.citas) {
          citasBloc.add(const GetCitas());
        }
      },
      child: BlocBuilder<CitasBloc, CitasState>(
        builder: (context, state) {
          return SmartRefrehsCustom(
            key: const Key('__citas_list_key__'),
            onRefresh: () async {
              citasBloc.add(const GetCitas());
            },
            enablePullDown: true,
            enablePullUp: true,
            onLoading: () => citasBloc.add(const GetCitasNextPage()),
            refreshController: citasBloc.refreshController,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppLayoutConst.paddingL),

              physics:
                  const BouncingScrollPhysics(), // Asegura un desplazamiento suave

              child: Column(
                children: [
                  const SizedBox(height: AppLayoutConst.spaceM),
                  // Text(
                  //   apptexts.citasPage.title(n: 2),
                  //   style: Theme.of(context).textTheme.titleSmall,
                  // ),

                  getChildByState(state, citasBloc, context, user),
                  // const SizedBox(height: AppLayoutConst.spaceL),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getChildByState(
      CitasState state, CitasBloc citasBloc, BuildContext context, User user) {
    final TextEditingController busquedaController = TextEditingController();

    return switch (state) {
      CitasInitial() => const Center(child: CircularProgressIndicatorCustom()),
      CitasError() => MessageError(
          message: state.message,
          onTap: () {
            citasBloc.add(const GetCitas());
          }),
      CitasLoaded() => Column(
          children: [
            TextField(
              controller: busquedaController,
              onEditingComplete: () {
                final query = busquedaController.text;
                if (query.isNotEmpty) {
                  // Acción al presionar la lupa
                  citasBloc.add(GetCitas(search: query));
                } else {
                  citasBloc.add(const GetCitas());
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
                      citasBloc.add(GetCitas(search: query));
                    } else {
                      citasBloc.add(const GetCitas());
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: AppLayoutConst.spaceM),
            for (final cita in state.citas) // Repite los elementos 5 veces
              Hero(
                tag: cita.hashCode,
                child: CitaCard(
                  navigatePush: true,
                  cita: cita,
                  isClient: user.isClient,
                ),
              ),
            // const SizedBox(height: AppLayoutConst.spaceXL),
          ],
        ),
    };
  }
}
