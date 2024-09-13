import 'dart:async';

import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/casos/data/repository/casos_repository_impl.dart';
import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';
import 'package:avalon_app/features/casos/domain/repository/casos_repository.dart';
import 'package:avalon_app/features/citas/data/repository/citas_repository_impl.dart';
import 'package:avalon_app/features/citas/domain/repository/citas_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

part 'cita_nueva_event.dart';
part 'cita_nueva_state.dart';

class CitaNuevaBloc extends Bloc<CitaNuevaEvent, CitaNuevaState> {
  CitaNuevaBloc(this._user, {this.caso}) : super(const CitaNuevaState()) {
    on<GetCasosCita>(_onGetCasosUser);
    // on<SelectCasoOption>(_onSelectCasoOption);
    // on<GetCitas>(_onGetCitas);
    // on<GetEmergencias>(_onGetEmergencias);

    refreshController = RefreshController(initialRefresh: false);

    citasRepository = CitasRepositoryImpl();
    casosRepository = CasosRepositoryImpl();
    _page = 0;

    _pageCitas = 0;
  }
  final User _user;
  late int _page;

  final CasoEntity? caso;
  late RefreshController refreshController;

  late CitasRepository citasRepository;
  // late EmergenciasRepository emergenciasRepository;
  late CasosRepository casosRepository;

  late int _pageCitas;

  FutureOr<void> _onGetCasosUser(
      GetCasosCita event, Emitter<CitaNuevaState> emit) async {
    _page = 0;

    // emit(CasosInitial());

    refreshController
      ..loadFailed()
      ..refreshCompleted();
    Either<Failure, List<CasoEntity>> casosResponse;

    // if (event.clientePolizaId == null) {
    casosResponse = await casosRepository.getCasosUser(_user,
        page: _page, search: null, update: false);
    // } else {
    //   casosResponse = await casosRepository.getCasosUserByPolizaId(_user,
    //       page: _page,
    //       search: null,
    //       clientePolizaId: event.clientePolizaId!,
    //       update: false);
    // }

    casosResponse.fold(
      (failure) {
        emit(CitaNuevaState(message: failure.message));
      },
      (listadoCasos) {
        emit(CitaNuevaState(casos: listadoCasos));
      },
    );
  }
}
