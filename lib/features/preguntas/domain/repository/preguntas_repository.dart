import '../../data/models/preguntas_resonse.dart';

abstract class PreguntasRepository {
  Future<List<PreguntaResponse>> fetchPreguntas(int id);
}
