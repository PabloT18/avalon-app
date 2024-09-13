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
}
