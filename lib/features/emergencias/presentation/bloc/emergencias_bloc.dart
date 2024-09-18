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
    on<GetEmergencias>(_onGetReclamaciones);
    refreshController = RefreshController(initialRefresh: false);

    reclamacioesRepository = EmergenciasRepositoryImpl();

    _pageCitas = 0;
  }
  final User _user;

  late RefreshController refreshController;

  late EmergenciasRepository reclamacioesRepository;

  late int _pageCitas;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetReclamaciones(
      GetEmergencias event, Emitter<EmergenciasState> emit) async {
    emit(EmergenciasInitial());

    refreshController
      ..loadFailed()
      ..refreshCompleted();
    final emergencias =
        await reclamacioesRepository.getEmergencias(_user, page: _pageCitas);

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
}
