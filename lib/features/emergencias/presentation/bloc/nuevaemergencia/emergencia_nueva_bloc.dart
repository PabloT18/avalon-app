import 'dart:async';
import 'dart:io';

import 'package:avalon_app/app/domain/usecases/general_uc/get_estados_by_pais_uc.dart';
import 'package:avalon_app/app/domain/usecases/general_uc/get_paises_uc.dart';
import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/casos/data/repository/casos_repository_impl.dart';
import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';
import 'package:avalon_app/features/casos/domain/repository/casos_repository.dart';

import 'package:avalon_app/features/emergencias/emergencias.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_models/shared_models.dart';

part 'emergencia_nueva_event.dart';
part 'emergencia_nueva_state.dart';

class EmergenciaNuevaBloc
    extends Bloc<EmergenciaNuevaEvent, EmergenciaNuevaState> {
  EmergenciaNuevaBloc(
    this._user, {
    required this.getPaisesUseCase,
    required this.getEstadosUseCase,
    this.caso,
  }) : super(const EmergenciaNuevaState()) {
    on<GetCasoEmergencia>(_onGetCasosUser);
    on<WaitForCreateCase>(_onWaitForCreateCase);
    on<SelectCasoEmergencia>(_onSelectCaso);

    on<LoadPaisesEvent>(_onLoadPaises);
    on<UpdateSelectedCountryEvent>(_onUpdateSelectedCountry);
    on<UpdateSelectedEstadoEvent>(_onUpdateSelectedEstado);
    on<SubmitEmergenciaEvent>(_onSubmitEmergencia);

    on<ImageSelected>(_onImageSelected);
    on<RemoveImage>(_onRemoveImage);

    // <--- Eventos para PDF
    on<PdfSelected>(_onPdfSelected);
    on<RemovePdf>(_onRemovePdf);

    refreshController = RefreshController(initialRefresh: false);

    emergenciasRepo = EmergenciasRepositoryImpl();
    casosRepository = CasosRepositoryImpl();

    _page = 0;

    _pageCitas = 0;

    add(const GetCasoEmergencia());
    add(const LoadPaisesEvent());
  }
  final User _user;
  late int _page;

  final CasoEntity? caso;
  late RefreshController refreshController;

  late EmergenciasRepository emergenciasRepo;
  late CasosRepository casosRepository;
  final GetPaisesUseCase getPaisesUseCase;
  final GetEstadosUseCase getEstadosUseCase;

  late int _pageCitas;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  // Controladores de texto para los campos de dirección
  final TextEditingController detailDireccionUno = TextEditingController();
  final TextEditingController detailDireccionDos = TextEditingController();
  final TextEditingController detailCiudad = TextEditingController();
  final TextEditingController detailCodigoPostal = TextEditingController();
  final TextEditingController detailPadecimeiento = TextEditingController();
  final TextEditingController detailAditionalInformation =
      TextEditingController();

  @override
  Future<void> close() {
    refreshController.dispose();
    detailDireccionUno.dispose();
    detailDireccionDos.dispose();
    detailCiudad.dispose();
    detailCodigoPostal.dispose();
    detailPadecimeiento.dispose();
    detailAditionalInformation.dispose();
    return super.close();
  }

  FutureOr<void> _onGetCasosUser(
      GetCasoEmergencia event, Emitter<EmergenciaNuevaState> emit) async {
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

  FutureOr<void> _onLoadPaises(
      LoadPaisesEvent event, Emitter<EmergenciaNuevaState> emit) async {
    try {
      final paises = await getPaisesUseCase.call(_user.token!);
      emit(state.copyWith(paises: paises));
    } catch (e) {
      emit(state.copyWith(message: 'Error al cargar los países'));
    }
  }

  FutureOr<void> _onUpdateSelectedCountry(UpdateSelectedCountryEvent event,
      Emitter<EmergenciaNuevaState> emit) async {
    emit(state.copyWith(
      selectedCountryId: event.countryId,
      selectedEstadoId: null,
      estados: [],
    ));

    try {
      final estados = await getEstadosUseCase.call(
        paisId: event.countryId,
        token: _user.token!,
      );
      emit(state.copyWith(estados: estados));
    } catch (e) {
      emit(state.copyWith(message: 'Error al cargar los estados'));
    }
  }

  FutureOr<void> _onUpdateSelectedEstado(
      UpdateSelectedEstadoEvent event, Emitter<EmergenciaNuevaState> emit) {
    emit(state.copyWith(selectedEstadoId: event.estadoId));
  }

  FutureOr<void> _onWaitForCreateCase(
      WaitForCreateCase event, Emitter<EmergenciaNuevaState> emit) {
    emit(state.copyWith(waitForCreateCase: true));
  }

  FutureOr<void> _onSelectCaso(
      SelectCasoEmergencia event, Emitter<EmergenciaNuevaState> emit) async {
    emit(state.copyWith(casoSeleccionado: event.caso));
  }

  FutureOr<void> _onSubmitEmergencia(
      SubmitEmergenciaEvent event, Emitter<EmergenciaNuevaState> emit) async {
    if (_formKey.currentState?.validate() != true) {
      // El formulario no es válido
      return;
    }

    emit(state.copyWith(isLoading: true));

    final emergencia = EmergenciaModel(
      caso: state.casoSeleccionado!,
      clientePoliza: state.casoSeleccionado!.clientePoliza,
      diagnostico: detailPadecimeiento.text,
      sintomas: detailAditionalInformation.text,
      direccion: Direccion(
        direccionUno: detailDireccionUno.text,
        direccionDos: detailDireccionDos.text,
        ciudad: detailCiudad.text,
        codigoPostal: detailCodigoPostal.text,
        pais: state.paises.firstWhere((p) => p.id == state.selectedCountryId),
        estado: state.estados.firstWhere((e) => e.id == state.selectedEstadoId),
      ),
      // Otros campos necesarios...
    );
    final dateimage =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    String nombreDocumento = '';
    if (state.image != null) {
      nombreDocumento =
          '${_user.id}_${dateimage}_${state.image!.path.split('/').last}';
    } else if (state.pdf != null) {
      nombreDocumento =
          '${_user.id}_${dateimage}_${state.pdf!.path.split('/').last}';
    }

    final result = await emergenciasRepo.createEmergencia(
      _user,
      emergencia,
      image: state.image,
      pdf: state.pdf,
      nombreDocumento: nombreDocumento,
    );
    result.fold(
      (failure) {
        // emit(state.copyWith(
        //   isLoading: false,
        //   message: failure.message,
        //   citaCreada: false
        // ));
        emit(state.copyWith(
            isLoading: false, message: failure.message, citaCreada: true));
      },
      (emergenciaCreada) {
        emit(state.copyWith(
            isLoading: false,
            message: apptexts.emergenciasPage.emergenciaCreada,
            citaCreada: true));
        // Navegar o realizar acciones adicionales si es necesario
      },
    );
  }

  FutureOr<void> _onImageSelected(
      ImageSelected event, Emitter<EmergenciaNuevaState> emit) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(state.copyWith(
          image: File(pickedFile.path), pdf: null, removePdf: true));
    }
  }

  FutureOr<void> _onRemoveImage(
      RemoveImage event, Emitter<EmergenciaNuevaState> emit) {
    emit(state.copyWith(
      image: null,
      removeImage: true,
    ));
  }

  FutureOr<void> _onPdfSelected(
      PdfSelected event, Emitter<EmergenciaNuevaState> emit) async {
    // Usamos file_picker para seleccionar PDF
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Solo PDF
    );

    if (result != null && result.files.isNotEmpty) {
      final pickedFile = result.files.single;
      if (pickedFile.path != null) {
        // Convertimos a File
        final File pdfFile = File(pickedFile.path!);
        // Actualizamos state
        emit(state.copyWith(
          pdf: pdfFile,
          image: null,
          removeImage: true,
        ));
      }
    }
  }

  FutureOr<void> _onRemovePdf(
      RemovePdf event, Emitter<EmergenciaNuevaState> emit) {
    // Removemos el PDF
    emit(state.copyWith(removePdf: true));
  }
}
