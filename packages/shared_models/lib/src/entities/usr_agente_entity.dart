import 'package:intl/intl.dart';
import 'package:shared_models/shared_models.dart';

class UsrAgente extends User {
  final Broker? broker;

  const UsrAgente({
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
    super.rolId,
    super.token,
    this.broker,
  });

  factory UsrAgente.fromJson(Map<String, dynamic> json) => UsrAgente(
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
        broker: json["broker"] == null ? null : Broker.fromJson(json["broker"]),
      );

  factory UsrAgente.fromUsuarioResponse(
      UsrAgenteResponse response, String token) {
    return UsrAgente(
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
      broker: response.broker != null
          ? Broker.fromJson(response.broker!.toJson())
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      "broker": broker?.toJson(),
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
  String get fullName => '$nombres $apellidos';

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

  String get formattedCreatedDate => formatFecha(createdDate);
  String get formattedLastModifiedDate => formatFecha(lastModifiedDate);

  @override
  bool get isAddressComplete => direccion?.isComplete ?? false;

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
        broker,
      ];
}
