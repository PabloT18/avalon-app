import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:avalon_app/features/citas/citas.dart';
import 'package:shared_models/shared_models.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'comentario_nuev_state.dart';

class ComentarioNuevCubit extends Cubit<ComentarioNuevState> {
  // ComentarioNuevCubit() : super(ComentarioNuevInitial());

  ComentarioNuevCubit({
    required this.citasRepository,
    required this.user,
    required this.citaId,
  }) : super(ComentarioInitial());

  final CitasRepository citasRepository;
  final User user;
  final int citaId;

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
    if (comentario.isEmpty && image == null) {
      emit(const ComentarioError('Debe ingresar un comentario o una imagen'));
      return;
    }

    emit(ComentarioSending());

    // Simula el envío del comentario e imagen
    final response = await citasRepository.sendComentario(
      user,
      citaId,
      comentario,
      image: image,
    );

    response.fold(
      (failure) => emit(const ComentarioError('Error al enviar el comentario')),
      (success) => emit(ComentarioSent()),
    );
  }

  // Método para eliminar la imagen seleccionada
  void removeImage() {
    emit(ComentarioInitial()); // Volvemos al estado inicial sin imagen
  }
}
