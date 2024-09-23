import 'dart:async';
import 'dart:io';

import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/casos/data/repository/casos_repository_impl.dart';
import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';
import 'package:avalon_app/features/casos/domain/repository/casos_repository.dart';
import 'package:avalon_app/features/citas/data/repository/citas_repository_impl.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

import '../../../domain/citas_domain.dart';
import '../../../domain/models/requisitos_adicionales_entity.dart';

part 'cita_nueva_event.dart';
part 'cita_nueva_state.dart';

class CitaNuevaBloc extends Bloc<CitaNuevaEvent, CitaNuevaState> {
  CitaNuevaBloc(this._user, {this.caso}) : super(const CitaNuevaState()) {
    on<GetCasosCita>(_onGetCasosUser);
    on<WaitForCreateCase>(_onWaitForCreateCase);
    on<SelectCaso>(_onSelectCaso);
    on<UpdateRequisitoAdicional>(_onUpdateRequisitoAdicional);
    on<SubmitCitaEvent>(_onSubmitCitaEvent);

    on<ImageSelected>(_onImageSelected);
    on<RemoveImage>(_onRemoveImage);

    // on<SelectCasoOption>(_onSelectCasoOption);
    // on<GetCitas>(_onGetCitas);
    // on<GetEmergencias>(_onGetEmergencias);

    refreshController = RefreshController(initialRefresh: false);

    citasRepository = CitasRepositoryImpl();
    casosRepository = CasosRepositoryImpl();

    _page = 0;

    _pageCitas = 0;

    birthDateController = TextEditingController();
    detailPreferenceCity = TextEditingController();
    detailHospital = TextEditingController();
    detailPreferenceDoctor = TextEditingController();
    detailPadecimeiento = TextEditingController();
    detailAditionalInformation = TextEditingController();
    detailOthersRequaimentes = TextEditingController();

    add(const GetCasosCita());
  }
  final User _user;
  late int _page;

  final CasoEntity? caso;
  late RefreshController refreshController;

  late CitasRepository citasRepository;
  late CasosRepository casosRepository;

  late int _pageCitas;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  late TextEditingController birthDateController;
  late TextEditingController detailPreferenceCity;
  late TextEditingController detailHospital;
  late TextEditingController detailPreferenceDoctor;
  late TextEditingController detailPadecimeiento;
  late TextEditingController detailAditionalInformation;
  late TextEditingController detailOthersRequaimentes;

  @override
  Future<void> close() {
    birthDateController.dispose();
    detailPreferenceCity.dispose();
    detailHospital.dispose();
    detailPreferenceDoctor.dispose();
    detailPadecimeiento.dispose();
    detailAditionalInformation.dispose();
    detailOthersRequaimentes.dispose();
    refreshController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetCasosUser(
      GetCasosCita event, Emitter<CitaNuevaState> emit) async {
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
        emit(CitaNuevaState(message: failure.message));
      },
      (listadoCasos) {
        emit(CitaNuevaState(casos: listadoCasos));
      },
    );
  }

  FutureOr<void> _onWaitForCreateCase(
      WaitForCreateCase event, Emitter<CitaNuevaState> emit) {
    emit(state.copyWith(waitForCreateCase: true));
  }

  FutureOr<void> _onSelectCaso(
      SelectCaso event, Emitter<CitaNuevaState> emit) async {
    emit(state.copyWith(casoSeleccionado: event.caso));
  }

  FutureOr<void> _onUpdateRequisitoAdicional(
      UpdateRequisitoAdicional event, Emitter<CitaNuevaState> emit) {
    final updatedRequisitos = state.requisitosAdicionales.copyWith(
      // Actualiza el campo correspondiente
      ambTerrestre: event.field == 'ambTerrestre'
          ? event.value
          : state.requisitosAdicionales.ambTerrestre,
      recetaMedica: event.field == 'recetaMedica'
          ? event.value
          : state.requisitosAdicionales.recetaMedica,
      ambAerea: event.field == 'ambAerea'
          ? event.value
          : state.requisitosAdicionales.ambAerea,
      sillaRuedas: event.field == 'sillaRuedas'
          ? event.value
          : state.requisitosAdicionales.sillaRuedas,
      serTransporte: event.field == 'serTransporte'
          ? event.value
          : state.requisitosAdicionales.serTransporte,
      viajes: event.field == 'viajes'
          ? event.value
          : state.requisitosAdicionales.viajes,
      hospedaje: event.field == 'hospedaje'
          ? event.value
          : state.requisitosAdicionales.hospedaje,
    );
    emit(state.copyWith(requisitosAdicionales: updatedRequisitos));
  }

  Future<void> _onSubmitCitaEvent(
      SubmitCitaEvent event, Emitter<CitaNuevaState> emit) async {
    // Crear el objeto CitaMedica con los datos del formulario

    emit(state.copyWith(isLoading: true));

    final citaMedica = CitaMedica(
      clientePoliza: state.casoSeleccionado!.clientePoliza,
      caso: state.casoSeleccionado!,
      // fechaTentativa:
      // ateTime.parse(birthDateController.text),
      fechaTentativa: DateFormat('dd/MM/yyyy').parse(birthDateController.text),
      ciudadPreferencia: detailPreferenceCity.text,
      padecimiento: detailPadecimeiento.text,
      informacionAdicional: detailAditionalInformation.text,
      otrosRequisitos: detailOthersRequaimentes.text,
      requisitosAdicionales: state.requisitosAdicionales,
    );

    // final nombreDocumento =
    //     state.image != null ? state.image!.path.split('/').last : '';

    final dateimage =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    final nombreDocumento = state.image != null
        ? '${_user.id}_${dateimage}_${state.image!.path.split('/').last}'
        : '';

    // // Llamar al repositorio para persistir la cita
    Either<Failure, CitaMedica> result = await citasRepository.crearCita(
      _user,
      citaMedica,
      image: state.image,
      nombreDocumento: nombreDocumento,
    );

    result.fold(
      (failure) {
        // Maneja el error
        emit(state.copyWith(
          isLoading: false,
          message: failure.message,
          citaCreada: true,
        ));
      },
      (cita) {
        birthDateController.clear();
        detailPreferenceCity.clear();
        detailHospital.clear();
        detailPreferenceDoctor.clear();
        detailPadecimeiento.clear();
        detailAditionalInformation.clear();
        detailOthersRequaimentes.clear();
        // Maneja el éxito
        emit(state.copyWith(
          message: apptexts.citasPage.citaCreada,
          citaCreada: true,
          isLoading: false,
        ));
        // Puedes navegar a otra pantalla o resetear el formulario
      },
    );
  }

  FutureOr<void> _onImageSelected(
      ImageSelected event, Emitter<CitaNuevaState> emit) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(state.copyWith(image: File(pickedFile.path)));
    }
  }

  FutureOr<void> _onRemoveImage(
      RemoveImage event, Emitter<CitaNuevaState> emit) {
    emit(state.copyWith(
      image: null,
      removeImage: true,
    ));
  }
}
