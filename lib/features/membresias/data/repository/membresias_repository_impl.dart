import 'package:avalon_app/core/config/remote/app_remote_config.dart';
import 'package:avalon_app/core/error/exceptions/exceptions.dart';
import 'package:avalon_app/core/error/failures/failures.dart';
import 'package:avalon_app/features/membresias/domain/models/membresia_register_entity.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/membresias_repository.dart';
import '../models/membresias_response.dart';

class MembresiasRepositoryImpl implements MembresiasRepository {
  const MembresiasRepositoryImpl();
  @override
  Future<List<MembresiaRegister>> getRegistrosMembresias(
      String id, String token) async {
    final String url = '/clientes/$id/clienteMembresias';

    try {
      // Utiliza el método httpGet de APPRemoteConfig
      final response = await APPRemoteConfig.httpGet(
        url: url,
        exception: Exception('Failed to load listado de membresias'),
        token: token,
      );

      // Verifica el statusCode directamente en el response
      if (response.statusCode == 200) {
        final medicosResponse = MembresiasResponse.fromJson(response.data);
        return medicosResponse.membresiaResponse ?? [];
      } else {
        throw Exception('Failed to load listado de membresias');
      }
    } on InternetAccessException {
      rethrow;
    } on ServerException catch (s) {
      throw ServerException(
          message: s.message ?? apptexts.appOptions.error_servers);
    } on Exception {
      throw ServerException(message: apptexts.appOptions.error_servers);
    }
  }
}
