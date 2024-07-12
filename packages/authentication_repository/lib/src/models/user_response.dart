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
  final String? apellidos;
  final dynamic fechaNacimiento;
  final dynamic lugarNacimiento;
  final dynamic lugarResidencia;
  final String? correoElectronico;
  final String? numeroTelefono;
  final String? nombreUsuario;
  final String? contrasenia;
  final dynamic urlImagen;
  final String? estado;
  final RolResponse? rol;

  UserResponse({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.nombres,
    this.apellidos,
    this.fechaNacimiento,
    this.lugarNacimiento,
    this.lugarResidencia,
    this.correoElectronico,
    this.numeroTelefono,
    this.nombreUsuario,
    this.contrasenia,
    this.urlImagen,
    this.estado,
    this.rol,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
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
        apellidos: json["apellidos"],
        fechaNacimiento: json["fechaNacimiento"],
        lugarNacimiento: json["lugarNacimiento"],
        lugarResidencia: json["lugarResidencia"],
        correoElectronico: json["correoElectronico"],
        numeroTelefono: json["numeroTelefono"],
        nombreUsuario: json["nombreUsuario"],
        contrasenia: json["contrasenia"],
        urlImagen: json["urlImagen"],
        estado: json["estado"],
        rol: json["rol"] == null ? null : RolResponse.fromJson(json["rol"]),
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "nombres": nombres,
        "apellidos": apellidos,
        "fechaNacimiento": fechaNacimiento,
        "lugarNacimiento": lugarNacimiento,
        "lugarResidencia": lugarResidencia,
        "correoElectronico": correoElectronico,
        "numeroTelefono": numeroTelefono,
        "nombreUsuario": nombreUsuario,
        "contrasenia": contrasenia,
        "urlImagen": urlImagen,
        "estado": estado,
        "rol": rol?.toJson(),
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

  factory RolResponse.fromJson(Map<String, dynamic> json) => RolResponse(
        id: json["id"],
        nombre: json["nombre"],
        codigo: json["codigo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "codigo": codigo,
      };
}
