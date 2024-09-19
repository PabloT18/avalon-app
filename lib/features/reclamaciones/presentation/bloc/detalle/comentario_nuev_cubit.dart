import 'dart:async';
import 'dart:io';

import 'package:avalon_app/features/emergencias/emergencias.dart';
import 'package:avalon_app/features/user_features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_models/shared_models.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'comentario_nuev_state.dart';

////[RECLAMACION]
class ComentarioNuevCubit extends Cubit<ComentarioNuevState> {
  // ComentarioNuevCubit() : super(ComentarioNuevInitial());

  ComentarioNuevCubit({
    required this.repository,
    required this.user,
    required this.reclamacionId,
  }) : super(ComentarioInitial()) {
    textFieldFocusNode = FocusNode();
  }

  final ReclamacionesRepository repository;
  final User user;
  final int reclamacionId;

  late FocusNode textFieldFocusNode;

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
  }) async {
    final stateCurrent = state;
    if (comentario.isEmpty && image == null) {
      emit(const ComentarioError(
          'Debe proporcionar un comentario o una imagen.'));
      return;
    }

    emit(ComentarioSending());

    final nombreDocumento = image != null ? image.path.split('/').last : '';

    // Llamada al repositorio para enviar el comentario
    final response = await repository.sendComentario(
      user,
      reclamacionId,
      comentario,
      image: image,
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
}
