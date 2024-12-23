import 'dart:io';

import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/emergencias/data/models/emergencias_response.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_models/shared_models.dart';

abstract class EmergenciasRepository {
  Future<Either<Failure, List<EmergenciaModel>>> getEmergenciasByCaseId(
    User user,
    int casoId, {
    required int page,
    String? search,
    bool? update = false,
  });

  Future<Either<Failure, List<EmergenciaModel>>> getEmergencias(
    User user, {
    required int page,
    String? search,
    bool? update = false,
  });

  Future<Either<Failure, List<Comentario>>> getEmergenciasHistorial(
    User user,
    int emergenciaId,
  );

  Future<Either<Failure, List<Comentario>>> sendComentario(
      User user, int emergenciaId, String comentario,
      {File? image,
      File? pdf, // Nuevo parámetro para PDF
      required String nombreDocumento});

  Future<Either<Failure, EmergenciaModel>> createEmergencia(
      User user, EmergenciaModel emergencia,
      {File? image,
      File? pdf, // Nuevo parámetro para PDF
      required String nombreDocumento});
}
