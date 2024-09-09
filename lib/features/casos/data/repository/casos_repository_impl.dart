import 'package:avalon_app/core/error/exceptions/exceptions.dart';
import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/casos/data/sources/casos_remote_source.dart';

import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:dartz/dartz.dart';
import 'package:shared_models/shared_models.dart';

import '../../domain/repository/casos_repository.dart';

class CasosRepositoryImpl implements CasosRepository {
  CasosRepositoryImpl() {
    remoteSource = CasosRemoteSource();
  }

  late CasosRemoteSource remoteSource;
  @override
  Future<Either<Failure, List<CasoEntity>>> getCasosUser(User user,
      {required int page, String? search, bool? update = false}) async {
    try {
      final casosList =
          await remoteSource.getCases(user, page: page, search: search);
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
  Future<Either<Failure, List<CasoEntity>>> getCasosUserByPolizaId(User user,
      {required int page,
      String? search,
      required int clientePolizaId,
      required bool update}) async {
    try {
      final casosList = await remoteSource.getCasesByPolizaId(
        user,
        page: page,
        search: search,
        clientePolizaId: clientePolizaId,
      );
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
