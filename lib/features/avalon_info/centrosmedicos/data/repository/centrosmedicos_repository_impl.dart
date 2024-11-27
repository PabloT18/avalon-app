import 'package:avalon_app/core/config/remote/app_remote_config.dart';
import 'package:avalon_app/features/avalon_info/centrosmedicos/domain/models/centro_medico_entity.dart';

import 'package:shared_models/shared_models.dart';

import '../../domain/repository/centrosmedicos_repository.dart';
import '../models/centros_medicos_response.dart';

class CentrosmedicosRepositoryImpl implements CentrosmedicosRepository {
  @override
  Future<List<CentroMedico>> getMedicos(
    User user, {
    String? search,
  }) async {
    // const String url = '/centrosMedicos';

    String url;

    if (search == null) {
      url =
          '/centrosMedicos?page=0&size=50&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/centrosMedicos?page=0&size=50&busqueda=$search&sortField=createdDate&sortOrder=desc';
    }

    try {
      final response = await APPRemoteConfig.httpGet(
        url: url,
        exception: Exception('Error fetching data'),
        token: user.token!,
      );
      if (response.statusCode == 200) {
        final medicosResponse =
            CentrosMedicosDataResponse.fromJson(response.data);
        return medicosResponse.data ?? [];
      } else {
        throw Exception('Failed to load listado de médicos');
      }
    } catch (e) {
      rethrow;
    }
  }
}
