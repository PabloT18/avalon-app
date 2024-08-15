import 'package:authentication_repository/authentication_repository.dart';
import 'package:shared_models/shared_models.dart';

abstract class UserClientRepository {
  /// Obtiene los datos del cliente (otro usuario) según el ID proporcionado.
  Future<User> getClientData({
    required int clientId,
    required String token,
  });

  /// Actualiza los datos del usuario autenticado.
  Future<void> getAuthenticatedUserData({
    required User user,
    required String token,
  });

  /// Actualiza los datos de un cliente (otro usuario).
  Future<void> updateClientData({
    required User user,
    required String token,
  });
}
