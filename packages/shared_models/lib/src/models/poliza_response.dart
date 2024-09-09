import 'package:shared_models/src/entities/poliza_entity.dart';

import 'aseguradora_response.dart';

class PolizaResponse extends Poliza {
  const PolizaResponse({
    super.createdBy,
    super.createdDate,
    super.lastModifiedBy,
    super.lastModifiedDate,
    super.id,
    super.nombre,
    super.descripcion,
    super.estado,
    super.vigenciaMeses,
    super.aseguradora,
  });

  factory PolizaResponse.fromJson(Map<String, dynamic> json) => PolizaResponse(
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"] == null
            ? null
            : DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        vigenciaMeses: json["vigenciaMeses"],
        aseguradora: json["aseguradora"] == null
            ? null
            : AseguradoraResponse.fromJson(json["aseguradora"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
        "vigenciaMeses": vigenciaMeses,
        "aseguradora": aseguradora?.toJson(),
      };
}
