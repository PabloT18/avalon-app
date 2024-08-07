import 'dart:async';

import 'package:avalon_app/features/avalon_info/formaspago/data/models/metodo_pago_model.dart';
import 'package:avalon_app/features/avalon_info/formaspago/domain/repository/formaspago_repository.dart';
import 'package:avalon_app/features/avalon_info/formaspago/formaspago.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'formas_pago_event.dart';
part 'formas_pago_state.dart';

class FormasPagoBloc extends Bloc<FormasPagoEvent, FormasPagoState> {
  FormasPagoBloc({required this.repository}) : super(FormasPagoInitial()) {
    on<GetMetodosPagoEvent>(_onGetMetodosPago);
    refreshController = RefreshController(initialRefresh: false);
  }

  final FormasPagoRepository repository;
  late RefreshController refreshController;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetMetodosPago(
      FormasPagoEvent event, Emitter<FormasPagoState> emit) async {
    emit(FormasPagoLoading());
    refreshController
      ..loadFailed()
      ..refreshCompleted();

    try {
      final List<MetodoPago> metodosPago = await repository.getMetodosPago();
      if (metodosPago.isEmpty) {
        emit(const FormasPagoError(
            "No hay formas de pago cargadas por el momento"));
      } else {
        emit(FormasPagoLoaded(metodosPago));
      }
    } catch (e) {
      emit(const FormasPagoError("Error al cargar los metodos de pago"));
    }
  }
}
