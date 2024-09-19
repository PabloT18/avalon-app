import 'dart:io';

import 'package:avalon_app/core/error/exceptions/exceptions.dart';
import 'package:avalon_app/core/error/failures/failures.dart';

import 'package:avalon_app/features/citas/domain/models/citas_response.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:dartz/dartz.dart';
import 'package:shared_models/shared_models.dart';

import '../../domain/repository/citas_repository.dart';
import '../sources/citas_remote_rource.dart';

class CitasRepositoryImpl implements CitasRepository {
  CitasRepositoryImpl() {
    remoteSource = CitasRemoteSource();
  }

  late CitasRemoteSource remoteSource;

  @override
  Future<Either<Failure, List<CitaMedica>>> getCitasById(User user, int casoId,
      {required int page, String? search, bool? update = false}) async {
    try {
      final casosList = await remoteSource.getCitasByCaseId(user, casoId,
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
  Future<Either<Failure, List<CitaMedica>>> getCitas(User user,
      {required int page, String? search, bool? update = false}) async {
    try {
      final casosList =
          await remoteSource.getCitas(user, page: page, search: search);
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
  Future<Either<Failure, List<Comentario>>> getCitaHistorial(
    User user,
    int citaId,
  ) async {
    try {
      final casosList = await remoteSource.getComentariosById(user, citaId);
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
  Future<Either<Failure, List<Comentario>>> sendComentario(
      User user, int citaId, String comentario,
      {File? image, required String nombreDocumento}) async {
    try {
      await remoteSource.sendComentario(
        user: user,
        citaId: citaId,
        comentario: comentario,
        image: image,
        nombreDocumento: nombreDocumento,
      );
      return const Right([]);
    } on InternetAccessException catch (e) {
      return Left(InternetFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
