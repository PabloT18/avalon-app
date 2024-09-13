import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/nuevacita/cita_nueva_bloc.dart';

class CrearCitaPage extends StatelessWidget {
  const CrearCitaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => CitaNuevaBloc(user),
      child: const CrearCitaView(),
    );
  }
}

class CrearCitaView extends StatelessWidget {
  const CrearCitaView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cerarCitaBloc = context.read<CitaNuevaBloc>();
    cerarCitaBloc.add(const GetCasosCita());
    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.citasPage.nuevaCita),
        elevation: 6,
      ),
      body: BlocBuilder<CitaNuevaBloc, CitaNuevaState>(
        builder: (context, state) {
          return SmartRefrehsCustom(
              key: const Key('__crear_cita_key__'),
              onRefresh: () async {
                // casoBloc.add(const GetCasosUser());
              },
              refreshController: cerarCitaBloc.refreshController,
              // child: getChildByState(state, cerarCitaBloc, context));
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppLayoutConst.spaceM),
                    Text(
                      apptexts.citasPage.citaSinCaso,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppLayoutConst.spaceS),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text(apptexts.citasPage.creaCasoCita)),
                    ),
                    const SizedBox(height: AppLayoutConst.spaceS),
                    Text(
                      apptexts.citasPage.citaEnCaso,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Center(child: CircularProgressIndicatorCustom()),
                  ],
                ),
              ));
        },
      ),
    );
  }

  // Widget getChildByState(
  //     CitaNuevaState state, CitaNuevaBloc cerarCitaBloc, BuildContext context) {
  //   return switch (state) {
  //     CitaNuevaInitial() => Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const SizedBox(height: AppLayoutConst.spaceM),
  //             Text(
  //               apptexts.citasPage.citaSinCaso,
  //               style: Theme.of(context).textTheme.titleSmall,
  //             ),
  //             const SizedBox(height: AppLayoutConst.spaceS),
  //             Center(
  //               child: ElevatedButton(
  //                   onPressed: () {},
  //                   child: Text(apptexts.citasPage.creaCasoCita)),
  //             ),
  //             const SizedBox(height: AppLayoutConst.spaceS),
  //             Text(
  //               apptexts.citasPage.citaEnCaso,
  //               style: Theme.of(context).textTheme.titleSmall,
  //             ),
  //             const Center(child: CircularProgressIndicatorCustom()),
  //           ],
  //         ),
  //       ),
  //     CitaNuevaLoading() =>
  //       const Center(child: CircularProgressIndicatorCustom()),
  //     CitaNuevaSuccess() =>
  //       const Center(child: CircularProgressIndicatorCustom()),
  //     CitaNuevaError() =>
  //       const Center(child: CircularProgressIndicatorCustom()),
  //   };
  // }
}
