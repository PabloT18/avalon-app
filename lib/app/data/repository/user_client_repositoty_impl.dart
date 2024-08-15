import 'package:shared_models/shared_models.dart';

import '../../domain/repository/user_client_repositoty.dart';

class UserClientRepositoryImpl extends UserClientRepository {
  @override
  Future<void> updateClientData({required User user, required String token}) {
    throw UnimplementedError();
  }

  @override
  Future<void> getAuthenticatedUserData(
      {required User user, required String token}) {
    // TODO: implement getAuthenticatedUserData
    throw UnimplementedError();
  }

  @override
  Future<User> getClientData({required int clientId, required String token}) {
    // TODO: implement getClientData
    throw UnimplementedError();
  }
}
