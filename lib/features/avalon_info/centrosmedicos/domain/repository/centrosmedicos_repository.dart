import '../models/centro_medico_entity.dart';

abstract class CentrosmedicosRepository {
  Future<List<CentroMedico>> getMedicos();
}
