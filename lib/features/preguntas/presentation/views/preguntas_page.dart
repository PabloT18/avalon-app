import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/preguntas/preguntas.dart';

import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/features/shared/widgets/wid_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/alerts/alert_message_error.dart';

class PreguntasPage extends StatelessWidget {
  const PreguntasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreguntasBloc(
        repository: context.read<PreguntasRepository>(),
      )..add(const GetPreguntasEvent(0)),
      child: const PreguntasPageView(),
    );
  }
}

class PreguntasPageView extends StatelessWidget {
  const PreguntasPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final preguntasBloc = context.read<PreguntasBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preguntas'),
        elevation: 6,
      ),
      drawer: DrawerCustom(indexInitialName: PAGES.preguntas.pageName),
      body: BlocBuilder<PreguntasBloc, PreguntasState>(
        builder: (context, state) {
          return SmartRefrehsCustom(
              key: const Key('__preguntas_list_key__'),
              onRefresh: () async {
                preguntasBloc.add(const GetPreguntasEvent(0));
              },
              refreshController: preguntasBloc.refreshController,
              child: getChildByState(state, context, preguntasBloc));
        },
      ),
    );
  }

  Widget getChildByState(
      PreguntasState state, BuildContext context, PreguntasBloc preguntasBloc) {
    final responsive = ResponsiveCustom.of(context);
    return switch (state) {
      PreguntasInitial() => const Center(child: CircularProgressIndicator()),
      PreguntasError() => MessageError(
          message:
              'Error al cargar las preguntas, por favor intente nuevamente',
          onTap: () {
            preguntasBloc.add(const GetPreguntasEvent(0));
          }),
      PreguntasLoaded() => state.preguntasSeleccionadas.isEmpty
          ? ListView(children: [
              ...state.preguntasRaiz.map((pregunta) => FadeIn(
                    delay: Duration(
                        milliseconds:
                            200 * state.preguntasRaiz.indexOf(pregunta)),
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(pregunta.contenido ?? 'Sin contenido'),
                        onTap: () {
                          preguntasBloc.add(SeleccionarPregunta(pregunta));
                        },
                      ),
                    ),
                  ))
            ])
          : ListView(children: [
              SizedBox(
                height: responsive.hp(1),
              ),
              ...state.preguntasSeleccionadas.map((pregunta) {
                int index = state.preguntasSeleccionadas.indexOf(pregunta);
                bool isLast = index == state.preguntasSeleccionadas.length - 1;
                return Column(
                  children: [
                    FadeInLeft(
                      child: SizedBox(
                        // width:
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.only(
                              left: 15, right: responsive.wp(15)),
                          color: AppColors.threeBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ListTile(
                            title:
                                Text((pregunta.contenido ?? 'Sin contenido')),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: responsive.hp(1)),
                    if (isLast && state.isLoadingNews)
                      Card(
                        elevation: 0,
                        margin:
                            EdgeInsets.only(left: responsive.wp(15), right: 15),
                        color: AppColors.threeBlue.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const ListTile(
                          title: Text('...'),
                        ),
                      ),
                    if (isLast && !state.isLoadingNews)
                      Card(
                        elevation: 0,
                        margin:
                            EdgeInsets.only(left: responsive.wp(15), right: 15),
                        color: AppColors.threeBlue.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          title: Text(pregunta.respuesta ?? 'Sin respuesta'),
                        ),
                      ),
                    if (!isLast)
                      Card(
                        elevation: 0,
                        margin:
                            EdgeInsets.only(left: responsive.wp(15), right: 15),
                        color: AppColors.threeBlue.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          title: Text(pregunta.respuesta ?? 'Sin respuesta'),
                        ),
                      ),
                    SizedBox(height: responsive.hp(2)),
                  ],
                );
              }),
              if (state.preguntasNuevas.isNotEmpty && !state.isEnd)
                ...state.preguntasNuevas.map((pregunta) => FadeIn(
                      delay: Duration(
                          milliseconds:
                              200 * state.preguntasRaiz.indexOf(pregunta)),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(pregunta.contenido ?? 'Sin contenido'),
                          onTap: () {
                            preguntasBloc.add(SeleccionarPregunta(pregunta));
                          },
                        ),
                      ),
                    )),
              if (state.preguntasNuevas.isEmpty && state.isEnd) ...[
                SizedBox(height: responsive.hp(5)),
                const Align(
                    alignment: Alignment.center,
                    child: Text('Esperamos haberte ayudado. ')),
                TextButton(
                    onPressed: () => {
                          preguntasBloc.add(const GetPreguntasEvent(0)),
                        },
                    child: const Text('Regresar al Inicio')),
              ],
              SizedBox(height: responsive.hp(10)),
            ]),
    };
  }
}
