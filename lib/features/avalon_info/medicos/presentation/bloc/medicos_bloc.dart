import 'dart:async';

import 'package:avalon_app/features/user_features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../domain/models/medico_models.dart';

part 'medicos_event.dart';
part 'medicos_state.dart';

class MedicosBloc extends Bloc<MedicosEvent, MedicosState> {
  MedicosBloc({required this.repository}) : super(MedicosLoading()) {
    on<GetMedicos>(_onGetMedicos);

    refreshController = RefreshController(initialRefresh: false);
  }

  late RefreshController refreshController;
  final MedicosRepository repository;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetMedicos(
      GetMedicos event, Emitter<MedicosState> emit) async {
    emit(MedicosLoading());

    refreshController
      ..loadFailed()
      ..refreshCompleted();

    try {
      final List<Medico> medicosList = await repository.getMedicos();
      if (medicosList.isEmpty) {
        emit(const MedicosError(
            "No hay formas de pago cargadas por el momento"));
      } else {
        emit(MedicosLoaded(medicosList));
      }
    } catch (e) {
      emit(const MedicosError("Error al cargar los metodos de pago"));
    }
  }
}
