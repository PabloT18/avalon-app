import 'dart:async';

import 'package:avalon_app/features/reclamaciones/reclamaciones.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

import '../../data/models/reclamaciones_response.dart';

part 'reclamaciones_event.dart';
part 'reclamaciones_state.dart';

class ReclamacionesBloc extends Bloc<ReclamacionesEvent, ReclamacionesState> {
  ReclamacionesBloc(this._user) : super(ReclamacionesInitial()) {
    on<GetReclamaciones>(_onGetReclamaciones);
    refreshController = RefreshController(initialRefresh: false);

    reclamacioesRepository = ReclamacionesRepositoryImpl();

    _pageCitas = 0;
  }
  final User _user;

  late RefreshController refreshController;

  late ReclamacionesRepository reclamacioesRepository;

  late int _pageCitas;

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetReclamaciones(
      GetReclamaciones event, Emitter<ReclamacionesState> emit) async {
    emit(ReclamacionesInitial());

    refreshController
      ..loadFailed()
      ..refreshCompleted();
    final reclamaciones =
        await reclamacioesRepository.getReclamaciones(_user, page: _pageCitas);

    reclamaciones.fold((l) {
      emit(ReclamacionesError(l.message));
    }, (reclamaciones) {
      if (reclamaciones.isEmpty) {
        emit(ReclamacionesError(apptexts.appOptions.noData));
      } else {
        emit(ReclamacionesLoaded(reclamaciones));
      }
    });
  }
}
