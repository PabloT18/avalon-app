import 'package:intl/intl.dart';
import 'package:shared_models/shared_models.dart';

class UsrCliente extends User {
  final DateTime? fechaNacimiento;
  final String? lugarNacimiento;
  final String? lugarResidencia;

  const UsrCliente({
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
    super.token,
    super.rolId,
    this.fechaNacimiento,
    this.lugarNacimiento,
    this.lugarResidencia,
  });

  factory UsrCliente.fromJson(Map<String, dynamic> json) => UsrCliente(
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
            : Direccion.fromJson(json["direccion"]),
        estado: json["estado"],
        numeroIdentificacion: json["numeroIdentificacion"],
        tipoIdentificacion: json["tipoIdentificacion"],
        rol: json["rol"] == null ? null : Rol.fromJson(json["rol"]),
        token: json["token"],
        rolId: json["rolId"],
        fechaNacimiento: json["fechaNacimiento"] == null
            ? null
            : DateTime.parse(json["fechaNacimiento"]),
        lugarNacimiento: json["lugarNacimiento"],
        lugarResidencia: json["lugarResidencia"],
      );

  factory UsrCliente.fromUsuarioResponse(
      UsrClienteResponse response, String token) {
    return UsrCliente(
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
      urlImagen: response.urlImagen,
      direccion: response.direccion != null
          ? Direccion.fromJson(response.direccion!.toJson())
          : null,
      estado: response.estado,
      token: token,
      rol: response.rol != null ? Rol.fromJson(response.rol!.toJson()) : null,
      rolId: response.rol?.id,
      contraseniaTemporal: response.contraseniaTemporal,
      contraseniaTemporalModificada: response.contraseniaTemporalModificada,
      numeroIdentificacion: response.contraseniaTemporal,
      tipoIdentificacion: response.contraseniaTemporal,
      fechaNacimiento: response.fechaNacimiento,
      lugarNacimiento: response.lugarNacimiento,
      lugarResidencia: response.lugarResidencia,
    );
  }

  // @override
  // Map<String, dynamic> toJson() => {
  //       "createdBy": createdBy,
  //       "createdDate": createdDate?.toIso8601String(),
  //       "lastModifiedBy": lastModifiedBy,
  //       "lastModifiedDate": lastModifiedDate?.toIso8601String(),
  //       "id": id,
  //       "nombres": nombres,
  //       "nombresDos": nombresDos,
  //       "apellidos": apellidos,
  //       "apellidosDos": apellidosDos,
  //       "correoElectronico": correoElectronico,
  //       "contraseniaTemporal": contraseniaTemporal,
  //       "numeroTelefono": numeroTelefono,
  //       "nombreUsuario": nombreUsuario,
  //       "contraseniaTemporalModificada": contraseniaTemporalModificada,
  //       "urlImagen": urlImagen,
  //       "direccion": direccion?.toJson(),
  //       "estado": estado,
  //       "numeroIdentificacion": numeroIdentificacion,
  //       "tipoIdentificacion": tipoIdentificacion,
  //       "rol": rol?.toJson(),
  //       'rolId': rolId,
  //       'token': token,
  //       "fechaNacimiento":
  //           "${fechaNacimiento!.year.toString().padLeft(4, '0')}-${fechaNacimiento!.month.toString().padLeft(2, '0')}-${fechaNacimiento!.day.toString().padLeft(2, '0')}",
  //       "lugarNacimiento": lugarNacimiento,
  //       "lugarResidencia": lugarResidencia,
  //     };

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      "fechaNacimiento": fechaNacimiento == null
          ? null
          : "${fechaNacimiento!.year.toString().padLeft(4, '0')}-${fechaNacimiento!.month.toString().padLeft(2, '0')}-${fechaNacimiento!.day.toString().padLeft(2, '0')}",
      "lugarNacimiento": lugarNacimiento,
      "lugarResidencia": lugarResidencia,
    });
    return json;
  }

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: 0);

  /// Convenience getter to determine whether the current user is empty.
  @override
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  @override
  bool get isNotEmpty => this != User.empty;

  @override
  String get fullName => '$nombres $apellidos - $nombreUsuario';

  @override
  String get fullNameUpperCase => '$nombres $apellidos'.toUpperCase();

  @override
  UserRol get userRol {
    if (rol == null) {
      return UserRol.client;
    } else {
      switch (rol!.id) {
        case 1:
          return UserRol.admin;
        case 2:
          return UserRol.asesor;
        case 3:
          return UserRol.client;
        case 4:
          return UserRol.agente;
        default:
          return UserRol.client;
      }
    }
  }

  @override
  bool get isClient => userRol == UserRol.client;

  @override
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

  @override
  bool get isAddressComplete => direccion?.isComplete ?? false;

  @override
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
    String? contraseniaTemporal,
    bool? contraseniaTemporalModificada,
    String? numeroIdentificacion,
    String? tipoIdentificacion,
    DateTime? fechaNacimiento,
    String? lugarNacimiento,
    String? lugarResidencia,
  }) {
    return UsrCliente(
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
      urlImagen: urlImagen ?? this.urlImagen,
      direccion: direccion ?? this.direccion,
      estado: estado ?? this.estado,
      rol: rol ?? this.rol,
      rolId: rolId ?? this.rolId,
      token: token ?? this.token,
      contraseniaTemporal: contraseniaTemporal ?? this.contraseniaTemporal,
      contraseniaTemporalModificada:
          contraseniaTemporalModificada ?? this.contraseniaTemporalModificada,
      numeroIdentificacion: numeroIdentificacion ?? this.numeroIdentificacion,
      tipoIdentificacion: tipoIdentificacion ?? this.tipoIdentificacion,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      lugarNacimiento: lugarNacimiento ?? this.lugarNacimiento,
      lugarResidencia: lugarResidencia ?? this.lugarResidencia,
    );
  }

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
        contraseniaTemporal,
        numeroTelefono,
        nombreUsuario,
        contraseniaTemporalModificada,
        urlImagen,
        direccion,
        estado,
        numeroIdentificacion,
        tipoIdentificacion,
        rol,
        fechaNacimiento,
        lugarNacimiento,
        lugarResidencia,
      ];
}
