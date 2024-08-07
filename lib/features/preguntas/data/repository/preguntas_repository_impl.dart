import 'package:avalon_app/features/preguntas/data/models/preguntas_resonse.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/preguntas_repository.dart';

class PreguntasRepositoryImpl implements PreguntasRepository {
  @override
  Future<List<PreguntaResponse>> fetchPreguntas(int id) async {
    final String url = 'http://149.56.110.32:8087/padres/$id/preguntas';

    const String token =
        'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhdmFsb24iLCJpYXQiOjE3MTYyMTExNzgsImV4cCI6MTc0Nzc0NzE3OH0.rLk9oE1p0PJUGv8XZKgPNQJN0aDNuz0Gkr-IsNfGomzg1bv9-PTb40AIxCQJg2XXnMKSKfBUI-5bVI82pmBsWw';

    final dio = Dio();
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );
      if (response.statusCode == 200) {
        // Asegúrate de decodificar la respuesta correctamente
        final List<dynamic> jsonResponse = response.data;
        return jsonResponse
            .map((data) => PreguntaResponse.fromJson(data))
            .toList();
      } else {
        throw Exception('Failed to load preguntas');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }
}
