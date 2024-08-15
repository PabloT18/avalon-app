import 'package:avalon_app/app/domain/repository/general_data_repository.dart';
import 'package:shared_models/shared_models.dart';

class GetPaisesUseCase {
  final GeneralDataRepository generalDataRepository;

  GetPaisesUseCase({required this.generalDataRepository});

  Future<List<Pais>> call(String token) async {
    return await generalDataRepository.getPaises(token);
  }
}
