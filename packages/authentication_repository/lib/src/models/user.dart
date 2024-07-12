import 'package:authentication_repository/src/models/user_response.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? nombres;
  final String? apellidos;
  final dynamic fechaNacimiento;
  final dynamic lugarNacimiento;
  final String? lugarResidencia;
  final String? correoElectronico;
  final String? numeroTelefono;
  final String? nombreUsuario;
  final String? contrasenia;
  final String? urlImagen;
  final String? estado;
  final Rol? rol;
  final String? token;

  const User({
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
    this.token,
  });
// Factory constructor que toma UsuarioResponse y un token
  factory User.fromUsuarioResponse(UserResponse response, String token) {
    return User(
      createdBy: response.createdBy,
      createdDate: response.createdDate,
      lastModifiedBy: response.lastModifiedBy,
      lastModifiedDate: response.lastModifiedDate,
      id: response.id,
      nombres: response.nombres,
      apellidos: response.apellidos,
      fechaNacimiento: response.fechaNacimiento,
      lugarNacimiento: response.lugarNacimiento,
      lugarResidencia: response.lugarResidencia,
      correoElectronico: response.correoElectronico,
      numeroTelefono: response.numeroTelefono,
      nombreUsuario: response.nombreUsuario,
      contrasenia: response.contrasenia,
      urlImagen: response.urlImagen,
      estado: response.estado,
      token: token,
      rol: response.rol != null ? Rol.fromJson(response.rol!.toJson()) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'createdBy': createdBy,
      'createdDate': createdDate?.toIso8601String(),
      'lastModifiedBy': lastModifiedBy,
      'lastModifiedDate': lastModifiedDate?.toIso8601String(),
      'id': id,
      'nombres': nombres,
      'apellidos': apellidos,
      'fechaNacimiento': fechaNacimiento,
      'luygarNacimiento': lugarNacimiento,
      'lugarResidencia': lugarResidencia,
      'correoElectronico': correoElectronico,
      'numeroTelefono': numeroTelefono,
      'nombreUsuario': nombreUsuario,
      'contrasenia': contrasenia,
      'urlImagen': urlImagen,
      'estado': estado,
      'rol': rol?.toJson(),
      'token': token,
    };
  }

  factory User.fromJson(Map json) {
    return User(
      createdBy: json['createdBy'] as String?,
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'] as String)
          : null,
      lastModifiedBy: json['lastModifiedBy'] as String?,
      lastModifiedDate: json['lastModifiedDate'] != null
          ? DateTime.parse(json['lastModifiedDate'] as String)
          : null,
      id: json['id'] as int?,
      nombres: json['nombres'] as String?,
      apellidos: json['apellidos'] as String?,
      fechaNacimiento: json['fechaNacimiento'] != null
          ? DateTime.parse(json['fechaNacimiento'] as String)
          : null,
      lugarNacimiento: json['lugarNacimiento'] as String?,
      lugarResidencia: json['lugarResidencia'] as String?,
      correoElectronico: json['correoElectronico'] as String?,
      numeroTelefono: json['numeroTelefono'] as String?,
      nombreUsuario: json['nombreUsuario'] as String?,
      contrasenia: json['contrasenia'] as String?,
      urlImagen: json['urlImagen'] as String?,
      estado: json['estado'] as String?,
      rol: json['rol'] != null ? Rol.fromJson(json['rol'] as Map) : null,
      token: json['token'] as String?,
    );
  }

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: 0);

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  String get fullName => '$nombres $apellidos';

  String get fullNameUpperCase => '$nombres $apellidos'.toUpperCase();

  @override
  List<Object?> get props => [
        createdBy,
        createdDate,
        lastModifiedBy,
        lastModifiedDate,
        id,
        nombres,
        apellidos,
        fechaNacimiento,
        lugarNacimiento,
        lugarResidencia,
        correoElectronico,
        numeroTelefono,
        nombreUsuario,
        contrasenia,
        urlImagen,
        estado,
        rol,
      ];
}

class Rol {
  final int? id;
  final String? nombre;
  final String? codigo;

  Rol({
    this.id,
    this.nombre,
    this.codigo,
  });

  factory Rol.fromJson(Map json) => Rol(
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
