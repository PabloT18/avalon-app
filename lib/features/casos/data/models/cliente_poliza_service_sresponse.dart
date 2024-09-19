import 'dart:convert';

import 'package:shared_models/shared_models.dart';

ClientePolizaResponseService clientePolizaResponseServiceFromJson(String str) =>
    ClientePolizaResponseService.fromJson(json.decode(str));

String clientePolizaResponseServiceToJson(
        ClientePolizaResponseService clientePolizas) =>
    json.encode(clientePolizas.toJson());

class ClientePolizaResponseService {
  final List<ClientePolizaResponse>? clientePolizas;
  final int? totalRecords;

  ClientePolizaResponseService({
    this.clientePolizas,
    this.totalRecords,
  });

  factory ClientePolizaResponseService.fromJson(Map<String, dynamic> json) =>
      ClientePolizaResponseService(
        clientePolizas: json["clientePolizas"] == null
            ? []
            : List<ClientePolizaResponse>.from(json["clientePolizas"]!
                .map((x) => ClientePolizaResponse.fromJson(x))),
        totalRecords: json["totalRecords"],
      );

  Map<String, dynamic> toJson() => {
        "clientePolizas": clientePolizas == null
            ? []
            : List<dynamic>.from(clientePolizas!.map((x) => x.toJson())),
        "totalRecords": totalRecords,
      };
}
