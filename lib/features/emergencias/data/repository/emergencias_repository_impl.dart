import 'package:avalon_app/core/error/exceptions/exceptions.dart';
import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/emergencias/data/models/emergencias_response.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_models/shared_models.dart';

import '../../domain/repository/emergencias_repository.dart';
import '../sources/emergencias_remote_source.dart';

class EmergenciasRepositoryImpl implements EmergenciasRepository {
  EmergenciasRepositoryImpl() {
    remoteSource = EmergenciasRemoteSource();
  }

  late EmergenciasRemoteSource remoteSource;

  @override
  Future<Either<Failure, List<EmergenciaModel>>> getEmergenciasByCaseId(
      User user, int casoId,
      {required int page, String? search, bool? update = false}) async {
    try {
      final casosList = await remoteSource.getEmergenciasByCaseId(user, casoId,
          page: page, search: search);
      return Right(casosList);
    } on InternetAccessException catch (i) {
      return Left(InternetFailure(message: i.message));
    } on ServerException catch (s) {
      return Left(ServerFailure(
          message: s.message ?? apptexts.appOptions.error_servers));
    } on Exception {
      return Left(ServerFailure(message: apptexts.appOptions.error_servers));
    }
  }

  @override
  Future<Either<Failure, List<EmergenciaModel>>> getEmergencias(User user,
      {required int page, String? search, bool? update = false}) async {
    try {
      final casosList =
          await remoteSource.getEmergencias(user, page: page, search: search);
      return Right(casosList);
    } on InternetAccessException catch (i) {
      return Left(InternetFailure(message: i.message));
    } on ServerException catch (s) {
      return Left(ServerFailure(
          message: s.message ?? apptexts.appOptions.error_servers));
    } on Exception {
      return Left(ServerFailure(message: apptexts.appOptions.error_servers));
    }
  }
}
