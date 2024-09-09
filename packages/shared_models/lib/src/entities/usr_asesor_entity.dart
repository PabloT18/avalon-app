import 'package:equatable/equatable.dart';
import 'package:shared_models/shared_models.dart';

class UsrAsesor extends Equatable {
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
  final String? contraseniaTemporal;
  final String? numeroTelefono;
  final String? nombreUsuario;
  final bool? contraseniaTemporalModificada;
  final String? urlImagen;
  final Direccion? direccion;
  final String? estado;
  final String? numeroIdentificacion;
  final String? tipoIdentificacion;
  final Rol? rol;

  const UsrAsesor({
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
    this.contraseniaTemporal,
    this.numeroTelefono,
    this.nombreUsuario,
    this.contraseniaTemporalModificada,
    this.urlImagen,
    this.direccion,
    this.estado,
    this.numeroIdentificacion,
    this.tipoIdentificacion,
    this.rol,
  });

  factory UsrAsesor.fromJson(Map<String, dynamic> json) => UsrAsesor(
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
      );

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
      };

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
      ];
}
