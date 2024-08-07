// To parse this JSON data, do
//
//     final medicosResponse = medicosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:avalon_app/app/domain/entity/app_entities.dart';

import '../../domain/models/medico_models.dart';

MedicosResponse medicosResponseFromJson(String str) =>
    MedicosResponse.fromJson(json.decode(str));

String medicosResponseToJson(MedicosResponse data) =>
    json.encode(data.toJson());

class MedicosResponse {
  final List<MedicoResponse>? data;
  final int? totalRecords;

  MedicosResponse({
    this.data,
    this.totalRecords,
  });

  factory MedicosResponse.fromJson(Map<String, dynamic> json) =>
      MedicosResponse(
        data: json["data"] == null
            ? []
            : List<MedicoResponse>.from(
                json["data"]!.map((x) => MedicoResponse.fromJson(x))),
        totalRecords: json["totalRecords"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalRecords": totalRecords,
      };
}

class MedicoResponse extends Medico {
  const MedicoResponse({
    super.createdBy,
    super.createdDate,
    super.lastModifiedBy,
    super.lastModifiedDate,
    super.id,
    super.nombres,
    super.nombresDos,
    super.apellidos,
    super.apellidosDos,
    super.correoElectronico,
    super.numeroTelefono,
    super.direccion,
    super.estado,
    super.urlImagen,
    super.especialidad,
    super.nombreCompleto,
  });

  factory MedicoResponse.fromJson(Map<String, dynamic> json) => MedicoResponse(
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"] == null
            ? null
            : DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        nombres: json["nombres"],
        nombresDos: json["nombresDos"],
        apellidos: json["apellidos"],
        apellidosDos: json["apellidosDos"],
        correoElectronico: json["correoElectronico"],
        numeroTelefono: json["numeroTelefono"],
        direccion: json["direccion"] == null
            ? null
            : DireccionResponse.fromJson(json["direccion"]),
        estado: json["estado"],
        urlImagen: json["urlImagen"],
        especialidad: json["especialidad"] == null
            ? null
            : EspecialidadResponse.fromJson(json["especialidad"]),
        nombreCompleto: json["nombreCompleto"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "nombres": nombres,
        "nombresDos": nombresDos,
        "apellidos": apellidos,
        "apellidosDos": apellidosDos,
        "correoElectronico": correoElectronico,
        "numeroTelefono": numeroTelefono,
        "direccion": direccion?.toJson(),
        "estado": estado,
        "urlImagen": urlImagen,
        "especialidad": especialidad?.toJson(),
        "nombreCompleto": nombreCompleto,
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

class EspecialidadResponse extends Especialidad {
  const EspecialidadResponse({
    super.createdBy,
    super.createdDate,
    super.lastModifiedBy,
    super.lastModifiedDate,
    super.id,
    super.nombre,
    super.descripcion,
  });

  factory EspecialidadResponse.fromJson(Map<String, dynamic> json) =>
      EspecialidadResponse(
        createdBy: json["createdBy"],
        createdDate: json["createdDate"],
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"],
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate,
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate,
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
      };
}
