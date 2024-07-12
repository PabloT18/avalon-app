import 'dart:convert';

UserResponse usuarioResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String usuarioResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
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
  final String? nombreUsuario;
  final String? contrasenia;
  final String? urlImagen;
  final DireccionResponse? direccion;
  final String? estado;
  final RolResponse? rol;
  final DateTime? fechaNacimiento;
  final String? lugarNacimiento;
  final String? lugarResidencia;

  UserResponse({
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
    this.nombreUsuario,
    this.contrasenia,
    this.urlImagen,
    this.direccion,
    this.estado,
    this.rol,
    this.fechaNacimiento,
    this.lugarNacimiento,
    this.lugarResidencia,
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
            : DireccionResponse.fromJson(json["direccion"]),
        estado: json["estado"],
        rol: json["rol"] == null ? null : RolResponse.fromJson(json["rol"]),
        fechaNacimiento: json["fechaNacimiento"] == null
            ? null
            : DateTime.parse(json["fechaNacimiento"]),
        lugarNacimiento: json["lugarNacimiento"],
        lugarResidencia: json["lugarResidencia"],
      );

  Map toJson() => {
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

class DireccionResponse {
  final String? direccionUno;
  final String? direccionDos;
  final String? ciudad;
  final String? codigoPostal;
  final PaisResponse? pais;
  final StateResponse? state;

  DireccionResponse({
    this.direccionUno,
    this.direccionDos,
    this.ciudad,
    this.codigoPostal,
    this.pais,
    this.state,
  });

  factory DireccionResponse.fromJson(Map json) => DireccionResponse(
        direccionUno: json["direccionUno"] as String?,
        direccionDos: json["direccionDos"] as String?,
        ciudad: json["ciudad"] as String?,
        codigoPostal: json["codigoPostal"] as String?,
        pais: json["pais"] != null
            ? PaisResponse.fromJson(json["pais"] as Map)
            : null,
        state: json["state"] != null
            ? StateResponse.fromJson(json["state"] as Map)
            : null,
      );

  Map toJson() => {
        "direccionUno": direccionUno,
        "direccionDos": direccionDos,
        "ciudad": ciudad,
        "codigoPostal": codigoPostal,
        "pais": pais?.toJson(),
        "state": state?.toJson(),
      };
}

class PaisResponse {
  final int? id;
  final String? nombre;

  PaisResponse({
    this.id,
    this.nombre,
  });

  factory PaisResponse.fromJson(Map json) => PaisResponse(
        id: json["id"] as int?,
        nombre: json["nombre"] as String?,
      );

  Map toJson() => {
        "id": id,
        "nombre": nombre,
      };
}

class StateResponse {
  final int? id;
  final String? nombre;
  final PaisResponse? pais;

  StateResponse({
    this.id,
    this.nombre,
    this.pais,
  });

  factory StateResponse.fromJson(Map json) => StateResponse(
        id: json["id"] as int?,
        nombre: json["nombre"] as String?,
        pais: json["pais"] != null
            ? PaisResponse.fromJson(json["pais"] as Map)
            : null,
      );

  Map toJson() => {
        "id": id,
        "nombre": nombre,
        "pais": pais?.toJson(),
      };
}

class RolResponse {
  final int? id;
  final String? nombre;
  final String? codigo;

  RolResponse({
    this.id,
    this.nombre,
    this.codigo,
  });

  factory RolResponse.fromJson(Map json) => RolResponse(
        id: json["id"],
        nombre: json["nombre"],
        codigo: json["codigo"],
      );

  Map toJson() => {
        "id": id,
        "nombre": nombre,
        "codigo": codigo,
      };
}
