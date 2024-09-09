import 'package:avalon_app/core/config/remote/app_remote_config.dart';
import 'package:avalon_app/features/casos/data/models/casos_response.dart';
import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';
import 'package:shared_models/shared_models.dart';

class CasosRemoteSource {
  Future<List<CasoEntity>> getCases(
    User user, {
    int? page,
    String? search,
  }) async {
    String url;

    if (search == null) {
      url = '/casos?page=$page&size=5&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/casos?page=$page&size=5&busqueda=$search&sortField=createdDate&sortOrder=desc';
    }

    try {
      // Utiliza el método httpGet de APPRemoteConfig
      final response = await APPRemoteConfig.httpGet(
        url: url,
        exception: Exception('Error fetching data'),
        token: user.token!,
      );

      // Verifica el statusCode directamente en el response
      if (response.statusCode == 200) {
        final casosResponse = CasosResponse.fromJson(response.data);
        return casosResponse.data ?? [];
      } else {
        throw Exception('Error fetching data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }

  Future<List<CasoEntity>> getCasesByPolizaId(
    User user, {
    required int? page,
    required int? clientePolizaId,
    String? search,
  }) async {
    String url;
    if (search == null) {
      url =
          '/casos?page=$page&size=5&sortField=createdDate&sortOrder=desc&clientePolizaId=$clientePolizaId';
    } else {
      url =
          '/casos?page=$page&size=5&busqueda=$search&sortField=createdDate&sortOrder=desc&clientePolizaId=$clientePolizaId';
    }

    try {
      // Utiliza el método httpGet de APPRemoteConfig
      final response = await APPRemoteConfig.httpGet(
        url: url,
        exception: Exception('Error fetching data'),
        token: user.token!,
      );

      // Verifica el statusCode directamente en el response
      if (response.statusCode == 200) {
        final casosResponse = CasosResponse.fromJson(response.data);
        return casosResponse.data ?? [];
      } else {
        throw Exception('Error fetching data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }
}