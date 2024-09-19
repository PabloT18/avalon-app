import 'dart:async';

import 'package:avalon_app/features/reclamaciones/reclamaciones.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

part 'reclamcaion_detalle_event.dart';
part 'reclamcaion_detalle_state.dart';

class ReclamacionDetalleBloc
    extends Bloc<ReclamcaionDetalleEvent, ReclamacionDetalleState> {
  ReclamacionDetalleBloc(this._user, {this.reclamacion})
      : super(reclamacion == null
            ? ReclamacionDetalleInitial()
            : ReclamacionDetalleLoaded(reclamacion: reclamacion)) {
    on<GetReclamacionHistorial>(_onGetReclamacionHistorial);
    // on<GetReclamacions>(_onGetReclamacions);

    refreshController = RefreshController(initialRefresh: false);

    repository = ReclamacionesRepositoryImpl();

    if (reclamacion != null) {
      add(const GetReclamacionHistorial());
    }
  }
  final User _user;

  final ReclamacionModel? reclamacion;
  late RefreshController refreshController;

  late ReclamacionesRepository repository;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetReclamacionHistorial(GetReclamacionHistorial event,
      Emitter<ReclamacionDetalleState> emit) async {
    if (state is! ReclamacionDetalleLoaded) return;
    final currrentStat = (state as ReclamacionDetalleLoaded);

    final comentariosResponse = await repository.getReclamacionesHistorial(
        _user, currrentStat.reclamacion.id!);

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
