import 'package:avalon_app/core/config/remote/app_remote_config.dart';
import 'package:avalon_app/features/avalon_info/medicos/domain/models/medico_entity.dart';

import 'package:shared_models/shared_models.dart';

import '../../domain/repository/medicos_repository.dart';
import '../models/medicos_response.dart';

class MedicosRepositoryImpl implements MedicosRepository {
  MedicosRepositoryImpl();

  @override
  Future<List<Medico>> getMedicos(
    User user, {
    String? search,
  }) async {
    // const String url = '/medicos?size=10&busqueda=gener&sortField=createdDate&sortOrder=desc';
    String url;

    if (search == null) {
      url = '/medicos?page=0&size=50&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/medicos?page=0&size=50&busqueda=$search&sortField=createdDate&sortOrder=desc';
    }

    try {
      final response = await APPRemoteConfig.httpGet(
        url: url,
        exception: Exception('Error fetching data'),
        token: user.token!,
      );
      if (response.statusCode == 200) {
        final medicosResponse = MedicosResponse.fromJson(response.data);
        return medicosResponse.data ?? [];
      } else {
        throw Exception('Failed to load listado de médicos');
      }
    } catch (e) {
      rethrow;
    }
  }
}
