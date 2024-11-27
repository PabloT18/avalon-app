import 'dart:async';

import 'package:avalon_app/features/emergencias/emergencias.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

part 'emergencias_event.dart';
part 'emergencias_state.dart';

class EmergenciasBloc extends Bloc<EmergenciasEvent, EmergenciasState> {
  EmergenciasBloc(this._user) : super(EmergenciasInitial()) {
    on<GetEmergencias>(_onGetEmergencias);
    on<GetEmergenciasNextPage>(_onGetEmergenciasNextPage);
    refreshController = RefreshController(initialRefresh: false);

    reclamacioesRepository = EmergenciasRepositoryImpl();

    _pageCitas = 0;
  }
  final User _user;

  late RefreshController refreshController;

  late EmergenciasRepository reclamacioesRepository;

  late int _pageCitas;

  late String? search;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetEmergencias(
      GetEmergencias event, Emitter<EmergenciasState> emit) async {
    emit(EmergenciasInitial());
    _pageCitas = 0;
    search = event.search;

    refreshController
      ..loadFailed()
      ..refreshCompleted();
    final emergencias = await reclamacioesRepository.getEmergencias(_user,
        page: _pageCitas, search: search);

    emergencias.fold((l) {
      emit(EmergenciasError(l.message));
    }, (emergencias) {
      if (emergencias.isEmpty) {
        emit(EmergenciasError(apptexts.appOptions.noData));
      } else {
        emit(EmergenciasLoaded(emergencias));
      }
    });
  }

  FutureOr<void> _onGetEmergenciasNextPage(
      GetEmergenciasNextPage event, Emitter<EmergenciasState> emit) async {
    // emit(ReclamacionesInitial());

    if (state is! EmergenciasLoaded) return;

    List<EmergenciaModel> listadoNew = [];
    listadoNew.addAll((state as EmergenciasLoaded).emergencias);

    refreshController.requestLoading();

    final reclamaciones = await reclamacioesRepository.getEmergencias(
      _user,
      page: _pageCitas + 1,
      search: search,
    );

    reclamaciones.fold((l) {
      if (state is EmergenciasLoaded) {
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
      emit((state as EmergenciasLoaded).copyWith(emergencias: listadoNew));
    });
  }
}
