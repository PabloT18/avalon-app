import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/wid_drawer.dart';
import '../bloc/casos/casos_bloc.dart';

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
        onPressed: () {},
        child: const Icon(Icons.more),
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
              Container(
                margin: const EdgeInsets.only(bottom: AppLayoutConst.marginM),
                constraints: const BoxConstraints(
                  minHeight: 100,
                ),
                // alignment: Alignment.center,
                child: Card(
                  child: ListTile(
                    onTap: () {
                      context.goNamed(
                        PAGES.detaleCaso.pageName,
                        pathParameters: {
                          'casoId': caso.id?.toString() ?? '',
                        },
                      );
                    },
                    title: TitleDescripcion(
                        title: apptexts.appOptions.cliente,
                        value: caso.clienteDisplayName ?? ' - '),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleDescripcion(
                            isSubdescription: true,
                            title: '${apptexts.casosPage.title(n: 1)} Id',
                            value: caso.id?.toString() ?? ' - '),
                        TitleDescripcion(
                            isSubdescription: true,
                            title: apptexts.appOptions.detalle(n: 1),
                            value: caso.observaciones ?? ' - '),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        )
    };
  }
}

class LitadoCasos extends StatelessWidget {
  const LitadoCasos({
    super.key,
    required this.casos,
  });

  final List<CasoEntity> casos;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final caso in casos)
          Container(
            margin: const EdgeInsets.only(bottom: AppLayoutConst.marginL),
            constraints: const BoxConstraints(
              minHeight: 300,
            ),
            // alignment: Alignment.center,
            child: Card(
              child: ListTile(
                onTap: () {},
                title: TitleDescripcion(
                    title: apptexts.appOptions.cliente,
                    value: caso.clienteDisplayName ?? ' - '),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleDescripcion(
                        isSubdescription: true,
                        title: '${apptexts.casosPage.title(n: 1)} Id',
                        value: caso.id?.toString() ?? ' - '),
                    TitleDescripcion(
                        isSubdescription: true,
                        title: apptexts.appOptions.detalle(n: 1),
                        value: caso.observaciones ?? ' - '),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class TitleDescripcion extends StatelessWidget {
  const TitleDescripcion({
    super.key,
    required this.title,
    required this.value,
    this.isSubdescription = false,
  });

  final String title;
  final String value;
  final bool isSubdescription;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title: ',
        style: isSubdescription
            ? Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold)
            : Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: value,
            style: isSubdescription
                ? Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.normal)
                : Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
