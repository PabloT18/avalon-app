import '../models/medico_entity.dart';

abstract class MedicosRepository {
  Future<List<Medico>> getMedicos();
}
