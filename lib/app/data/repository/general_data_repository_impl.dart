import 'package:avalon_app/core/config/remote/app_remote_config.dart';
import 'package:shared_models/shared_models.dart';

import '../../domain/repository/general_data_repository.dart';

class GeneralDataRepositoryImpl extends GeneralDataRepository {
  const GeneralDataRepositoryImpl();

  @override
  Future<List<Pais>> getPaises(String token) async {
    try {
      final response = await APPRemoteConfig.httpGet(
        url: '/paises',
        exception: Exception('Error fetching countries'),
        token: token, // Asegúrate de pasar el token correcto
      );
      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((pais) => PaisModel.fromJson(pais)).toList();
      }
      throw Exception('Failed to load countries');
    } catch (e) {
      throw Exception('Failed to load countries');
    }
  }

  @override
  Future<List<Estado>> getEstados(String token, int paisId) async {
    try {
      final response = await APPRemoteConfig.httpGet(
        url: '/paises/$paisId/estados',
        exception: Exception('Error fetching countries'),
        token: token, // Asegúrate de pasar el token correcto
      );
      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((pais) => EstadoModel.fromJson(pais)).toList();
      }
      throw Exception('Failed to load states');
    } catch (e) {
      throw Exception('Failed to load states');
    }
  }
}
