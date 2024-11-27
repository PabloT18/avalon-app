import 'dart:async';

import 'package:avalon_app/features/citas/citas.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

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
    on<GetCitasNextPage>(_onGetCitasNextPage);

    refreshController = RefreshController(initialRefresh: false);

    citasRepository = CitasRepositoryImpl();

    _pageCitas = 0;
  }
  final User _user;

  late RefreshController refreshController;

  late CitasRepository citasRepository;

  late int _pageCitas;

  late String? search;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetCitas(GetCitas event, Emitter<CitasState> emit) async {
    emit(CitasInitial());

    _pageCitas = 0;
    search = event.search;
    refreshController
      ..loadFailed()
      ..refreshCompleted();
    final citas =
        await citasRepository.getCitas(_user, page: _pageCitas, search: search);

    citas.fold((l) {
      emit(CitasError(l.message));
    }, (citas) {
      if (citas.isEmpty) {
        emit(CitasError(apptexts.appOptions.noData));
      } else {
        emit(CitasLoaded(citas));
      }
    });
  }

  FutureOr<void> _onGetCitasNextPage(
      GetCitasNextPage event, Emitter<CitasState> emit) async {
    if (state is! CitasLoaded) return;

    List<CitaMedica> listadoNew = [];
    listadoNew.addAll((state as CitasLoaded).citas);

    refreshController.requestLoading();

    final reclamaciones = await citasRepository.getCitas(
      _user,
      page: _pageCitas + 1,
      search: search,
    );

    reclamaciones.fold((l) {
      if (state is CitasLoaded) {
        refreshController.loadFailed();
        return;
      } else {
        refreshController.loadFailed();
      }
    }, (reclamaciones) {
      _pageCitas = _pageCitas + 1;
      if (reclamaciones.isNotEmpty) {
        listadoNew.addAll(reclamaciones);
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
      emit((state as CitasLoaded).copyWith(citas: listadoNew));
    });
  }
}
