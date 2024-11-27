import 'package:shared_models/shared_models.dart';

import '../models/medico_entity.dart';

abstract class MedicosRepository {
  Future<List<Medico>> getMedicos(
    User user, {
    String? search,
  });
}
