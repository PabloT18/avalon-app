import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../domain/models/centro_medico_entity.dart';
import '../../domain/repository/centrosmedicos_repository.dart';

part 'centros_medicos_event.dart';
part 'centros_medicos_state.dart';

class CentrosMedicosBloc
    extends Bloc<CentrosMedicosEvent, CentrosMedicosState> {
  CentrosMedicosBloc({required this.repository})
      : super(CentrosMedicosLoading()) {
    on<GetCentrosMedicos>(_onGetCentrosMedicos);
    refreshController = RefreshController(initialRefresh: false);
  }

  late RefreshController refreshController;
  final CentrosmedicosRepository repository;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetCentrosMedicos(
      CentrosMedicosEvent event, Emitter<CentrosMedicosState> emit) async {
    emit(CentrosMedicosLoading());

    refreshController
      ..loadFailed()
      ..refreshCompleted();

    try {
      final List<CentroMedico> medicosList = await repository.getMedicos();
      if (medicosList.isEmpty) {
        emit(const CentrosMedicosError(
            "No hay formas de pago cargadas por el momento"));
      } else {
        emit(CentrosMedicosLoaded(medicosList));
      }
    } catch (e) {
      emit(const CentrosMedicosError("Error al cargar los metodos de pago"));
    }
  }
}
