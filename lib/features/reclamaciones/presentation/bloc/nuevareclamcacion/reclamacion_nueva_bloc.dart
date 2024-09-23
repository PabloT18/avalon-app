import 'dart:async';
import 'dart:io';

import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/user_features.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

part 'reclamacion_nueva_event.dart';
part 'reclamacion_nueva_state.dart';

class ReclamacionNuevaBloc
    extends Bloc<ReclamacionNuevaEvent, ReclamacionNuevaState> {
  ReclamacionNuevaBloc(
    this._user, {
    this.caso,
  }) : super(const ReclamacionNuevaState()) {
    on<GetCasoReclamaciones>(_onGetCasosUser);
    on<WaitForCreateCase>(_onWaitForCreateCase);
    on<SelectCasoReclamaciones>(_onSelectCaso);

    on<SubmitReclamacionesEvent>(_onSubmitReclamaciones);
    on<UpdateTipoAdmEvent>(_onUpdateTipoAdm);

    refreshController = RefreshController(initialRefresh: false);

    reclamacionRepo = ReclamacionesRepositoryImpl();
    casosRepository = CasosRepositoryImpl();

    _page = 0;

    _pageCitas = 0;

    detailPadecimeiento = TextEditingController();
    detailAditionalInformation = TextEditingController();

    dateController = TextEditingController();

    add(const GetCasoReclamaciones());
  }
  final User _user;
  late int _page;

  final CasoEntity? caso;
  late RefreshController refreshController;

  late ReclamacionesRepository reclamacionRepo;
  late CasosRepository casosRepository;

  late int _pageCitas;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  // Controladores de texto para los campos de dirección
  late TextEditingController detailPadecimeiento;
  late TextEditingController detailAditionalInformation;

  late TextEditingController dateController;

  @override
  Future<void> close() {
    refreshController.dispose();
    detailPadecimeiento.dispose();
    detailAditionalInformation.dispose();

    dateController.dispose();

    return super.close();
  }

  FutureOr<void> _onGetCasosUser(
      GetCasoReclamaciones event, Emitter<ReclamacionNuevaState> emit) async {
    _page = 0;

    // emit(CasosInitial());

    refreshController
      ..loadFailed()
      ..refreshCompleted();
    Either<Failure, List<CasoEntity>> casosResponse;

    // if (event.clientePolizaId == null) {
    casosResponse = await casosRepository.getCasosUser(_user,
        page: _page, search: null, update: false);

    casosResponse.fold(
      (failure) {
        emit(state.copyWith(message: failure.message));
      },
      (listadoCasos) {
        emit(state.copyWith(casos: listadoCasos));
      },
    );
  }

  FutureOr<void> _onWaitForCreateCase(
      WaitForCreateCase event, Emitter<ReclamacionNuevaState> emit) {
    emit(state.copyWith(waitForCreateCase: true));
  }

  FutureOr<void> _onSelectCaso(SelectCasoReclamaciones event,
      Emitter<ReclamacionNuevaState> emit) async {
    emit(state.copyWith(casoSeleccionado: event.caso));
  }

  FutureOr<void> _onSubmitReclamaciones(SubmitReclamacionesEvent event,
      Emitter<ReclamacionNuevaState> emit) async {
    if (_formKey.currentState?.validate() != true) {
      // El formulario no es válido
      return;
    }

    emit(state.copyWith(isLoading: true));

    final reclamacion = ReclamacionModel(
      caso: state.casoSeleccionado!,
      clientePoliza: state.casoSeleccionado!.clientePoliza,
      fechaServicio: DateFormat('dd/MM/yyyy').parse(dateController.text),
      tipoAdm: state.tipoAdmSeleccionado,
      padecimientoDiagnostico: detailPadecimeiento.text,
      infoAdicional: detailAditionalInformation.text,
      // Otros campos necesarios...
    );
    final nombreDocumento =
        event.image != null ? event.image!.path.split('/').last : '';
    final result = await reclamacionRepo.createReclamacion(
      _user,
      reclamacion,
      image: event.image,
      nombreDocumento: nombreDocumento,
    );
    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          message: failure.message,
        ));
      },
      (emergenciaCreada) {
        emit(state.copyWith(
          isLoading: false,
          message: apptexts.reclamacionesPage.reclamacionCreada,
        ));
        // Navegar o realizar acciones adicionales si es necesario
      },
    );
  }

  void _onUpdateTipoAdm(
      UpdateTipoAdmEvent event, Emitter<ReclamacionNuevaState> emit) {
    emit(state.copyWith(tipoAdmSeleccionado: event.tipoAdm));
  }
}
