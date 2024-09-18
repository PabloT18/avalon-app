import 'dart:async';

import 'package:avalon_app/features/citas/citas.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

part 'cita_detalle_event.dart';
part 'cita_detalle_state.dart';

class CitaDetalleBloc extends Bloc<CitaDetalleEvent, CitaDetalleState> {
  CitaDetalleBloc(this._user, {this.cita})
      : super(cita == null
            ? CitaDetalleInitial()
            : CitaDetalleLoaded(cita: cita)) {
    on<GetCitaHistorial>(_onGetCitaHistorial);
    // on<GetEmergencias>(_onGetEmergencias);

    refreshController = RefreshController(initialRefresh: false);

    citasRepository = CitasRepositoryImpl();

    if (cita != null) {
      add(const GetCitaHistorial());
    }
  }
  final User _user;

  final CitaMedica? cita;
  late RefreshController refreshController;

  late CitasRepository citasRepository;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetCitaHistorial(
      GetCitaHistorial event, Emitter<CitaDetalleState> emit) async {
    if (state is! CitaDetalleLoaded) return;
    final currrentStat = (state as CitaDetalleLoaded);

    final comentariosResponse =
        await citasRepository.getCitaHistorial(_user, currrentStat.cita.id!);

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
