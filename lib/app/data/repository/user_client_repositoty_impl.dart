import 'package:avalon_app/core/config/remote/app_remote_config.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:cache/cache.dart';
import 'package:shared_models/shared_models.dart';

import '../../domain/repository/user_client_repositoty.dart';

class UserClientRepositoryImpl extends UserClientRepository {
  final CacheClient _cache = CacheClient();
  static const String _userCacheKey = ConstHiveBox.kSettingsLanguage;

  @override
  Future<bool> updateClientData(
      {required dynamic user, required String token}) async {
    if (user.userRol == UserRol.agente) {
      return _updateAgentetData(user: user, token: token);
    } else if (user.userRol == UserRol.asesor) {
      return _updateAsesorData(user: user, token: token);
    } else {
      return _updateClient(user: user as UsrCliente, token: token);
    }
  }

  Future<bool> _updateClient(
      {required UsrCliente user, required String token}) async {
    final String url = '/clientes/${user.id}'; // Ajusta la URL según tu API
    final Map<String, dynamic> data = user.toJson();

    try {
      final response = await APPRemoteConfig.httpPut(
        url: url,
        data: data,
        token: token,
      );

      if (response.statusCode != 200) {
        throw Exception(apptexts.perfilPage.errorUpdateUserData);
      }
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Actulaiza agent del broker

  Future<bool> _updateAgentetData(
      {required User user, required String token}) async {
    final String url = '/agentes/${user.id}'; // Ajusta la URL según tu API
    final Map<String, dynamic> data = user.toJson();

    try {
      final response = await APPRemoteConfig.httpPut(
        url: url,
        data: data,
        token: token,
      );

      if (response.statusCode != 200) {
        throw Exception(apptexts.perfilPage.errorUpdateUserData);
      }
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Actulaiza asesor aVLAOn INFO

  Future<bool> _updateAsesorData(
      {required User user, required String token}) async {
    final String url = '/asesores/${user.id}'; // Ajusta la URL según tu API
    final Map<String, dynamic> data = user.toJson();

    try {
      final response = await APPRemoteConfig.httpPut(
        url: url,
        data: data,
        token: token,
      );

      if (response.statusCode != 200) {
        throw Exception(apptexts.perfilPage.errorUpdateUserData);
      }
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<User> getAuthenticatedUserData(
      {required User user, required String token}) async {
    try {
      final response = await APPRemoteConfig.httpGet(
        url: '/usuarios/authenticated',
        token: token,
        exception: Exception('Failed to update user data'),
      );

      if (response.statusCode == 200) {
        final userData = response.data as Map<String, dynamic>;
        final user = UserResponse.fromJson(userData);

        // Actualizar el cache con los datos más recientes del usuario.
        await _cache.write(key: _userCacheKey, value: user.toJson());

        return user;
      } else {
        throw Exception('Failed to fetch authenticated user data');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al obtener datos del usuario autenticado');
    }
  }

  @override
  Future<User> getClientData({required int clientId, required String token}) {
    // TODO: implement getClientData
    throw UnimplementedError();
  }
}
