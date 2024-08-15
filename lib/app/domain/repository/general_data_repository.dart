import 'package:shared_models/shared_models.dart';

abstract class GeneralDataRepository {
  const GeneralDataRepository();
  Future<List<Pais>> getPaises(String token);

  Future<List<Estado>> getEstados(String token, int paisId);
}
