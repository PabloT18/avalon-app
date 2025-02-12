import 'dart:io';

import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/citas/domain/models/citas_response.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_models/shared_models.dart';

abstract class CitasRepository {
  Future<Either<Failure, List<CitaMedica>>> getCitasById(
    User user,
    int casoId, {
    required int page,
    String? search,
    bool? update = false,
  });

  Future<Either<Failure, List<CitaMedica>>> getCitas(
    User user, {
    required int page,
    String? search,
    bool? update = false,
  });

  Future<Either<Failure, List<Comentario>>> getCitaHistorial(
    User user,
    int citaId,
  );

  Future<Either<Failure, List<Comentario>>> sendComentario(
      User user, int citaId, String comentario,
      {File? image,
      File? pdf, // Nuevo parámetro para PDF
      required String nombreDocumento});

  Future<Either<Failure, CitaMedica>> crearCita(User user, CitaMedica cita,
      {File? image,
      File? pdf, // Nuevo parámetro para PDF
      required String nombreDocumento});
}
