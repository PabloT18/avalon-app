import 'dart:io';

import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/reclamaciones/data/models/reclamaciones_response.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_models/shared_models.dart';

abstract class ReclamacionesRepository {
  Future<Either<Failure, List<ReclamacionModel>>> getReclamacionesById(
    User user,
    int reclamacionId, {
    required int page,
    String? search,
    bool? update = false,
  });

  Future<Either<Failure, List<ReclamacionModel>>> getReclamaciones(
    User user, {
    required int page,
    String? search,
    bool? update = false,
  });

  Future<Either<Failure, List<Comentario>>> getReclamacionesHistorial(
    User user,
    int reclamacionId,
  );

  Future<Either<Failure, List<Comentario>>> sendComentarioReclamacion(
      User user, int reclamacionId, String comentario,
      {File? image, required String nombreDocumento});

  Future<Either<Failure, ReclamacionModel>> createReclamacion(
      User user, ReclamacionModel reclamacion,
      {File? image, required String nombreDocumento});
}
