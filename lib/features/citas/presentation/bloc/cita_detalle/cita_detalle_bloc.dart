import 'dart:async';

import 'package:avalon_app/features/citas/citas.dart';

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
    // on<GetCitas>(_onGetCitas);
    // on<GetEmergencias>(_onGetEmergencias);

    refreshController = RefreshController(initialRefresh: false);

    citasRepository = CitasRepositoryImpl();
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
}
