// To parse this JSON data, do
//
//     final emergenciaResponse = emergenciaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:avalon_app/features/casos/data/models/casos_response.dart';
import 'package:avalon_app/features/user_features.dart';
import 'package:shared_models/shared_models.dart';

EmergenciaResponse emergenciaResponseFromJson(String str) =>
    EmergenciaResponse.fromJson(json.decode(str));

String emergenciaResponseToJson(EmergenciaResponse data) =>
    json.encode(data.toJson());

class EmergenciaResponse {
  final List<EmergenciaModel>? data;
  final int? totalRecords;

  EmergenciaResponse({
    this.data,
    this.totalRecords,
  });

  factory EmergenciaResponse.fromJson(Map<String, dynamic> json) =>
      EmergenciaResponse(
        data: json["data"] == null
            ? []
            : List<EmergenciaModel>.from(
                json["data"]!.map((x) => EmergenciaModel.fromJson(x))),
        totalRecords: json["totalRecords"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalRecords": totalRecords,
      };
}

class EmergenciaModel {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? codigo;
  final int? imagenId;
  final String? estado;
  final String? diagnostico;
  final String? sintomas;
  final CasoEntity? caso;
  final Direccion? direccion;
  final ClientePoliza? clientePoliza;
  final MedicoCentroMedicoAseguradora? medicoCentroMedicoAseguradora;

  EmergenciaModel({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.codigo,
    this.imagenId,
    this.estado,
    this.diagnostico,
    this.sintomas,
    this.caso,
    this.clientePoliza,
    this.direccion,
    this.medicoCentroMedicoAseguradora,
  });

  factory EmergenciaModel.fromJson(Map<String, dynamic> json) =>
      EmergenciaModel(
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
        imagenId: json["imagenId"],
        estado: json["estado"],
        diagnostico: json["diagnostico"],
        sintomas: json["sintomas"],
        direccion: json["direccion"] == null
            ? null
            : Direccion.fromJson(json["direccion"]),
        caso: json["caso"] == null ? null : CasoResponse.fromJson(json["caso"]),
        clientePoliza: json["clientePoliza"] == null
            ? null
            : ClientePoliza.fromJson(json["clientePoliza"]),
        medicoCentroMedicoAseguradora:
            json["medicoCentroMedicoAseguradora"] == null
                ? null
                : MedicoCentroMedicoAseguradora.fromJson(
                    json["medicoCentroMedicoAseguradora"]),
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "codigo": codigo,
        "imagenId": imagenId,
        "estado": estado,
        "diagnostico": diagnostico,
        "sintomas": sintomas,
        "direccion": direccion?.toJson(),
        "caso": caso?.toJson(),
        "clientePoliza": clientePoliza?.toJson(),
        "medicoCentroMedicoAseguradora":
            medicoCentroMedicoAseguradora?.toJson(),
      };

  Map<String, dynamic> toJsonCreate() => {
        "diagnostico": diagnostico,
        "sintomas": sintomas,
        "direccion": direccion?.toJson(),
        "casoId": caso?.id,
        "clientePolizaId": clientePoliza?.id,
      };
}

class MedicoCentroMedicoAseguradora {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final Aseguradora? aseguradora;
  final Medico? medico;
  final Aseguradora? centroMedico;

  MedicoCentroMedicoAseguradora({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.aseguradora,
    this.medico,
    this.centroMedico,
  });

  factory MedicoCentroMedicoAseguradora.fromJson(Map<String, dynamic> json) =>
      MedicoCentroMedicoAseguradora(
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"] == null
            ? null
            : DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        aseguradora: json["aseguradora"] == null
            ? null
            : Aseguradora.fromJson(json["aseguradora"]),
        medico: json["medico"] == null ? null : Medico.fromJson(json["medico"]),
        centroMedico: json["centroMedico"] == null
            ? null
            : Aseguradora.fromJson(json["centroMedico"]),
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "aseguradora": aseguradora?.toJson(),
        "medico": medico?.toJson(),
        "centroMedico": centroMedico?.toJson(),
      };
}

class Medico {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? nombres;
  final String? nombresDos;
  final String? apellidos;
  final String? apellidosDos;
  final String? correoElectronico;
  final String? numeroTelefono;
  final Direccion? direccion;
  final String? estado;
  final dynamic urlImagen;
  final Aseguradora? especialidad;
  final String? nombreCompleto;

  Medico({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.nombres,
    this.nombresDos,
    this.apellidos,
    this.apellidosDos,
    this.correoElectronico,
    this.numeroTelefono,
    this.direccion,
    this.estado,
    this.urlImagen,
    this.especialidad,
    this.nombreCompleto,
  });

  factory Medico.fromJson(Map<String, dynamic> json) => Medico(
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
            : Direccion.fromJson(json["direccion"]),
        estado: json["estado"],
        urlImagen: json["urlImagen"],
        especialidad: json["especialidad"] == null
            ? null
            : Aseguradora.fromJson(json["especialidad"]),
        nombreCompleto: json["nombreCompleto"],
      );

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
