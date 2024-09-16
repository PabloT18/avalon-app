import 'dart:async';

import 'package:avalon_app/core/error/exceptions/exceptions.dart';
import 'package:avalon_app/features/user_features.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

import '../../domain/models/medico_models.dart';

part 'medicos_event.dart';
part 'medicos_state.dart';

class MedicosBloc extends Bloc<MedicosEvent, MedicosState> {
  MedicosBloc(this.user, {required this.repository}) : super(MedicosLoading()) {
    on<GetMedicos>(_onGetMedicos);

    refreshController = RefreshController(initialRefresh: false);
  }

  late RefreshController refreshController;
  final MedicosRepository repository;
  final User user;

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
      final List<Medico> medicosList = await repository.getMedicos(user);
      if (medicosList.isEmpty) {
        emit(MedicosError(apptexts.medicosPage.noData));
      } else {
        emit(MedicosLoaded(medicosList));
      }
    } on InternetAccessException catch (e) {
      emit(MedicosError(e.message));
    } on ServerException catch (e) {
      emit(MedicosError(e.message ?? apptexts.appOptions.error_servers));
    } catch (e) {
      emit(MedicosError(apptexts.appOptions.error_servers));
    }
  }
}
