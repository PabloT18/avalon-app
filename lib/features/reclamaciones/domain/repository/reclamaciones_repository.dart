import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/reclamaciones/data/models/reclamaciones_response.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_models/shared_models.dart';

abstract class ReclamacionesRepository {
  Future<Either<Failure, List<ReclamacionModel>>> getReclamacionesById(
    User user, {
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
}
