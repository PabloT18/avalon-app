import 'dart:async';

import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';
import 'package:avalon_app/features/citas/citas.dart';

import 'package:avalon_app/features/emergencias/emergencias.dart';
import 'package:avalon_app/features/reclamaciones/reclamaciones.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

part 'detallecaso_event.dart';
part 'detallecaso_state.dart';

class DetalleCasoBloc extends Bloc<DetalleCasoEvent, DetalleCasoState> {
  DetalleCasoBloc(this._user, {this.caso})
      : super(caso == null
            ? DetallecasoInitial()
            : DetalleCasoLoaded(caso: caso)) {
    on<SelectCasoOption>(_onSelectCasoOption);
    on<CDGetCitas>(_onGetCitas);
    on<CDGetEmergencias>(_onGetEmergencias);
    on<CDGetReclamaciones>(_onGetReclamaciones);

    refreshController = RefreshController(initialRefresh: false);

    citasRepository = CitasRepositoryImpl();
    emergenciasRepository = EmergenciasRepositoryImpl();
    reclamacionesRepository = ReclamacionesRepositoryImpl();
    _pageCitas = 0;
  }
  final User _user;

  final CasoEntity? caso;
  late RefreshController refreshController;

  late CitasRepository citasRepository;
  late EmergenciasRepository emergenciasRepository;
  late ReclamacionesRepository reclamacionesRepository;

  late int _pageCitas;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onSelectCasoOption(
      SelectCasoOption event, Emitter<DetalleCasoState> emit) async {
    if (state is! DetalleCasoLoaded) return;
    final currentState = (state as DetalleCasoLoaded);
    emit(currentState.copyWith(
      optionSelected: event.optionSelected,
      loadingCitas: currentState.loadingCitas,
      loadingEmergencias: currentState.loadingEmergencias,
      loadingReclamaciones: currentState.loadingReclamaciones,
    ));

    if (event.optionSelected == CasoOption.citas &&
        currentState.citas == null) {
      add(const CDGetCitas());
    } else if (event.optionSelected == CasoOption.emergencia &&
        currentState.emergencias == null) {
      add(const CDGetEmergencias());
    } else if (event.optionSelected == CasoOption.reembolso &&
        currentState.reclamaciones == null) {
      add(const CDGetReclamaciones());
    }
  }

  FutureOr<void> _onGetCitas(
      CDGetCitas event, Emitter<DetalleCasoState> emit) async {
    if (state is! DetalleCasoLoaded) return;

    emit((state as DetalleCasoLoaded).copyWith(loadingCitas: true));

    final result = await citasRepository.getCitasById(
      _user,
      caso!.id!,
      page: _pageCitas,
    );

    result.fold(
      (failure) {
        emit((state as DetalleCasoLoaded).copyWith(
          erroCitas: failure.message,
          loadingCitas: false,
        ));
      },
      (citas) {
        emit((state as DetalleCasoLoaded).copyWith(
          citas: citas,
          loadingCitas: false,
        ));
      },
    );
  }

  FutureOr<void> _onGetEmergencias(
      CDGetEmergencias event, Emitter<DetalleCasoState> emit) async {
    if (state is! DetalleCasoLoaded) return;

    emit((state as DetalleCasoLoaded).copyWith(loadingEmergencias: true));

    final result = await emergenciasRepository.getEmergenciasByCaseId(
      _user,
      caso!.id!,
      page: _pageCitas,
    );

    result.fold(
      (failure) {
        emit((state as DetalleCasoLoaded).copyWith(
          errorEmergencias: failure.message,
          loadingEmergencias: false,
        ));
      },
      (emergencias) {
        emit((state as DetalleCasoLoaded).copyWith(
          emergencias: emergencias,
          loadingEmergencias: false,
        ));
      },
    );
  }

  FutureOr<void> _onGetReclamaciones(
      CDGetReclamaciones event, Emitter<DetalleCasoState> emit) async {
    if (state is! DetalleCasoLoaded) return;

    emit((state as DetalleCasoLoaded).copyWith(loadingReclamaciones: true));

    final result = await reclamacionesRepository.getReclamacionesById(
      _user,
      caso!.id!,
      page: _pageCitas,
    );

    result.fold(
      (failure) {
        emit((state as DetalleCasoLoaded).copyWith(
          errorEmergencias: failure.message,
          loadingReclamaciones: false,
        ));
      },
      (reclamaciones) {
        emit((state as DetalleCasoLoaded).copyWith(
          reclamaciones: reclamaciones,
          loadingReclamaciones: false,
        ));
      },
    );
  }
}
