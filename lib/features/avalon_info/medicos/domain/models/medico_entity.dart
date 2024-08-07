import 'package:avalon_app/app/domain/entity/general_entities.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'especialidad_entity.dart';

class Medico extends Equatable {
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
  final Direccion? direccion;
  final String? estado;
  final String? urlImagen;
  final Especialidad? especialidad;
  final String? nombreCompleto;

  const Medico({
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
    this.direccion,
    this.estado,
    this.urlImagen,
    this.especialidad,
    this.nombreCompleto,
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
        "direccion": direccion?.toJson(),
        "estado": estado,
        "urlImagen": urlImagen,
        "especialidad": especialidad?.toJson(),
        "nombreCompleto": nombreCompleto,
      };

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

  String get formattedCreatedDate => formatFecha(createdDate);
  String get formattedLastModifiedDate => formatFecha(lastModifiedDate);

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
        direccion,
        estado,
        urlImagen,
        especialidad,
        nombreCompleto,
      ];
}
