import 'package:avalon_app/core/error/exceptions/exceptions.dart';
import 'package:avalon_app/core/error/failures/failures.dart';

import 'package:avalon_app/features/casos/domain/repository/cliente_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_models/shared_models.dart';

import '../sources/cliente_remote_source.dart';

class ClientesRepositoryImpl extends ClientesRepository {
  ClientesRepositoryImpl() {
    clienteRemoteSource = ClienteRemoteSource();
  }

  late ClienteRemoteSource clienteRemoteSource;

  @override
  Future<Either<Failure, List<UsrCliente>>> getClientes(User user,
      {required int page, String? search, bool? update = false}) async {
    try {
      final clientes = await clienteRemoteSource.getClientes(user,
          page: page, search: search, update: update);
      return Right(clientes);
    } on InternetAccessException catch (e) {
      return Left(InternetFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ClientePoliza>>> getClientesPolizas(
      User user, int clienteId,
      {required int page, String? search, bool? update = false}) async {
    try {
      final polizas = await clienteRemoteSource.getPolizasByClienteId(
        user,
        clienteId,
        page: page,
        search: search,
        update: update,
      );
      return Right(polizas);
    } on InternetAccessException catch (e) {
      return Left(InternetFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getFamiliares(User user, int polizaId,
      {required int page, String? search, bool? update = false}) async {
    try {
      final familiares =
          await clienteRemoteSource.getFamiliaresByPlozizaClienteId(
        user,
        polizaId,
        page: page,
        search: search,
        update: update,
      );
      return Right(familiares);
    } on InternetAccessException catch (e) {
      return Left(InternetFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
