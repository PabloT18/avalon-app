import 'package:equatable/equatable.dart';
import 'package:shared_models/shared_models.dart';

class ClientePoliza extends Equatable {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? codigo;
  final String? numeroCertificado;
  final String? empresa;
  final UsrCliente? cliente;
  final UsrAsesor? asesor;
  final UsrAgente? agente;
  final Poliza? poliza;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final String? estado;
  final String? parentesco;
  final String? tipo;
  final ClientePoliza? titular;
  final String? displayName;

  const ClientePoliza({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.codigo,
    this.numeroCertificado,
    this.empresa,
    this.cliente,
    this.asesor,
    this.agente,
    this.poliza,
    this.fechaInicio,
    this.fechaFin,
    this.estado,
    this.parentesco,
    this.tipo,
    this.titular,
    this.displayName,
  });

  factory ClientePoliza.fromJson(Map<String, dynamic> json) => ClientePoliza(
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
        numeroCertificado: json["numeroCertificado"],
        empresa: json["empresa"],
        cliente: json["cliente"] == null
            ? null
            : UsrClienteResponse.fromJson(json["cliente"]),
        asesor: json["asesor"] == null
            ? null
            : UsrAsesorResponse.fromJson(json["asesor"]),
        agente: json["agente"] == null
            ? null
            : UsrAgenteResponse.fromJson(json["agente"]),
        poliza: json["poliza"] == null
            ? null
            : PolizaResponse.fromJson(json["poliza"]),
        fechaInicio: json["fechaInicio"] == null
            ? null
            : DateTime.parse(json["fechaInicio"]),
        fechaFin:
            json["fechaFin"] == null ? null : DateTime.parse(json["fechaFin"]),
        estado: json["estado"],
        parentesco: json["parentesco"],
        tipo: json["tipo"],
        titular: json["titular"] == null
            ? null
            : ClientePoliza.fromJson(json["titular"]),
        displayName: json["displayName"],
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "codigo": codigo,
        "numeroCertificado": numeroCertificado,
        "empresa": empresa,
        "cliente": cliente?.toJson(),
        "asesor": asesor?.toJson(),
        "agente": agente?.toJson(),
        "poliza": poliza?.toJson(),
        "fechaInicio":
            "${fechaInicio!.year.toString().padLeft(4, '0')}-${fechaInicio!.month.toString().padLeft(2, '0')}-${fechaInicio!.day.toString().padLeft(2, '0')}",
        "fechaFin":
            "${fechaFin!.year.toString().padLeft(4, '0')}-${fechaFin!.month.toString().padLeft(2, '0')}-${fechaFin!.day.toString().padLeft(2, '0')}",
        "estado": estado,
        "parentesco": parentesco,
        "tipo": tipo,
        "titular": titular?.toJson(),
        "displayName": displayName,
      };

  @override
  List<Object?> get props => [
        createdBy,
        createdDate,
        lastModifiedBy,
        lastModifiedDate,
        id,
        codigo,
        numeroCertificado,
        empresa,
        cliente,
        asesor,
        agente,
        poliza,
        fechaInicio,
        fechaFin,
        estado,
        parentesco,
        tipo,
        titular,
        displayName,
      ];
}
