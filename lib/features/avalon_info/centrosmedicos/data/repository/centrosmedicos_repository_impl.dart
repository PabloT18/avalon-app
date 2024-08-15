import 'package:avalon_app/app/data/sources/local/enviroment.dart';
import 'package:avalon_app/features/avalon_info/centrosmedicos/domain/models/centro_medico_entity.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/centrosmedicos_repository.dart';
import '../models/centros_medicos_response.dart';

class CentrosmedicosRepositoryImpl implements CentrosmedicosRepository {
  final String baseUrl = Environment.avalonApi;
  late Dio dio;

  CentrosmedicosRepositoryImpl() {
    dio = Dio();
  }
  @override
  Future<List<CentroMedico>> getMedicos() async {
    final String url = '$baseUrl/centrosMedicos';
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
        final medicosResponse =
            CentrosMedicosDataResponse.fromJson(response.data);
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
