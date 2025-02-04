import 'dart:async';
import 'dart:io';

import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/user_features.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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

    on<ImageSelected>(_onImageSelected);
    on<RemoveImage>(_onRemoveImage);

    // <--- Eventos para PDF
    on<PdfSelected>(_onPdfSelected);
    on<RemovePdf>(_onRemovePdf);

    refreshController = RefreshController(initialRefresh: false);

    reclamacionRepo = ReclamacionesRepositoryImpl();
    casosRepository = CasosRepositoryImpl();

    _page = 0;

    _pageCitas = 0;

    detailPadecimiento = TextEditingController();
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
  late TextEditingController detailPadecimiento;
  late TextEditingController detailAditionalInformation;

  late TextEditingController dateController;

  @override
  Future<void> close() {
    refreshController.dispose();
    detailPadecimiento.dispose();
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
      padecimientoDiagnostico: detailPadecimiento.text,
      infoAdicional: detailAditionalInformation.text,
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

    //
    final result = await reclamacionRepo.createReclamacion(
      _user,
      reclamacion,
      image: state.image,
      pdf: state.pdf,
      nombreDocumento: nombreDocumento,
    );
    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          message: failure.message,
          reclamacionCreada: false,
        ));
      },
      (emergenciaCreada) {
        emit(state.copyWith(
          isLoading: false,
          message: apptexts.reclamacionesPage.reclamacionCreada,
          reclamacionCreada: true,
        ));
        // Navegar o realizar acciones adicionales si es necesario
      },
    );
  }

  void _onUpdateTipoAdm(
      UpdateTipoAdmEvent event, Emitter<ReclamacionNuevaState> emit) {
    emit(state.copyWith(tipoAdmSeleccionado: event.tipoAdm));
  }

  FutureOr<void> _onImageSelected(
      ImageSelected event, Emitter<ReclamacionNuevaState> emit) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(state.copyWith(
          image: File(
            pickedFile.path,
          ),
          pdf: null,
          removePdf: true));
    }
  }

  FutureOr<void> _onRemoveImage(
      RemoveImage event, Emitter<ReclamacionNuevaState> emit) {
    emit(state.copyWith(
      image: null,
      removeImage: true,
    ));
  }

  FutureOr<void> _onPdfSelected(
      PdfSelected event, Emitter<ReclamacionNuevaState> emit) async {
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
      RemovePdf event, Emitter<ReclamacionNuevaState> emit) {
    // Removemos el PDF
    emit(state.copyWith(removePdf: true));
  }
}
