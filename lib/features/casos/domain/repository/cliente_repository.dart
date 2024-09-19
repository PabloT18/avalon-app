import 'package:avalon_app/core/error/failures/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:shared_models/shared_models.dart';

abstract class ClientesRepository {
  Future<Either<Failure, List<UsrCliente>>> getClientes(User user,
      {required int page, String? search, bool? update = false});

  Future<Either<Failure, List<ClientePoliza>>> getClientesPolizas(
      User user, int clienteId,
      {required int page, String? search, bool? update = false});
}
