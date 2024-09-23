import 'dart:io';

import 'package:avalon_app/core/error/exceptions/exceptions.dart';
import 'package:avalon_app/core/error/failures/failures.dart';

import 'package:avalon_app/features/reclamaciones/data/models/reclamaciones_response.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:dartz/dartz.dart';
import 'package:shared_models/shared_models.dart';

import '../../domain/repository/reclamaciones_repository.dart';
import '../sources/reclamaciones_remote_source.dart';

class ReclamacionesRepositoryImpl implements ReclamacionesRepository {
  ReclamacionesRepositoryImpl() {
    remoteSource = ReclamacionesRemoteSource();
  }

  late ReclamacionesRemoteSource remoteSource;

  @override
  Future<Either<Failure, List<ReclamacionModel>>> getReclamacionesById(
      User user, int reclamacionId,
      {required int page, String? search, bool? update = false}) async {
    try {
      final casosList = await remoteSource.getReclamaciionesByCaseId(
          user, reclamacionId,
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
  Future<Either<Failure, List<ReclamacionModel>>> getReclamaciones(User user,
      {required int page, String? search, bool? update = false}) async {
    try {
      final casosList =
          await remoteSource.getreclamaciones(user, page: page, search: search);
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
  Future<Either<Failure, List<Comentario>>> getReclamacionesHistorial(
    User user,
    int reclamacionId,
  ) async {
    try {
      final casosList =
          await remoteSource.getComentariosById(user, reclamacionId);
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
  Future<Either<Failure, List<Comentario>>> sendComentarioReclamacion(
      User user, int reclamacionId, String comentario,
      {File? image, required String nombreDocumento}) async {
    try {
      await remoteSource.sendComentario(
        user: user,
        reclamcionId: reclamacionId,
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
  Future<Either<Failure, ReclamacionModel>> createReclamacion(
      User user, ReclamacionModel reclamacion,
      {File? image, required String nombreDocumento}) async {
    try {
      final casosList = await remoteSource.crearReclamacion(
        user,
        reclamacion,
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
