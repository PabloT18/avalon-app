import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:shared_models/shared_models.dart';

class ClienteMembresia extends Equatable {
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
  final DateTime? fechaNacimiento;
  final String? lugarNacimiento;
  final String? lugarResidencia;

  const ClienteMembresia({
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
  String get fullName => '$nombres $apellidos';
  String get fullNameLN => ' $apellidos $apellidosDos $nombres';

  String get fullNameUpperCase => '$nombres $apellidos'.toUpperCase();

  String get fechaNacimientoFormat => formatFecha(fechaNacimiento);

  String formatFecha(DateTime? fecha) {
    if (fecha == null) {
      return '-';
    } else {
      final DateFormat formatter =
          DateFormat('dd \'de\' MMMM \'del\' yyyy', 'es_ES');
      return formatter.format(fecha);
    }
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
        numeroTelefono,
        nombreUsuario,
        contrasenia,
        urlImagen,
        direccion,
        estado,
        rol,
        fechaNacimiento,
        lugarNacimiento,
        lugarResidencia,
      ];
}
