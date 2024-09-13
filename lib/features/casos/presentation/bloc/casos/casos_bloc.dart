import 'dart:async';

import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/user_features.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

part 'casos_event.dart';
part 'casos_state.dart';

class CasosBloc extends Bloc<CasosEvent, CasosState> {
  CasosBloc(this._user) : super(CasosInitial()) {
    on<GetCasosUser>(_onGetCasosUser);
    on<GetCasosUserNextPage>(_onGetCasosUserNextPage);

    refreshController = RefreshController(initialRefresh: false);
    repository = CasosRepositoryImpl();
    _page = 0;
    _search = null;
  }
  final User _user;

  late RefreshController refreshController;
  late CasosRepository repository;

  late int _page;
  late String? _search;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetCasosUser(
      GetCasosUser event, Emitter<CasosState> emit) async {
    _page = 0;

    emit(CasosInitial());

    refreshController
      ..loadFailed()
      ..refreshCompleted();
    Either<Failure, List<CasoEntity>> casosResponse;

    if (event.clientePolizaId == null) {
      casosResponse = await repository.getCasosUser(_user,
          page: _page, search: _search, update: false);
    } else {
      casosResponse = await repository.getCasosUserByPolizaId(_user,
          page: _page,
          search: _search,
          clientePolizaId: event.clientePolizaId!,
          update: false);
    }

    casosResponse.fold(
      (failure) {
        emit(CasosError(message: failure.message));
      },
      (listadoCasos) {
        emit(CasosLoaded(casos: listadoCasos));
      },
    );
  }

  FutureOr<void> _onGetCasosUserNextPage(
      GetCasosUserNextPage event, Emitter<CasosState> emit) async {
    if (state is! CasosLoaded) return;

    List<CasoEntity> listadoNew = [];
    listadoNew.addAll((state as CasosLoaded).casos);

    refreshController.requestLoading();
    Either<Failure, List<CasoEntity>> casosResponse;
    if (event.clientePolizaId == null) {
      casosResponse = await repository.getCasosUser(_user,
          page: _page + 1, search: _search, update: false);
    } else {
      casosResponse = await repository.getCasosUserByPolizaId(_user,
          page: _page,
          search: _search,
          clientePolizaId: event.clientePolizaId!,
          update: false);
    }

    casosResponse.fold(
      (failure) {
        if (state is CasosLoaded) {
          refreshController.loadFailed();
          return;
        } else {
          refreshController.loadFailed();
        }
      },
      (listadoCasos) {
        _page = _page + 1;

        if (listadoCasos.isNotEmpty) {
          listadoNew.addAll(listadoCasos);

          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
        emit((state as CasosLoaded).copyWith(casos: listadoNew));
      },
    );
  }
}
