import 'dart:convert';

import 'package:avalon_app/app/domain/entity/general_entities.dart';

import '../../domain/models/centro_medico_entity.dart';

CentrosMedicosDataResponse centroMedicoResponseFromJson(String str) =>
    CentrosMedicosDataResponse.fromJson(json.decode(str));

String centroMedicoResponseToJson(CentrosMedicosDataResponse data) =>
    json.encode(data.toJson());

class CentrosMedicosDataResponse {
  final List<CentroMedicoResponse>? data;
  final int? totalRecords;

  CentrosMedicosDataResponse({
    this.data,
    this.totalRecords,
  });

  factory CentrosMedicosDataResponse.fromJson(Map<String, dynamic> json) =>
      CentrosMedicosDataResponse(
        data: json["data"] == null
            ? []
            : List<CentroMedicoResponse>.from(
                json["data"]!.map((x) => CentroMedicoResponse.fromJson(x))),
        totalRecords: json["totalRecords"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalRecords": totalRecords,
      };
}

class CentroMedicoResponse extends CentroMedico {
  const CentroMedicoResponse({
    super.createdBy,
    super.createdDate,
    super.lastModifiedBy,
    super.lastModifiedDate,
    super.id,
    super.nombre,
    super.descripcion,
    super.correoElectronico,
    super.direccion,
  });

  factory CentroMedicoResponse.fromJson(Map<String, dynamic> json) =>
      CentroMedicoResponse(
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
        correoElectronico: json["correoElectronico"],
        direccion: json["direccion"] == null
            ? null
            : DireccionResponse.fromJson(json["direccion"]),
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
        "correoElectronico": correoElectronico,
        "direccion": direccion?.toJson(),
      };
}

class DireccionResponse extends Direccion {
  const DireccionResponse({
    super.direccionUno,
    super.direccionDos,
    super.ciudad,
    super.codigoPostal,
    super.pais,
    super.estado,
  });

  factory DireccionResponse.fromJson(Map<String, dynamic> json) =>
      DireccionResponse(
        direccionUno: json["direccionUno"],
        direccionDos: json["direccionDos"],
        ciudad: json["ciudad"],
        codigoPostal: json["codigoPostal"],
        pais: json["pais"] == null ? null : PaisResponse.fromJson(json["pais"]),
        estado: json["state"] == null
            ? null
            : EstadoResponse.fromJson(json["state"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "direccionUno": direccionUno,
        "direccionDos": direccionDos,
        "ciudad": ciudad,
        "codigoPostal": codigoPostal,
        "pais": pais?.toJson(),
        "state": estado?.toJson(),
      };
}

class PaisResponse extends Pais {
  const PaisResponse({
    super.id,
    super.nombre,
  });

  factory PaisResponse.fromJson(Map<String, dynamic> json) => PaisResponse(
        id: json["id"],
        nombre: json["nombre"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}

class EstadoResponse extends Estado {
  const EstadoResponse({
    super.id,
    super.nombre,
    super.pais,
  });

  factory EstadoResponse.fromJson(Map<String, dynamic> json) => EstadoResponse(
        id: json["id"],
        nombre: json["nombre"],
        pais: json["pais"] == null ? null : PaisResponse.fromJson(json["pais"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "pais": pais?.toJson(),
      };
}
