import 'package:avalon_app/app/domain/repository/user_client_repositoty.dart';
import 'package:shared_models/shared_models.dart';

class UpdateUserAddressUseCase {
  final UserClientRepository userClientRepository;

  UpdateUserAddressUseCase({required this.userClientRepository});

  Future<bool> call(User user, String token) async {
    return await userClientRepository.updateClientData(
        user: user, token: token);
  }
}
