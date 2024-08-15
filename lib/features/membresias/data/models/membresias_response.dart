import 'dart:convert';

import 'package:shared_models/shared_models.dart';

import '../../domain/models/membresia_entities.dart';

MembresiasResponse membresiasResponseFromJson(String str) =>
    MembresiasResponse.fromJson(json.decode(str));

String membresiasResponseToJson(MembresiasResponse membresiaResponse) =>
    json.encode(membresiaResponse.toJson());

class MembresiasResponse {
  final List<MembresiaRegisterResponse>? membresiaResponse;
  final int? totalRecords;

  MembresiasResponse({
    this.membresiaResponse,
    this.totalRecords,
  });

  factory MembresiasResponse.fromJson(Map<String, dynamic> json) =>
      MembresiasResponse(
        membresiaResponse: json["data"] == null
            ? []
            : List<MembresiaRegisterResponse>.from(json["data"]!
                .map((x) => MembresiaRegisterResponse.fromJson(x))),
        totalRecords: json["totalRecords"],
      );

  Map<String, dynamic> toJson() => {
        "data": membresiaResponse == null
            ? []
            : List<dynamic>.from(membresiaResponse!.map((x) => x.toJson())),
        "totalRecords": totalRecords,
      };
}

class MembresiaRegisterResponse extends MembresiaRegister {
  const MembresiaRegisterResponse({
    super.createdBy,
    super.createdDate,
    super.lastModifiedBy,
    super.lastModifiedDate,
    super.id,
    super.membresia,
    super.cliente,
    super.asesor,
    super.fechaInicio,
    super.fechaFin,
    super.estado,
  });

  factory MembresiaRegisterResponse.fromJson(Map<String, dynamic> json) =>
      MembresiaRegisterResponse(
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"] == null
            ? null
            : DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        membresia: json["membresia"] == null
            ? null
            : MembresiaResponse.fromJson(json["membresia"]),
        cliente: json["cliente"] == null
            ? null
            : ClienteResponse.fromJson(json["cliente"]),
        asesor: json["asesor"] == null
            ? null
            : AsesorResponse.fromJson(json["asesor"]),
        fechaInicio: json["fechaInicio"] == null
            ? null
            : DateTime.parse(json["fechaInicio"]),
        fechaFin:
            json["fechaFin"] == null ? null : DateTime.parse(json["fechaFin"]),
        estado: json["estado"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "membresia": membresia?.toJson(),
        "cliente": cliente?.toJson(),
        "asesor": asesor?.toJson(),
        "fechaInicio":
            "${fechaInicio!.year.toString().padLeft(4, '0')}-${fechaInicio!.month.toString().padLeft(2, '0')}-${fechaInicio!.day.toString().padLeft(2, '0')}",
        "fechaFin":
            "${fechaFin!.year.toString().padLeft(4, '0')}-${fechaFin!.month.toString().padLeft(2, '0')}-${fechaFin!.day.toString().padLeft(2, '0')}",
        "estado": estado,
      };
}

class AsesorResponse extends AsesorMembresia {
  const AsesorResponse({
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
    super.nombreUsuario,
    super.contrasenia,
    super.urlImagen,
    super.direccion,
    super.estado,
    super.rol,
    super.fechaNacimiento,
    super.lugarNacimiento,
    super.lugarResidencia,
  });

  factory AsesorResponse.fromJson(Map<String, dynamic> json) => AsesorResponse(
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
        nombreUsuario: json["nombreUsuario"],
        contrasenia: json["contrasenia"],
        urlImagen: json["urlImagen"],
        direccion: json["direccion"],
        estado: json["estado"],
        rol: json["rol"] == null ? null : RolModel.fromJson(json["rol"]),
        fechaNacimiento: json["fechaNacimiento"] == null
            ? null
            : DateTime.parse(json["fechaNacimiento"]),
        lugarNacimiento: json["lugarNacimiento"],
        lugarResidencia: json["lugarResidencia"],
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
        "nombreUsuario": nombreUsuario,
        "contrasenia": contrasenia,
        "urlImagen": urlImagen,
        "direccion": direccion?.toJson(),
        "estado": estado,
        "rol": rol?.toJson(),
        "fechaNacimiento": fechaNacimiento,
        "lugarNacimiento": lugarNacimiento,
        "lugarResidencia": lugarResidencia,
      };
}

class ClienteResponse extends ClienteMembresia {
  const ClienteResponse({
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
    super.nombreUsuario,
    super.contrasenia,
    super.urlImagen,
    super.direccion,
    super.estado,
    super.rol,
    super.fechaNacimiento,
    super.lugarNacimiento,
    super.lugarResidencia,
  });

  factory ClienteResponse.fromJson(Map<String, dynamic> json) =>
      ClienteResponse(
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
        nombreUsuario: json["nombreUsuario"],
        contrasenia: json["contrasenia"],
        urlImagen: json["urlImagen"],
        direccion: json["direccion"] == null
            ? null
            : DireccionResponse.fromJson(json["direccion"]),
        estado: json["estado"],
        rol: json["rol"] == null ? null : RolModel.fromJson(json["rol"]),
        fechaNacimiento: json["fechaNacimiento"] == null
            ? null
            : DateTime.parse(json["fechaNacimiento"]),
        lugarNacimiento: json["lugarNacimiento"],
        lugarResidencia: json["lugarResidencia"],
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
        "nombreUsuario": nombreUsuario,
        "contrasenia": contrasenia,
        "urlImagen": urlImagen,
        "direccion": direccion?.toJson(),
        "estado": estado,
        "rol": rol?.toJson(),
        "fechaNacimiento": fechaNacimiento,
        "lugarNacimiento": lugarNacimiento,
        "lugarResidencia": lugarResidencia,
      };
}

class MembresiaResponse extends Membresia {
  const MembresiaResponse({
    super.createdBy,
    super.createdDate,
    super.lastModifiedBy,
    super.lastModifiedDate,
    super.id,
    super.nombres,
    super.detalle,
    super.estado,
    super.vigenciaMeses,
  });

  factory MembresiaResponse.fromJson(Map<String, dynamic> json) =>
      MembresiaResponse(
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
        detalle: json["detalle"],
        estado: json["estado"],
        vigenciaMeses: json["vigenciaMeses"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "nombres": nombres,
        "detalle": detalle,
        "estado": estado,
        "vigenciaMeses": vigenciaMeses,
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
        pais: json["pais"] == null ? null : PaisModel.fromJson(json["pais"]),
        estado:
            json["state"] == null ? null : EstadoModel.fromJson(json["state"]),
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
