import 'package:intl/intl.dart';

import 'package:authentication_repository/src/models/user_response.dart';
import 'package:equatable/equatable.dart';

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
    this.token,
    this.fechaNacimiento,
    this.lugarNacimiento,
    this.lugarResidencia,
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
      'token': token,
      'fechaNacimiento': fechaNacimiento,
      'lugarNacimiento': lugarNacimiento,
      'lugarResidencia': lugarResidencia,
    };
  }

  // Factory constructor para crear un User desde JSON
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
      nombresDos: json['nombresDos'] as String?,
      apellidos: json['apellidos'] as String?,
      apellidosDos: json['apellidosDos'] as String?,
      correoElectronico: json['correoElectronico'] as String?,
      numeroTelefono: json['numeroTelefono'] as String?,
      nombreUsuario: json['nombreUsuario'] as String?,
      contrasenia: json['contrasenia'] as String?,
      urlImagen: json['urlImagen'] as String?,
      direccion: json['direccion'] != null
          ? Direccion.fromJson(json['direccion'] as Map)
          : null,
      estado: json['estado'] as String?,
      rol: json['rol'] != null ? Rol.fromJson(json['rol'] as Map) : null,
      token: json['token'] as String?,
      fechaNacimiento: json['fechaNacimiento'],
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
        token,
        fechaNacimiento,
        lugarNacimiento,
        lugarResidencia,
      ];
}

class Direccion {
  final String? direccionUno;
  final String? direccionDos;
  final String? ciudad;
  final String? codigoPostal;
  final Pais? pais;
  final Estado? state;

  Direccion({
    this.direccionUno,
    this.direccionDos,
    this.ciudad,
    this.codigoPostal,
    this.pais,
    this.state,
  });

  factory Direccion.fromJson(Map json) => Direccion(
        direccionUno: json["direccionUno"] as String?,
        direccionDos: json["direccionDos"] as String?,
        ciudad: json["ciudad"] as String?,
        codigoPostal: json["codigoPostal"] as String?,
        pais: json["pais"] != null ? Pais.fromJson(json["pais"] as Map) : null,
        state: json["state"] != null
            ? Estado.fromJson(json["state"] as Map)
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

  bool get isComplete {
    return direccionUno != null &&
        ciudad != null &&
        codigoPostal != null &&
        state != null &&
        state!.nombre != null &&
        state!.pais != null &&
        state!.pais!.nombre != null;
  }
}

class Pais {
  final int? id;
  final String? nombre;

  Pais({
    this.id,
    this.nombre,
  });

  factory Pais.fromJson(Map json) => Pais(
        id: json["id"] as int?,
        nombre: json["nombre"] as String?,
      );

  Map toJson() => {
        "id": id,
        "nombre": nombre,
      };
}

class Estado {
  final int? id;
  final String? nombre;
  final Pais? pais;

  Estado({
    this.id,
    this.nombre,
    this.pais,
  });

  factory Estado.fromJson(Map json) => Estado(
        id: json["id"] as int?,
        nombre: json["nombre"] as String?,
        pais: json["pais"] != null ? Pais.fromJson(json["pais"] as Map) : null,
      );

  Map toJson() => {
        "id": id,
        "nombre": nombre,
        "pais": pais?.toJson(),
      };

  String? get estadoNombreCompleto => '$nombre, ${pais?.nombre}';
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
        id: json["id"] as int?,
        nombre: json["nombre"] as String?,
        codigo: json["codigo"] as String?,
      );

  Map toJson() => {
        "id": id,
        "nombre": nombre,
        "codigo": codigo,
      };
}
