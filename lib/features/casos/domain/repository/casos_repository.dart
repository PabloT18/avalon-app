import 'package:dartz/dartz.dart';

import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';
import 'package:shared_models/shared_models.dart';

abstract class CasosRepository {
  Future<Either<Failure, List<CasoEntity>>> getCasosUser(User user,
      {required int page, String? search, bool? update = false});

  Future<Either<Failure, List<CasoEntity>>> getCasosUserByPolizaId(User user,
      {required int page,
      String? search,
      required int clientePolizaId,
      required bool update});

  Future<Either<Failure, CasoEntity>> crearCaso(
      User user, String observacion, int clientePolizaId);
}
