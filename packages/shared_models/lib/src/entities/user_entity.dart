import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:shared_models/shared_models.dart';

class User extends Equatable {
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
  final Direccion? direccion;
  final String? estado;
  final Rol? rol;
  final int? rolId; // para actualizar solo el ID del rol
  final String? token;
  final DateTime? fechaNacimiento;
  final String? lugarNacimiento;
  final String? lugarResidencia;

  const User({
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
    this.rolId,
    this.token,
    this.fechaNacimiento,
    this.lugarNacimiento,
    this.lugarResidencia,
  });

  User copyWith({
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    int? id,
    String? nombres,
    String? nombresDos,
    String? apellidos,
    String? apellidosDos,
    String? correoElectronico,
    String? numeroTelefono,
    String? nombreUsuario,
    String? contrasenia,
    String? urlImagen,
    Direccion? direccion,
    String? estado,
    Rol? rol,
    int? rolId, // para actualizar solo el ID del rol
    String? token,
    DateTime? fechaNacimiento,
    String? lugarNacimiento,
    String? lugarResidencia,
  }) {
    return User(
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      id: id ?? this.id,
      nombres: nombres ?? this.nombres,
      nombresDos: nombresDos ?? this.nombresDos,
      apellidos: apellidos ?? this.apellidos,
      apellidosDos: apellidosDos ?? this.apellidosDos,
      correoElectronico: correoElectronico ?? this.correoElectronico,
      numeroTelefono: numeroTelefono ?? this.numeroTelefono,
      nombreUsuario: nombreUsuario ?? this.nombreUsuario,
      contrasenia: contrasenia ?? this.contrasenia,
      urlImagen: urlImagen ?? this.urlImagen,
      direccion: direccion ?? this.direccion,
      estado: estado ?? this.estado,
      rol: rol ?? this.rol,
      rolId: rolId ?? this.rolId,
      token: token ?? this.token,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      lugarNacimiento: lugarNacimiento ?? this.lugarNacimiento,
      lugarResidencia: lugarResidencia ?? this.lugarResidencia,
// Nuevo campo
    );
  }

  // Factory constructor que toma UsuarioResponse y un token
  factory User.fromUsuarioResponse(UserResponse response, String token) {
    return User(
      createdBy: response.createdBy,
      createdDate: response.createdDate,
      lastModifiedBy: response.lastModifiedBy,
      lastModifiedDate: response.lastModifiedDate,
      id: response.id,
      nombres: response.nombres,
      nombresDos: response.nombresDos,
      apellidos: response.apellidos,
      apellidosDos: response.apellidosDos,
      correoElectronico: response.correoElectronico,
      numeroTelefono: response.numeroTelefono,
      nombreUsuario: response.nombreUsuario,
      contrasenia: response.contrasenia,
      urlImagen: response.urlImagen,
      direccion: response.direccion != null
          ? Direccion.fromJson(response.direccion!.toJson())
          : null,
      estado: response.estado,
      token: token,
      rol: response.rol != null ? Rol.fromJson(response.rol!.toJson()) : null,
      rolId: response.rol?.id,
      fechaNacimiento: response.fechaNacimiento,
      lugarNacimiento: response.lugarNacimiento,
      lugarResidencia: response.lugarResidencia,
    );
  }

  // Método para convertir el objeto User a JSON
  Map<String, dynamic> toJson() {
    return {
      'createdBy': createdBy,
      'createdDate': createdDate?.toIso8601String(),
      'lastModifiedBy': lastModifiedBy,
      'lastModifiedDate': lastModifiedDate?.toIso8601String(),
      'id': id,
      'nombres': nombres,
      'nombresDos': nombresDos,
      'apellidos': apellidos,
      'apellidosDos': apellidosDos,
      'correoElectronico': correoElectronico,
      'numeroTelefono': numeroTelefono,
      'nombreUsuario': nombreUsuario,
      'contrasenia': contrasenia,
      'urlImagen': urlImagen,
      'direccion': direccion?.toJson(),
      'estado': estado,
      'rol': rol?.toJson(),
      'rolId': rolId,
      'token': token,
      'fechaNacimiento': fechaNacimiento?.toIso8601String(),
      'lugarNacimiento': lugarNacimiento,
      'lugarResidencia': lugarResidencia,
    };
  }

  // Factory constructor para crear un User desde JSON
  factory User.fromJson(Map<String, dynamic> json) {
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
      nombresDos: json['nombresDos'] as String?,
      apellidos: json['apellidos'] as String?,
      apellidosDos: json['apellidosDos'] as String?,
      correoElectronico: json['correoElectronico'] as String?,
      numeroTelefono: json['numeroTelefono'] as String?,
      nombreUsuario: json['nombreUsuario'] as String?,
      contrasenia: json['contrasenia'] as String?,
      urlImagen: json['urlImagen'] as String?,
      direccion: json['direccion'] != null
          ? Direccion.fromJson(json['direccion'])
          : null,
      estado: json['estado'] as String?,
      rol: json['rol'] != null ? Rol.fromJson(json['rol']) : null,
      token: json['token'] as String?,
      fechaNacimiento: json['fechaNacimiento'] != null
          ? DateTime.parse(json['fechaNacimiento'] as String)
          : null,
      lugarNacimiento: json['lugarNacimiento'],
      lugarResidencia: json['lugarResidencia'],
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

  String formatFecha(DateTime? fecha) {
    if (fecha == null) {
      return '-';
    } else {
      final DateFormat formatter =
          DateFormat('dd \'de\' MMMM \'del\' yyyy', 'es_ES');
      return formatter.format(fecha);
    }
  }

  // Ejemplo de uso:
  String get formattedFechaNacimiento => formatFecha(fechaNacimiento);
  String get formattedCreatedDate => formatFecha(createdDate);
  String get formattedLastModifiedDate => formatFecha(lastModifiedDate);

  bool get isAddressComplete => direccion?.isComplete ?? false;

  /// Getter para verificar que todos los campos relevantes no sean null
  bool get hasAllRequiredFields =>
      nombres != null &&
      apellidos != null &&
      correoElectronico != null &&
      nombreUsuario != null &&
      numeroTelefono != null &&
      fechaNacimiento != null &&
      lugarNacimiento != null &&
      lugarResidencia != null;
  @override
  List<Object?> get props => [
        createdBy,
        createdDate,
        lastModifiedBy,
        lastModifiedDate,
        id,
        nombres,
        nombresDos,
        apellidos,
        apellidosDos,
        correoElectronico,
        numeroTelefono,
        nombreUsuario,
        contrasenia,
        urlImagen,
        direccion,
        estado,
        rol,
        rolId,
        token,
        fechaNacimiento,
        lugarNacimiento,
        lugarResidencia,
      ];
}