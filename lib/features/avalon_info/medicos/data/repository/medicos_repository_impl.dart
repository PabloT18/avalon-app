import 'package:avalon_app/app/data/sources/local/enviroment.dart';
import 'package:avalon_app/features/avalon_info/medicos/domain/models/medico_entity.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/medicos_repository.dart';
import '../models/medicos_response.dart';

class MedicosRepositoryImpl implements MedicosRepository {
  final String baseUrl = Environment.avalonApi;
  late Dio dio;

  MedicosRepositoryImpl() {
    dio = Dio();
  }

  @override
  Future<List<Medico>> getMedicos() async {
    final String url = '$baseUrl/medicos';
    const String token =
        'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhdmFsb24iLCJpYXQiOjE3MTYyMTExNzgsImV4cCI6MTc0Nzc0NzE3OH0.rLk9oE1p0PJUGv8XZKgPNQJN0aDNuz0Gkr-IsNfGomzg1bv9-PTb40AIxCQJg2XXnMKSKfBUI-5bVI82pmBsWw';

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
        final medicosResponse = MedicosResponse.fromJson(response.data);
        return medicosResponse.data ?? [];
      } else {
        throw Exception('Failed to load listado de médicos');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }
}
