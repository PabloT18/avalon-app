import 'dart:async';

import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/casos/data/repository/casos_repository_impl.dart';
import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';
import 'package:avalon_app/features/casos/domain/repository/casos_repository.dart';
import 'package:avalon_app/features/citas/data/repository/citas_repository_impl.dart';
import 'package:avalon_app/features/citas/domain/repository/citas_repository.dart';
import 'package:avalon_app/features/emergencias/emergencias.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

part 'emergencia_nueva_event.dart';
part 'emergencia_nueva_state.dart';

class EmergenciaNuevaBloc
    extends Bloc<EmergenciaNuevaEvent, EmergenciaNuevaState> {
  EmergenciaNuevaBloc(this._user, {this.caso})
      : super(const EmergenciaNuevaState()) {
    on<GetCasoEmergencia>(_onGetCasosUser);
    on<WaitForCreateCase>(_onWaitForCreateCase);
    on<SelectCasoEmergencia>(_onSelectCaso);

    // on<SelectCasoOption>(_onSelectCasoOption);
    // on<GetCitas>(_onGetCitas);
    // on<GetEmergencias>(_onGetEmergencias);

    refreshController = RefreshController(initialRefresh: false);

    citasRepository = CitasRepositoryImpl();
    casosRepository = CasosRepositoryImpl();
    _page = 0;

    _pageCitas = 0;

    add(const GetCasoEmergencia());
  }
  final User _user;
  late int _page;

  final CasoEntity? caso;
  late RefreshController refreshController;

  late CitasRepository citasRepository;
  late CasosRepository casosRepository;

  late int _pageCitas;

  FutureOr<void> _onGetCasosUser(
      GetCasoEmergencia event, Emitter<EmergenciaNuevaState> emit) async {
    _page = 0;

    // emit(CasosInitial());

    refreshController
      ..loadFailed()
      ..refreshCompleted();
    Either<Failure, List<CasoEntity>> casosResponse;

    // if (event.clientePolizaId == null) {
    casosResponse = await casosRepository.getCasosUser(_user,
        page: _page, search: null, update: false);

    casosResponse.fold(
      (failure) {
        emit(EmergenciaNuevaState(message: failure.message));
      },
      (listadoCasos) {
        emit(EmergenciaNuevaState(casos: listadoCasos));
      },
    );
  }

  FutureOr<void> _onWaitForCreateCase(
      WaitForCreateCase event, Emitter<EmergenciaNuevaState> emit) {
    emit(state.copyWith(waitForCreateCase: true));
  }

  FutureOr<void> _onSelectCaso(
      SelectCasoEmergencia event, Emitter<EmergenciaNuevaState> emit) async {
    emit(state.copyWith(casoSeleccionado: event.caso));
  }
}
