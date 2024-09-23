import 'dart:io';

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

  @override
  Future<Either<Failure, List<Comentario>>> getEmergenciasHistorial(
    User user,
    int emergenciaId,
  ) async {
    try {
      final casosList =
          await remoteSource.getComentariosById(user, emergenciaId);
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
      User user, int emergenciaId, String comentario,
      {File? image, required String nombreDocumento}) async {
    try {
      await remoteSource.sendComentario(
        user: user,
        emergenciaId: emergenciaId,
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

  @override
  Future<Either<Failure, EmergenciaModel>> createEmergencia(
      User user, EmergenciaModel emergencia,
      {File? image, required String nombreDocumento}) async {
    try {
      final casosList = await remoteSource.crearEmergencia(
        user,
        emergencia,
        image,
        nombreDocumento: nombreDocumento,
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
