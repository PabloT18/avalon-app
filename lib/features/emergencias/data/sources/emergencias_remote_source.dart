import 'package:avalon_app/core/config/remote/app_remote_config.dart';
import 'package:avalon_app/features/emergencias/data/models/emergencias_response.dart';

import 'package:shared_models/shared_models.dart';

class EmergenciasRemoteSource {
  EmergenciasRemoteSource();
  Future<List<EmergenciaModel>> getEmergenciasByCaseId(User user, int casoId,
      {required int page, String? search, bool? update = false}) async {
    String url;

    if (search == null) {
      url =
          '/emergencias?casoId=$casoId&page=$page&size=5&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/emergencias?casoId=$casoId&page=$page&size=5&busqueda=$search&sortField=createdDate&sortOrder=desc';
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
        final casosResponse = EmergenciaResponse.fromJson(response.data);
        return casosResponse.data ?? [];
      } else {
        throw Exception('Error fetching data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }

  Future<List<EmergenciaModel>> getEmergencias(User user,
      {required int page, String? search}) async {
    String url;

    if (search == null) {
      url =
          '/emergencias?&page=$page&size=5&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/emergencias?&page=$page&size=5&busqueda=$search&sortField=createdDate&sortOrder=desc';
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
        final casosResponse = EmergenciaResponse.fromJson(response.data);
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
