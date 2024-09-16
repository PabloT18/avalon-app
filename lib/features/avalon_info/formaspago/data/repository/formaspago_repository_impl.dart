import 'package:avalon_app/core/config/remote/app_remote_config.dart';
import 'package:avalon_app/features/avalon_info/formaspago/data/models/metodo_pago_model.dart';

import 'package:shared_models/shared_models.dart';

import '../../domain/repository/formaspago_repository.dart';

class FormasPagoRepositoryImpl implements FormasPagoRepository {
  @override
  Future<List<MetodoPago>> getMetodosPago(User user) async {
    const String url = '/metodosPago';

    try {
      final response = await APPRemoteConfig.httpGet(
        url: url,
        exception: Exception('Error fetching data'),
        token: user.token!,
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
