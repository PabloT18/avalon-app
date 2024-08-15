import 'package:shared_models/shared_models.dart';

import '../repository/user_client_repositoty.dart';

class UpdateClientData {
  final UserClientRepository repository;

  UpdateClientData({required this.repository});

  Future<void> call({required User user, required String token}) async {
    await repository.updateClientData(user: user, token: token);
  }
}
