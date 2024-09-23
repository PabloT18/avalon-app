import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/app/presentation/bloc/creationEntities/creation_cubit_cubit.dart';
import 'package:avalon_app/app/presentation/bloc/settings_cubit/app_settings_cubit.dart';
import 'package:avalon_app/core/config/responsive/responsive_class.dart';

import 'package:avalon_app/features/citas/citas.dart';
import 'package:avalon_app/features/citas/presentation/bloc/cita/citas_bloc.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

import '../widgets/cita_card.dart';

class CitasPage extends StatelessWidget {
  const CitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final locale = TranslationProvider.of(context).locale;

    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(apptexts.citasPage.title(n: 2)),
            elevation: 6,
          ),
          body: const CitasPanel(),
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
            refreshController: citasBloc.refreshController,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppLayoutConst.paddingL),

              physics:
                  const BouncingScrollPhysics(), // Asegura un desplazamiento suave

              child: Column(
                children: [
                  const SizedBox(height: AppLayoutConst.spaceM),
                  Text(
                    apptexts.citasPage.title(n: 2),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppLayoutConst.spaceL),
                  getChildByState(state, citasBloc, context, user),
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
    return switch (state) {
      CitasInitial() => const Center(child: CircularProgressIndicatorCustom()),
      CitasError() => MessageError(
          message: state.message,
          onTap: () {
            citasBloc.add(const GetCitas());
          }),
      CitasLoaded() => Column(
          children: [
            for (final cita in state.citas) // Repite los elementos 5 veces
              Hero(
                tag: cita.hashCode,
                child: CitaCard(
                  cita: cita,
                  isClient: user.isClient,
                ),
              ),
            const SizedBox(height: AppLayoutConst.spaceXL),
          ],
        ),
    };
  }
}
