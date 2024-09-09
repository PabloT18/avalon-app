import 'package:shared_models/shared_models.dart';

class UsrAgenteResponse extends UsrAgente {
  const UsrAgenteResponse({
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
    super.contraseniaTemporal,
    super.numeroTelefono,
    super.nombreUsuario,
    super.contraseniaTemporalModificada,
    super.urlImagen,
    super.direccion,
    super.estado,
    super.numeroIdentificacion,
    super.tipoIdentificacion,
    super.rol,
    super.broker,
  });

  factory UsrAgenteResponse.fromJson(Map<String, dynamic> json) =>
      UsrAgenteResponse(
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
        contraseniaTemporal: json["contraseniaTemporal"],
        numeroTelefono: json["numeroTelefono"],
        nombreUsuario: json["nombreUsuario"],
        contraseniaTemporalModificada: json["contraseniaTemporalModificada"],
        urlImagen: json["urlImagen"],
        direccion: json["direccion"] == null
            ? null
            : DireccionModel.fromJson(json["direccion"]),
        estado: json["estado"],
        numeroIdentificacion: json["numeroIdentificacion"],
        tipoIdentificacion: json["tipoIdentificacion"],
        rol: json["rol"] == null ? null : RolModel.fromJson(json["rol"]),
        broker: json["broker"] == null
            ? null
            : BrokerResponse.fromJson(json["broker"]),
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
        "contraseniaTemporal": contraseniaTemporal,
        "numeroTelefono": numeroTelefono,
        "nombreUsuario": nombreUsuario,
        "contraseniaTemporalModificada": contraseniaTemporalModificada,
        "urlImagen": urlImagen,
        "direccion": direccion?.toJson(),
        "estado": estado,
        "numeroIdentificacion": numeroIdentificacion,
        "tipoIdentificacion": tipoIdentificacion,
        "rol": rol?.toJson(),
        "broker": broker?.toJson(),
      };
}
