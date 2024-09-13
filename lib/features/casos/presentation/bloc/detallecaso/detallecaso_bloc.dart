import 'dart:async';

import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';
import 'package:avalon_app/features/citas/citas.dart';

import 'package:avalon_app/features/emergencias/emergencias.dart';
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
    on<GetCitas>(_onGetCitas);
    on<GetEmergencias>(_onGetEmergencias);

    refreshController = RefreshController(initialRefresh: false);

    citasRepository = CitasRepositoryImpl();
    emergenciasRepository = EmergenciasRepositoryImpl();
    _pageCitas = 0;
  }
  final User _user;

  final CasoEntity? caso;
  late RefreshController refreshController;

  late CitasRepository citasRepository;
  late EmergenciasRepository emergenciasRepository;

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
      add(const GetCitas());
    }
    if (event.optionSelected == CasoOption.emergencia &&
        currentState.emergencias == null) {
      add(const GetEmergencias());
    }
    // if (event.optionSelected == CasoOption.reembolso && currentState.citas == null) {
    if (event.optionSelected == CasoOption.reembolso) {
      add(const GetReclamaciones());
    }
  }

  FutureOr<void> _onGetCitas(
      GetCitas event, Emitter<DetalleCasoState> emit) async {
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
      GetEmergencias event, Emitter<DetalleCasoState> emit) {}
}
