import 'package:shared_models/shared_models.dart';

import '../../repository/general_data_repository.dart';

class GetEstadosUseCase {
  final GeneralDataRepository repository;

  GetEstadosUseCase(this.repository);

  Future<List<Estado>> call({required int paisId, required String token}) {
    return repository.getEstados(token, paisId);
  }
}
