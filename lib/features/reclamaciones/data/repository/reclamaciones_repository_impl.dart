import 'package:avalon_app/core/error/failures/failures.dart';

import 'package:avalon_app/features/reclamaciones/data/models/reclamaciones_response.dart';

import 'package:dartz/dartz.dart';

import 'package:shared_models/src/entities/user_entity.dart';

import '../../domain/repository/reclamaciones_repository.dart';

class ReclamacionesRepositoryImpl implements ReclamacionesRepository {
  @override
  Future<Either<Failure, List<ReclamacionModel>>> getReclamaciones(User user,
      {required int page, String? search, bool? update = false}) async {
    List<ReclamacionModel> list = [];
    return Right(list);
  }

  @override
  Future<Either<Failure, List<ReclamacionModel>>> getReclamacionesById(
      User user,
      {required int page,
      String? search,
      bool? update = false}) async {
    List<ReclamacionModel> list = [];
    return Right(list);
  }
}
