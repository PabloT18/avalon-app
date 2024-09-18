import 'package:shared_models/src/models/poliza_response.dart';
import 'package:shared_models/src/models/usr_agente_response.dart';
import 'package:shared_models/src/models/usr_asesor_response.dart';

import '../entities/cliente_poliza_entity.dart';
import 'empresa_response.dart';
import 'usr_cliente_response.dart';

class ClientePolizaResponse extends ClientePoliza {
  const ClientePolizaResponse({
    super.createdBy,
    super.createdDate,
    super.lastModifiedBy,
    super.lastModifiedDate,
    super.id,
    super.codigo,
    super.numeroCertificado,
    super.empresa,
    super.cliente,
    super.asesor,
    super.agente,
    super.poliza,
    super.fechaInicio,
    super.fechaFin,
    super.estado,
    super.parentesco,
    super.tipo,
    super.titular,
    super.displayName,
  });

  factory ClientePolizaResponse.fromJson(Map<String, dynamic> json) =>
      ClientePolizaResponse(
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
        empresa: json["empresa"] == null
            ? null
            : EmpresaResponse.fromJson(json["empresa"]),
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
            : ClientePolizaResponse.fromJson(json["titular"]),
        displayName: json["displayName"],
      );

  @override
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
}
