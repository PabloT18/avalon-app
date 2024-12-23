import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:avalon_app/features/citas/citas.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_models/shared_models.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'comentario_nuev_state.dart';

class ComentarioNuevCubit extends Cubit<ComentarioNuevState> {
  // ComentarioNuevCubit() : super(ComentarioNuevInitial());

  ComentarioNuevCubit({
    required this.citasRepository,
    required this.user,
    required this.citaId,
  }) : super(ComentarioInitial()) {
    textFieldFocusNode = FocusNode();
  }

  final CitasRepository citasRepository;
  final User user;
  final int citaId;

  late FocusNode textFieldFocusNode;

  @override
  Future<void> close() {
    textFieldFocusNode.dispose();
    return super.close();
  }

  // Método para seleccionar una imagen
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(ComentarioImageSelected(image: File(pickedFile.path)));
    }
  }

  // Método para enviar el comentario con imagen
  Future<void> sendComentario({
    required String comentario,
    File? image,
    File? pdf,
  }) async {
    final stateCurrent = state;
    if (comentario.isEmpty && image == null) {
      emit(const ComentarioError(
          'Debe proporcionar un comentario o una imagen.'));
      return;
    }

    emit(ComentarioSending());
    final nombreDocumento = image != null
        ? image.path.split('/').last
        : pdf != null
            ? pdf.path.split('/').last
            : '';
    // Llamada al repositorio para enviar el comentario
    final response = await citasRepository.sendComentario(
      user,
      citaId,
      comentario,
      image: image,
      pdf: pdf,
      nombreDocumento: nombreDocumento,
    );

    response.fold(
      (failure) {
        emit(const ComentarioError('Error al enviar el comentario'));
        emit(stateCurrent);
      },
      (success) => emit(ComentarioSent()),
    );
  }

  // Método para eliminar la imagen seleccionada
  void removeImage() {
    emit(ComentarioInitial()); // Volvemos al estado inicial sin imagen
  }

  FutureOr<void> onPdfSelected() async {
    // Usamos file_picker para seleccionar PDF
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Solo PDF
    );

    if (result != null && result.files.isNotEmpty) {
      // final pickedFile = result.files.single;
      // if (pickedFile.path != null) {
      //   // Convertimos a File
      //   final File pdfFile = File(pickedFile.path!);
      //   // Actualizamos state
      //   emit(ComentarioPDFSelected(pdf: pdfFile));
      // }

      final pickedFile = result.files.single;
      if (pickedFile.path != null) {
        try {
          // 1. Obtenemos la ruta del archivo temporal de FilePicker
          final File originalFile = File(pickedFile.path!);

          // 2. Creamos un nuevo archivo en la carpeta temporal de la app
          final tempDir = await getTemporaryDirectory();
          final newPath = '${tempDir.path}/${pickedFile.name}';
          // pickedFile.name => "id.pdf", por ejemplo

          // 3. Copiamos el archivo a la nueva ubicación
          final File copiedFile = await originalFile.copy(newPath);

          // 4. Actualizamos el estado con la nueva ruta (copiedFile.path)
          emit(ComentarioPDFSelected(pdf: copiedFile));
        } catch (e) {
          print('Error copiando el PDF: $e');
        }
      }
    }
  }

  FutureOr<void> onRemovePdf() {
    emit(ComentarioInitial()); // Volvemos al estado inicial sin imagen
  }
}
