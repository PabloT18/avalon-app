import 'package:shared_models/shared_models.dart';

import '../models/centro_medico_entity.dart';

abstract class CentrosmedicosRepository {
  Future<List<CentroMedico>> getMedicos(User user);
}
