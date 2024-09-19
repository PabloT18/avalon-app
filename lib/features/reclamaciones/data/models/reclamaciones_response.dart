// class ReclamacionModel {}

// To parse this JSON data, do
//
//     final reclamacionResponse = reclamacionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:avalon_app/features/casos/data/models/casos_response.dart';
import 'package:avalon_app/features/citas/domain/models/citas_response.dart';
import 'package:shared_models/shared_models.dart';

ReclamacionResponse reclamacionResponseFromJson(String str) =>
    ReclamacionResponse.fromJson(json.decode(str));

String reclamacionResponseToJson(ReclamacionResponse data) =>
    json.encode(data.toJson());

class ReclamacionResponse {
  final List<ReclamacionModel>? data;
  final int? totalRecords;

  ReclamacionResponse({
    this.data,
    this.totalRecords,
  });

  factory ReclamacionResponse.fromJson(Map<String, dynamic> json) =>
      ReclamacionResponse(
        data: json["data"] == null
            ? []
            : List<ReclamacionModel>.from(
                json["data"]!.map((x) => ReclamacionModel.fromJson(x))),
        totalRecords: json["totalRecords"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalRecords": totalRecords,
      };
}

class ReclamacionModel {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? codigo;
  final DateTime? fechaServicio;
  final MedicoCentroMedicoAseguradora? medicoCentroMedicoAseguradora;
  final String? tipoAdm;
  final int? imagenId;
  final String? padecimientoDiagnostico;
  final String? infoAdicional;
  final String? estado;
  final ClientePoliza? clientePoliza;
  final CasoResponse? caso;

  ReclamacionModel({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.codigo,
    this.fechaServicio,
    this.medicoCentroMedicoAseguradora,
    this.tipoAdm,
    this.imagenId,
    this.padecimientoDiagnostico,
    this.infoAdicional,
    this.estado,
    this.clientePoliza,
    this.caso,
  });

  factory ReclamacionModel.fromJson(Map<String, dynamic> json) =>
      ReclamacionModel(
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
        fechaServicio: json["fechaServicio"] == null
            ? null
            : DateTime.parse(json["fechaServicio"]),
        // medicoCentroMedicoAseguradora: json["medicoCentroMedicoAseguradora"],
        medicoCentroMedicoAseguradora:
            json["medicoCentroMedicoAseguradora"] == null
                ? null
                : MedicoCentroMedicoAseguradora.fromJson(
                    json["medicoCentroMedicoAseguradora"]),
        tipoAdm: json["tipoAdm"],
        imagenId: json["imagenId"],
        padecimientoDiagnostico: json["padecimientoDiagnostico"],
        infoAdicional: json["infoAdicional"],
        estado: json["estado"],
        clientePoliza: json["clientePoliza"] == null
            ? null
            : ClientePoliza.fromJson(json["clientePoliza"]),
        caso: json["caso"] == null ? null : CasoResponse.fromJson(json["caso"]),
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "codigo": codigo,
        "fechaServicio":
            "${fechaServicio!.year.toString().padLeft(4, '0')}-${fechaServicio!.month.toString().padLeft(2, '0')}-${fechaServicio!.day.toString().padLeft(2, '0')}",
        "medicoCentroMedicoAseguradora":
            medicoCentroMedicoAseguradora?.toJson(),
        "tipoAdm": tipoAdm,
        "imagenId": imagenId,
        "padecimientoDiagnostico": padecimientoDiagnostico,
        "infoAdicional": infoAdicional,
        "estado": estado,
        "clientePoliza": clientePoliza?.toJson(),
        "caso": caso?.toJson(),
      };
}
