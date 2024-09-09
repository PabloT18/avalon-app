import 'dart:convert';

import 'package:avalon_app/features/casos/domain/models/caso_entity.dart';
import 'package:shared_models/shared_models.dart';

CasosResponse casosResponseFromJson(String str) =>
    CasosResponse.fromJson(json.decode(str));

String casosResponseToJson(CasosResponse data) => json.encode(data.toJson());

class CasosResponse {
  final List<CasoResponse>? data;
  final int? totalRecords;

  CasosResponse({
    this.data,
    this.totalRecords,
  });

  factory CasosResponse.fromJson(Map<String, dynamic> json) => CasosResponse(
        data: json["data"] == null
            ? []
            : List<CasoResponse>.from(
                json["data"]!.map((x) => CasoResponse.fromJson(x))),
        totalRecords: json["totalRecords"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalRecords": totalRecords,
      };
}

class CasoResponse extends CasoEntity {
  const CasoResponse({
    super.createdBy,
    super.createdDate,
    super.lastModifiedBy,
    super.lastModifiedDate,
    super.id,
    super.codigo,
    super.observaciones,
    super.clientePoliza,
    super.displayName,
    super.clienteDisplayName,
  });

  factory CasoResponse.fromJson(Map<String, dynamic> json) => CasoResponse(
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"] == null
            ? null
            : DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        codigo: json["codigo"],
        observaciones: json["observaciones"],
        clientePoliza: json["clientePoliza"] == null
            ? null
            : ClientePolizaResponse.fromJson(json["clientePoliza"]),
        displayName: json["displayName"],
        clienteDisplayName: json["clienteDisplayName"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "codigo": codigo,
        "observaciones": observaciones,
        "clientePoliza": clientePoliza?.toJson(),
        "displayName": displayName,
        "clienteDisplayName": clienteDisplayName,
      };
}
