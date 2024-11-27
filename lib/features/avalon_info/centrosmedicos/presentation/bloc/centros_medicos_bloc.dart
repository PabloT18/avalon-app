import 'dart:async';

import 'package:avalon_app/core/error/exceptions/exceptions.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

import '../../domain/models/centro_medico_entity.dart';
import '../../domain/repository/centrosmedicos_repository.dart';

part 'centros_medicos_event.dart';
part 'centros_medicos_state.dart';

class CentrosMedicosBloc
    extends Bloc<CentrosMedicosEvent, CentrosMedicosState> {
  CentrosMedicosBloc(this.user, {required this.repository})
      : super(CentrosMedicosLoading()) {
    on<GetCentrosMedicos>(_onGetCentrosMedicos);
    refreshController = RefreshController(initialRefresh: false);
  }

  final User user;
  late RefreshController refreshController;
  final CentrosmedicosRepository repository;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetCentrosMedicos(
      GetCentrosMedicos event, Emitter<CentrosMedicosState> emit) async {
    emit(CentrosMedicosLoading());

    refreshController
      ..loadFailed()
      ..refreshCompleted();

    try {
      final List<CentroMedico> medicosList =
          await repository.getMedicos(user, search: event.search);
      if (medicosList.isEmpty) {
        emit(CentrosMedicosError(apptexts.centrosMedicos.noData));
      } else {
        emit(CentrosMedicosLoaded(medicosList));
      }
    } on InternetAccessException catch (e) {
      emit(CentrosMedicosError(e.message));
    } on ServerException catch (e) {
      emit(CentrosMedicosError(e.message ?? apptexts.appOptions.error_servers));
    } catch (e) {
      emit(CentrosMedicosError(apptexts.appOptions.error_servers));
    }
  }
}
