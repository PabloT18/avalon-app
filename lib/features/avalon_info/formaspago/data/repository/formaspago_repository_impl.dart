import 'package:avalon_app/features/avalon_info/formaspago/data/models/metodo_pago_model.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/formaspago_repository.dart';

class FormasPagoRepositoryImpl implements FormasPagoRepository {
  final String baseUrl = 'http://149.56.110.32:8086';
  late Dio dio;

  FormasPagoRepositoryImpl() {
    dio = Dio();
  }

  @override
  Future<List<MetodoPago>> getMetodosPago() async {
    final String url = '$baseUrl/metodosPago';
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
        final List<dynamic> jsonResponse = response.data;
        return jsonResponse.map((data) => MetodoPago.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load metodos de pago');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }
}
