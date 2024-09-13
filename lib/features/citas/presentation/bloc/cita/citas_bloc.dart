import 'dart:async';

import 'package:avalon_app/features/citas/citas.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

part 'citas_event.dart';
part 'citas_state.dart';

class CitasBloc extends Bloc<CitasEvent, CitasState> {
  CitasBloc(
    this._user,
  ) : super(CitasInitial()) {
    on<GetCitas>(_onGetCitas);

    refreshController = RefreshController(initialRefresh: false);

    citasRepository = CitasRepositoryImpl();

    _pageCitas = 0;
  }
  final User _user;

  late RefreshController refreshController;

  late CitasRepository citasRepository;

  late int _pageCitas;

  FutureOr<void> _onGetCitas(GetCitas event, Emitter<CitasState> emit) async {
    emit(CitasInitial());

    refreshController
      ..loadFailed()
      ..refreshCompleted();
    final citas = await citasRepository.getCitas(_user, page: _pageCitas);

    citas.fold((l) {
      emit(CitasError(l.message));
    }, (r) {
      emit(CitasLoaded(r));
    });
  }
}
