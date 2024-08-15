import 'package:shared_models/shared_models.dart';

class UserResponse extends User {
  const UserResponse({
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

  factory UserResponse.fromJson(Map json) => UserResponse(
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
            : DireccionModel.fromJson(json["direccion"]),
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
