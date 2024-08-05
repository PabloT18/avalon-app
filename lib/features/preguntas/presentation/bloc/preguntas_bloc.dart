import 'dart:async';

import 'package:alumni_app/features/preguntas/preguntas.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data/models/preguntas_resonse.dart';

part 'preguntas_event.dart';
part 'preguntas_state.dart';

class PreguntasBloc extends Bloc<PreguntasEvent, PreguntasState> {
  PreguntasBloc({required this.repository}) : super(const PreguntasInitial()) {
    on<GetPreguntasEvent>(_getPreguntas);
    on<SeleccionarPregunta>(_onSeleccionarPregunta);

    refreshController = RefreshController(initialRefresh: false);
  }
  final PreguntasRepository repository;
  late RefreshController refreshController;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _getPreguntas(
      GetPreguntasEvent event, Emitter<PreguntasState> emit) async {
    emit(const PreguntasInitial());
    refreshController
      ..loadFailed()
      ..refreshCompleted();

    try {
      final listado = await repository.fetchPreguntas(event.id);
      if (listado.isEmpty) {
        emit(const PreguntasError("No hay preguntas cargadas por el momento"));
      } else {
        emit(PreguntasLoaded(
          preguntasRaiz: listado,
          preguntasSeleccionadas: const [],
          preguntasNuevas: const [],
        ));
      }
    } catch (e) {
      emit(const PreguntasError("Error al cargar las preguntas"));
    }
  }

  FutureOr<void> _onSeleccionarPregunta(
      SeleccionarPregunta event, Emitter<PreguntasState> emit) async {
    if (state is PreguntasLoaded) {
      final stateLoaded = (state as PreguntasLoaded);

      final updatedPreguntasSeleccionadas =
          List<PreguntaResponse>.from(stateLoaded.preguntasSeleccionadas)
            ..add(event.pregunta);

      emit(stateLoaded.copyWith(
        preguntasNuevas: [],
        preguntasSeleccionadas: updatedPreguntasSeleccionadas,
        inEnd: false,
        isLoadingNews: true,
      ));
      await Future.delayed(const Duration(seconds: 2));
      try {
        final listado = await repository.fetchPreguntas(event.pregunta.id ?? 0);
        if (listado.isEmpty) {
          emit((state as PreguntasLoaded).copyWith(
            inEnd: true,
            isLoadingNews: false,
          ));
        } else {
          emit((state as PreguntasLoaded).copyWith(
            preguntasNuevas: listado,
            inEnd: false,
            isLoadingNews: false,
          ));
        }
      } catch (e) {
        // emit(const PreguntasError("Error al cargar las preguntas"));

        emit(stateLoaded.copyWith(
          preguntasNuevas: [],
          inEnd: true,
          isLoadingNews: false,
        ));
      }
    }
  }
}
