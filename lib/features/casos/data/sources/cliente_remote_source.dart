import 'package:avalon_app/core/config/remote/app_remote_config.dart';

import 'package:shared_models/shared_models.dart';

import '../models/cliente_poliza_service_sresponse.dart';

class ClienteRemoteSource {
  Future<List<UsrCliente>> getClientes(User user,
      {required int page, String? search, bool? update = false}) async {
    String url;
    if (search == null) {
      url =
          '/clientes?estado=A&page=$page&size=100&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/clientes?estado=A&page=$page&size=100&busqueda=$search&sortField=createdDate&sortOrder=desc';
    }
    try {
      final response = await APPRemoteConfig.httpGet(
        url: url,
        exception: Exception('Error fetching data'),
        token: user.token!,
      );

      if (response.statusCode == 200) {
        // final List<dynamic> jsonResponse = response.data;
        // return jsonResponse.map((data) => UsrCliente.fromJson(data)).toList();
        final List<dynamic> cleintesRsponse = response.data["data"];

        // Mapear directamente la lista a objetos ClientePolizaResponse
        final clientes = cleintesRsponse
            .map((json) => UsrClienteResponse.fromJson(json))
            .toList();

        return clientes;
      } else {
        throw Exception('Error fetching clients');
      }
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    }
  }

  Future<List<ClientePoliza>> getPolizasByClienteId(User user, int clienteId,
      {required int page, String? search, bool? update = false}) async {
    String url;
    if (search == null) {
      url =
          '/clientes/$clienteId/clientesPolizas?page=$page&size=100&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/clientes/$clienteId/clientesPolizas?page=$page&size=100&busqueda=$search&sortField=createdDate&sortOrder=desc';
    }
    try {
      final response = await APPRemoteConfig.httpGet(
        url: url,
        exception: Exception('Error fetching data'),
        token: user.token!,
      );

      if (response.statusCode == 200) {
        final List<dynamic> clientePolizasJson = response.data["data"];

        // Mapear directamente la lista a objetos ClientePolizaResponse
        final clientePolizas = clientePolizasJson
            .map((json) => ClientePolizaResponse.fromJson(json))
            .toList();

        return clientePolizas;
        // final responseService =
        //     ClientePolizaResponseService.fromJson(response.data);
        // return responseService.clientePolizas ?? [];
      } else {
        throw Exception('Error fetching policies');
      }
    } catch (e) {
      throw Exception('Error fetching policies for client: $e');
    }
  }
}
