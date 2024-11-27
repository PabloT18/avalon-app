import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';

import 'package:avalon_app/core/config/router/app_routes_pages.dart';

import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/wid_drawer.dart';
import '../bloc/casos/casos_bloc.dart';
import 'widgets/wid_caso_card.dart';

class CasosPage extends StatelessWidget {
  const CasosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;
    return BlocProvider(
      lazy: false,
      create: (context) => CasosBloc(user)..add(const GetCasosUser()),
      child: const CasosPageView(),
    );
  }
}

class CasosPageView extends StatelessWidget {
  const CasosPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final casosBloc = context.read<CasosBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.casosPage.title(n: 2)),
        elevation: 6,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(PAGES.crearCaso.pageName);
        },
        child: const Icon(Icons.add),
      ),
      drawer: DrawerCustom(indexInitialName: PAGES.casos.pageName),
      body: BlocBuilder<CasosBloc, CasosState>(
        builder: (context, state) {
          return SmartRefrehsCustom(
              key: const Key('__casos_list_key__'),
              enablePullUp: true,
              onRefresh: () async {
                casosBloc.add(const GetCasosUser());
              },
              refreshController: casosBloc.refreshController,
              onLoading: () {
                casosBloc.add(const GetCasosUserNextPage());
              },
              child: getChildByState(state, casosBloc, context));
        },
      ),
    );
  }

  Widget getChildByState(CasosState state, medicosBloc, BuildContext context) {
    return switch (state) {
      CasosInitial() => const Center(child: CircularProgressIndicator()),
      CasosError() => MessageError(
          message: state.message,
          onTap: () {
            medicosBloc.add(const GetCasosUser());
          }),
      CasosLoaded() => ListView(
          children: [
            for (final caso in state.casos)
              Hero(
                tag: caso.hashCode,
                child: CaseCard(
                  caso: caso,
                ),
              )
          ],
        )
    };
  }
}
