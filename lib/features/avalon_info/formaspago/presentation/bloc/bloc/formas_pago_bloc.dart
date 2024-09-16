import 'dart:async';

import 'package:avalon_app/core/error/exceptions/exceptions.dart';
import 'package:avalon_app/features/avalon_info/formaspago/data/models/metodo_pago_model.dart';
import 'package:avalon_app/features/avalon_info/formaspago/domain/repository/formaspago_repository.dart';
import 'package:avalon_app/features/avalon_info/formaspago/formaspago.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

part 'formas_pago_event.dart';
part 'formas_pago_state.dart';

class FormasPagoBloc extends Bloc<FormasPagoEvent, FormasPagoState> {
  FormasPagoBloc(this.user, {required this.repository})
      : super(FormasPagoInitial()) {
    on<GetMetodosPagoEvent>(_onGetMetodosPago);
    refreshController = RefreshController(initialRefresh: false);
  }

  final User user;

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
      final List<MetodoPago> metodosPago =
          await repository.getMetodosPago(user);
      if (metodosPago.isEmpty) {
        emit(FormasPagoError(apptexts.metodosPagoPage.noData));
      } else {
        emit(FormasPagoLoaded(metodosPago));
      }
    } on InternetAccessException catch (e) {
      emit(FormasPagoError(e.message));
    } on ServerException catch (e) {
      emit(FormasPagoError(e.message ?? apptexts.appOptions.error_servers));
    } catch (e) {
      emit(FormasPagoError(apptexts.appOptions.error_servers));
    }
  }
}
