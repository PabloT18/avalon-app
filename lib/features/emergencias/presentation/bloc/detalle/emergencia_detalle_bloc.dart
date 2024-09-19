import 'dart:async';

import 'package:avalon_app/features/emergencias/emergencias.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

part 'emergencia_detalle_event.dart';
part 'emergencia_detalle_state.dart';

class EmergenciaDetalleBloc
    extends Bloc<EmergenciaDetalleEvent, EmergenciaDetalleState> {
  EmergenciaDetalleBloc(this._user, {this.emergencia})
      : super(emergencia == null
            ? EmergenciaDetalleInitial()
            : EmergenciaDetalleLoaded(emergenciaModel: emergencia)) {
    on<GetEmergenciaHistorial>(_onGetEmergenciaHistorial);
    // on<GetEmergencias>(_onGetEmergencias);

    refreshController = RefreshController(initialRefresh: false);

    emerRepository = EmergenciasRepositoryImpl();

    if (emergencia != null) {
      add(const GetEmergenciaHistorial());
    }
  }
  final User _user;

  final EmergenciaModel? emergencia;
  late RefreshController refreshController;

  late EmergenciasRepository emerRepository;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetEmergenciaHistorial(GetEmergenciaHistorial event,
      Emitter<EmergenciaDetalleState> emit) async {
    if (state is! EmergenciaDetalleLoaded) return;
    final currrentStat = (state as EmergenciaDetalleLoaded);

    final comentariosResponse = await emerRepository.getEmergenciasHistorial(
        _user, currrentStat.emergenciaModel.id!);

    comentariosResponse.fold(
      (l) => emit(currrentStat.copyWith(
          messageErrorLoadComentarios: apptexts.appOptions.historialError)),
      (r) => emit(currrentStat.copyWith(
        comentarios: r,
        messageErrorLoadComentarios: null,
      )),
    );
  }
}
