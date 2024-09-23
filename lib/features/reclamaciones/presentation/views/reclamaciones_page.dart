import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/app/presentation/bloc/creationEntities/creation_cubit_cubit.dart';
import 'package:avalon_app/app/presentation/bloc/settings_cubit/app_settings_cubit.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';

import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

import '../bloc/reclamaciones_bloc.dart';
import 'wid_reclamacion_card.dart';

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
                  Text(
                    apptexts.reclamacionesPage.title(n: 2),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppLayoutConst.spaceL),
                  getChildByState(state, reclamacionesBloc, context),
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
            for (final recalmacion
                in state.recalmaciones) // Repite los elementos 5 veces
              Hero(
                  tag: recalmacion.hashCode,
                  child: ReclamacionCard(
                    reclamacion: recalmacion,
                    isClient: user.isClient,
                  )),
            const SizedBox(height: AppLayoutConst.spaceXL),
          ],
        ),
    };
  }
}
