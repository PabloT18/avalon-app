// To parse this JSON data, do
//
//     final citasMedicasResponse = citasMedicasResponseFromJson(jsonString);

import 'dart:convert';

import 'package:avalon_app/features/casos/casos.dart';
import 'package:avalon_app/features/casos/data/models/casos_response.dart';
import 'package:shared_models/shared_models.dart';

import 'requisitos_adicionales_entity.dart';

CitasMedicasResponse citasMedicasResponseFromJson(String str) =>
    CitasMedicasResponse.fromJson(json.decode(str));

String citasMedicasResponseToJson(CitasMedicasResponse data) =>
    json.encode(data.toJson());

class CitasMedicasResponse {
  final List<CitaMedica>? data;
  final int? totalRecords;

  CitasMedicasResponse({
    this.data,
    this.totalRecords,
  });

  factory CitasMedicasResponse.fromJson(Map<String, dynamic> json) =>
      CitasMedicasResponse(
        data: json["data"] == null
            ? []
            : List<CitaMedica>.from(
                json["data"]!.map((x) => CitaMedica.fromJson(x))),
        totalRecords: json["totalRecords"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalRecords": totalRecords,
      };
}

class CitaMedica {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? codigo;
  final String? ciudadPreferencia;
  final String? padecimiento;
  final String? informacionAdicional;
  final String? otrosRequisitos;
  final CasoEntity? caso;
  final ClientePoliza? clientePoliza;
  final Direccion? direccion;

  final String? tipoCitaMedica;
  final DateTime? fechaTentativa;
  final DateTime? fechaTentativaHasta;
  final int? imagenId;
  final String? estado;
  final MedicoCentroMedicoAseguradora? medicoCentroMedicoAseguradora;
  final RequisitosAdicionales? requisitosAdicionales;

  CitaMedica({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.codigo,
    this.ciudadPreferencia,
    this.padecimiento,
    this.informacionAdicional,
    this.otrosRequisitos,
    this.direccion,
    this.tipoCitaMedica,
    this.fechaTentativa,
    this.fechaTentativaHasta,
    this.imagenId,
    this.estado,
    this.caso,
    this.clientePoliza,
    this.medicoCentroMedicoAseguradora,
    this.requisitosAdicionales,
  });

  factory CitaMedica.fromJson(Map<String, dynamic> json) => CitaMedica(
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
        ciudadPreferencia: json["ciudadPreferencia"],
        padecimiento: json["padecimiento"],
        informacionAdicional: json["informacionAdicional"],
        otrosRequisitos: json["otrosRequisitos"],
        direccion: json["direccion"] == null
            ? null
            : Direccion.fromJson(json["direccion"]),
        tipoCitaMedica: json["tipoCitaMedica"],
        fechaTentativa: json["fechaTentativa"] == null
            ? null
            : DateTime.parse(json["fechaTentativa"]),
        imagenId: json["imagenId"],
        estado: json["estado"],
        caso: json["caso"] == null ? null : CasoResponse.fromJson(json["caso"]),
        clientePoliza: json["clientePoliza"] == null
            ? null
            : ClientePolizaResponse.fromJson(
                json["clientePoliza"] as Map<String, dynamic>),
        medicoCentroMedicoAseguradora:
            json["medicoCentroMedicoAseguradora"] == null
                ? null
                : MedicoCentroMedicoAseguradora.fromJson(
                    json["medicoCentroMedicoAseguradora"]),
        requisitosAdicionales: json["requisitosAdicionales"] == null
            ? null
            : RequisitosAdicionales.fromJson(json["requisitosAdicionales"]),
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "codigo": codigo,
        "ciudadPreferencia": ciudadPreferencia,
        "padecimiento": padecimiento,
        "informacionAdicional": informacionAdicional,
        "otrosRequisitos": otrosRequisitos,
        "tipoCitaMedica": tipoCitaMedica,
        "fechaTentativa":
            "${fechaTentativa!.year.toString().padLeft(4, '0')}-${fechaTentativa!.month.toString().padLeft(2, '0')}-${fechaTentativa!.day.toString().padLeft(2, '0')}",
        "fechaTentativaHasta":
            "${fechaTentativaHasta!.year.toString().padLeft(4, '0')}-${fechaTentativaHasta!.month.toString().padLeft(2, '0')}-${fechaTentativaHasta!.day.toString().padLeft(2, '0')}",
        "imagenId": imagenId,
        "estado": estado,
        "caso": caso?.toJson(),
        "clientePoliza": clientePoliza?.toJson(),
        "medicoCentroMedicoAseguradora":
            medicoCentroMedicoAseguradora?.toJson(),
        "requisitosAdicionales": requisitosAdicionales?.toJson(),
      };

  Map<String, dynamic> toJsonCreate() {
    if (medicoCentroMedicoAseguradora == null) {
      return {
        "tipoCitaMedica": tipoCitaMedica,
        "fechaTentativa":
            "${fechaTentativa!.year.toString().padLeft(4, '0')}-${fechaTentativa!.month.toString().padLeft(2, '0')}-${fechaTentativa!.day.toString().padLeft(2, '0')}",
        "fechaTentativaHasta":
            "${fechaTentativaHasta!.year.toString().padLeft(4, '0')}-${fechaTentativaHasta!.month.toString().padLeft(2, '0')}-${fechaTentativaHasta!.day.toString().padLeft(2, '0')}",
        "ciudadPreferencia": ciudadPreferencia,
        "clientePolizaId": clientePoliza?.id,
        "casoId": caso?.id,
        "padecimiento": padecimiento,
        "informacionAdicional": informacionAdicional,
        "otrosRequisitos": otrosRequisitos,
        "requisitosAdicionales": requisitosAdicionales?.toJson(),
        "direccion": direccion?.toJson(),
      };
    }
    return {
      "tipoCitaMedica": tipoCitaMedica,
      "fechaTentativa":
          "${fechaTentativa!.year.toString().padLeft(4, '0')}-${fechaTentativa!.month.toString().padLeft(2, '0')}-${fechaTentativa!.day.toString().padLeft(2, '0')}",
      "fechaTentativaHasta":
          "${fechaTentativaHasta!.year.toString().padLeft(4, '0')}-${fechaTentativaHasta!.month.toString().padLeft(2, '0')}-${fechaTentativaHasta!.day.toString().padLeft(2, '0')}",
      "ciudadPreferencia": ciudadPreferencia,
      "medicoCentroMedicoAseguradora": medicoCentroMedicoAseguradora?.id,
      "clientePolizaId": clientePoliza?.id,
      "direccion": direccion?.toJson(),
      "casoId": caso?.id,
      "padecimiento": padecimiento,
      "informacionAdicional": informacionAdicional,
      "otrosRequisitos": otrosRequisitos,
      "requisitosAdicionales": requisitosAdicionales?.toJson(),
    };
  }
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

class Aseguradora {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? nombre;
  final String? correoElectronico;
  final String? estado;
  final String? descripcion;
  final Direccion? direccion;

  Aseguradora({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.nombre,
    this.correoElectronico,
    this.estado,
    this.descripcion,
    this.direccion,
  });

  factory Aseguradora.fromJson(Map<String, dynamic> json) => Aseguradora(
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
        correoElectronico: json["correoElectronico"],
        estado: json["estado"],
        descripcion: json["descripcion"],
        direccion: json["direccion"] == null
            ? null
            : Direccion.fromJson(json["direccion"]),
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "nombre": nombre,
        "correoElectronico": correoElectronico,
        "estado": estado,
        "descripcion": descripcion,
        "direccion": direccion?.toJson(),
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
